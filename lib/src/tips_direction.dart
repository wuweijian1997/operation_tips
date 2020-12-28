enum TipsDirection {
  ///Display at the top first,If the top height is insufficient, it will be displayed at the bottom.
  top,

  ///Display at the left first,If the left height is insufficient, it will be displayed at the right.
  left,

  ///Display at the bottom first,If the bottom height is insufficient, it will be displayed at the top.
  bottom,

  ///Display at the right first,If the right height is insufficient, it will be displayed at the left.
  right,

  ///Give priority to the top and bottom height positions
  vertical,
  ///Give priority to the left and right width positions
  horizontal,
}
