Maximize
  obj: x1 + x2 + x3 + x4 + x5

Subject To
  R12: x1 + x2 - x5 <= 1
  R23: x2 + x3 - x5 <= 1
  R34: x3 + x4 - x5 <= 1
  R14: x1 + x4 - x5 <= 1
  R15: x1 + x5 - x2 - x4 <= 1
  R25: x2 + x5 - x1 - x3 <= 1
  R35: x3 + x5 - x2 - x4 <= 1
  R45: x4 + x5 - x1 - x3 <= 1
  R13: 2 x1 + 2 x3 - x2 - x4 - x5 <= 2
  R24: 2 x2 + 2 x4 - x1 - x3 - x5 <= 2

Bounds

Binaries
  x1 x2 x3 x4 x5

End
