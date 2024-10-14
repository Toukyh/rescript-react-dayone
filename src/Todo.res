type todoId = int
type todo = {
  id: todoId,
  done: bool,
  label: string,
}

let make = (~label: string): todo => {
  id: Math.Int.random(0, Js.Int.max),
  done: false,
  label,
}
