Maximize
  obj: x1 + x2 + x3 + x4

Subject To
  R13: x1 + x3 - x4 <= 1
  R14: x1 + x4 - x3 <= 1
  R23: x2 + x3 - x4 <= 1
  R24: x2 + x4 - x3 <= 1
  R34: x3 + x4 - x1 - x2 <= 1
  R12: 2 x1 + 2 x2 - x3 - x4 <= 2

Bounds

Binaries
  x1 x2 x3 x4

End
