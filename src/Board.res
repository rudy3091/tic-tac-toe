type tileIndex = (int, int)
type tileState =
  | Empty
  | HasO
  | HasX

type state = array<(tileIndex, tileState)>

let new = () => {
  let arr = []
  for i in 1 to 9 {
    Js.Array.push(((i / 3, mod(i, 3)), Empty), arr)->ignore
  }
  arr
}

let tileForPlayer = (p: Player.player) => {
  switch p {
  | Player.PlayerO => HasO
  | Player.PlayerX => HasX
  }
}

let getBoard = prev => {
  switch prev {
  | None => new()
  | Some(b) => b
  }
}
