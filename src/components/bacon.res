type t = array<string>

type error = string

type bacon =
  | Loading
  | Error(error)
  | Data(t)

let baconStruct = S.array(S.string)

let constructBacon = x => {
  // we use parseAnyWith because we the data coming from our fetch request will be of an unknown type
  let val = x->S.parseWith(baconStruct)
  // val will be a Result, which is either OK or an Error
  // we can map this to internal values of Bacon.Data or Bacon.Error
  switch val {
  | Ok(a) => Data(a)
  | Error(e) => Error(e->S.Error.message)
  }
}

let url = "https://baconipsum.com/api/?type=meat-and-filler"

let fetch = () => {
  Fetch.fetch(url)
  ->then(res =>
    switch res->Fetch.Response.ok {
    | true => res->Fetch.Response.json->then(res => res->constructBacon->resolve) // every Promise in ReScript has to return another Promise
    | false =>
      Error(
        `${res->Fetch.Response.status->Int.toString}: ${res->Fetch.Response.statusText}`,
      )->resolve
    }
  )
  ->catch(_ => Error("Something went wrong")->resolve)
}

let render = bacon =>
  switch bacon {
  | Loading => <p className="my-3"> {React.string("loading...")} </p>
  | Error(err) => <p className="my-3"> {React.string(err)} </p>
  | Data(data) =>
    data->Array.map(text => <p key={text} className="my-3"> {React.string(text)} </p>)->React.array
  }
