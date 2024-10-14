type t

type error

type bacon =
  | Loading
  | Error(error)
  | Data(t)

let fetch: unit => Promise.t<bacon>
let render: bacon => React.element
