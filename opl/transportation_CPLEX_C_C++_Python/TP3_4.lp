\ Transportation problem 
Minimize 

\ First objective is defined
+ 10 x1x1 + 2  x1x2 + 20 x1x3   + 11 x1x4 
+ 12 x2x1 + 7  x2x2 + 9  x2x3   + 20 x2x4 
+ 4  x3x1 + 14 x3x2 + 16 x3x3   + 18 x3x4

 s.t.

\ Row assignment constraints
+ x1x1 + x1x2 + x1x3 + x1x4 = 15
+ x2x1 + x2x2 + x2x3 + x2x4 = 25
+ x3x1 + x3x2 + x3x3 + x3x4 = 10

\ Column assignment constraints
+ x1x1 + x2x1 + x3x1 = 5
+ x1x2 + x2x2 + x3x2 = 15
+ x1x3 + x2x3 + x3x3 = 15
+ x1x4 + x2x4 + x3x4 = 15
\ Binary constraints
BINARY
x1x1
x1x2
x1x3
x1x4
x2x1
x2x2
x2x3
x2x4
x3x1
x3x2
x3x3
x3x4
END
