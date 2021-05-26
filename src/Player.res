type player =
  | PlayerO
  | PlayerX

let next = prev => {
  switch prev {
  | PlayerO => PlayerX
  | PlayerX => PlayerO
  }
}
