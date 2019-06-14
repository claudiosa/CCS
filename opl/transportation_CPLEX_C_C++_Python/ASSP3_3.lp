\ Objective function sense defines the sense of assingment objectives

Minimize
+ 1296 x1x1 +  415 x1x2 + 1936 x1x3 
+  353 x2x1 + 1047 x2x2 +  191 x2x3 
+  900 x3x1 +  148 x3x2 + 2213 x3x3 

 s.t.

\ Row assignment constraints
+ x1x1 + x1x2 + x1x3 = 1
+ x2x1 + x2x2 + x2x3 = 1
+ x3x1 + x3x2 + x3x3 = 1

\ Column assignment constraints
+ x1x1 + x2x1 + x3x1 = 1
+ x1x2 + x2x2 + x3x2 = 1
+ x1x3 + x2x3 + x3x3 = 1
\ Binary constraints
BINARY
x1x1
x1x2
x1x3
x2x1
x2x2
x2x3
x3x1
x3x2
x3x3
END
