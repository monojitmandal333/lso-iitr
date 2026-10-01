\ Chorded C5: cycle 1-2-3-4-5-1 plus chord 1-4

Maximize
 obj: x1 + x2 + x3 + x4 + x5

Subject To
 e12: x1 + x2 <= 1
 e23: x2 + x3 <= 1
 e34: x3 + x4 <= 1
 e45: x4 + x5 <= 1
 e51: x5 + x1 <= 1
 chord14: x1 + x4 <= 1

Binaries
 x1 x2 x3 x4 x5

End
