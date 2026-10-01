\ Example 3: Odd wheel with hub 1 and rim 2-3-4-5-6-2

Maximize
 obj: x1 + x2 + x3 + x4 + x5 + x6

Subject To
 r23: x2 + x3 <= 1
 r34: x3 + x4 <= 1
 r45: x4 + x5 <= 1
 r56: x5 + x6 <= 1
 r62: x6 + x2 <= 1
 h12: x1 + x2 <= 1
 h13: x1 + x3 <= 1
 h14: x1 + x4 <= 1
 h15: x1 + x5 <= 1
 h16: x1 + x6 <= 1

Binaries
 x1 x2 x3 x4 x5 x6

End
