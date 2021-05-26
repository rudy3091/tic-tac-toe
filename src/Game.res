type state = {
  board: Board.state,
  currentPlayer: Player.player,
}

let chooseRandomMove = () => Js.Math.random_int(0, 9)

let applyMove = (game, i) => {
  let {board, currentPlayer} = game
  let board = Js.Array2.mapi(board, (cell, idx) => {
    if idx === i {
      let ((x, y), _) = cell
      switch currentPlayer {
      | PlayerO => ((x, y), Board.tileForPlayer(currentPlayer))
      | PlayerX => ((x, y), Board.tileForPlayer(currentPlayer))
      }
    } else {
      cell
    }
  })
  {
    board: board,
    currentPlayer: Player.next(currentPlayer),
  }
}

let isGameDone = game => {
  let openSlots = Js.Array2.filter(game.board, cell => {
    let (_, state) = cell
    switch state {
    | Board.HasO | Board.HasX => false
    | Board.Empty => true
    }
  })
  openSlots->Js.Array.length === 0
}

let resolveTurn = round => {
  let round = switch round {
  | None => {
      board: Board.new(),
      currentPlayer: Player.PlayerX,
    }
  | Some(round) => round
  }
  let i = chooseRandomMove()
  let round = applyMove(round, i)
  (round, isGameDone(round))
}

let rec start = round => {
  let round = resolveTurn(round)
  switch round {
  | (endgame, true) =>
    Js.log("Game Over!")
    Js.log(endgame)
  | (game, false) => start(Some(game))
  }
}
