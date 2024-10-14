// module State = {
//   type t = {
//     newInputValue: string,
//     todos: array<Todo.todo>,
//   }

//   type actions = Add | Delete(Todo.todoId) | ToggleDone(Todo.todoId) | UpdatedInput(string)

//   let initialState = {
//     newInputValue: "",
//     todos: [],
//   }

//   let reducer = (state, action): t => {
//     switch action {
//     | Add => {
//         newInputValue: "",
//         todos: [...state.todos, Todo.make(~label=state.newInputValue)],
//       }
//     | Delete(id) => {
//         ...state,
//         todos: state.todos->Array.filter(v => v.id != id),
//       }
//     | ToggleDone(id) => {
//         ...state,
//         todos: state.todos->Array.map(todo => {
//           if todo.id != id {
//             todo
//           } else {
//             {...todo, done: !todo.done}
//           }
//         }),
//       }
//     | UpdatedInput(newValue) => {
//         ...state,
//         newInputValue: newValue,
//       }
//     }
//   }
// }

@react.component
let make = () => {
  // let (state, dispatch) = React.useReducer(State.reducer, State.initialState)

  // let bacon = Bacon.Data(["foo", "bar"])
  let (bacon, setBacon) = React.useState(() => Bacon.Loading) //  new

  let handleBacon = () => Bacon.fetch()->then(t => setBacon(_ => t)->resolve)

  /* new */
  React.useEffect0(() => {
    let _ = handleBacon() // we assign this to _ since we aren't returning it
    None // we have nothing to clean up so we return None
  })

  React.useEffect1(() => {
    Console.log(bacon)
    None
  }, [bacon])

  <div className="p-6">
    <h1 className="text-3xl font-semibold mb-5"> {"Bacon Ipsum"->React.string} </h1>
    <Button
      onClick={_ => {
        let _ = handleBacon()
      }}>
      {"refresh data"->React.string}
    </Button>
    {bacon->Bacon.render}
  </div>

  // <div className="p-6">
  //   <h1 className="text-3xl text-red-800 font-semibold"> {"Todo List"->React.string} </h1>
  //   <input
  //     className="border-2 rounded-lg border-blue-500 p-1 mx-2 text-black"
  //     value=state.newInputValue
  //     onChange={e => {
  //       ReactEvent.Form.currentTarget(e)["value"]->UpdatedInput->dispatch
  //       // let newValue = ReactEvent.Form.currentTarget(e)["value"]
  //       // dispatch(UpdatedInput(newValue))
  //     }}
  //   />
  //   <Button onClick={_ => dispatch(Add)}> {React.string("Add Todo")} </Button>
  //   {state.todos
  //   ->Array.map(todo => {
  //     <div
  //       className={`${todo.done ? "text-green-500" : "text-red-600"} cursor-pointer`}
  //       onDoubleClick={_ => dispatch(Delete(todo.id))}
  //       onClick={_ => dispatch(ToggleDone(todo.id))}>
  //       {React.string(todo.label)}
  //     </div>
  //   })
  //   ->React.array}
  // </div>
}
