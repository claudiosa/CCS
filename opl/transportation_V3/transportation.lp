\ENCODING=ISO-8859-1
\Problem name: transportation_V3

Minimize
 obj: objective_function
Subject To
 c1:  VAR_Ship(1)(1) + VAR_Ship(1)(2) + VAR_Ship(1)(3)  = 5
 c2:  VAR_Ship(2)(1) + VAR_Ship(2)(2) + VAR_Ship(2)(3)  = 7
 c3:  VAR_Ship(3)(1) + VAR_Ship(3)(2) + VAR_Ship(3)(3)  = 3
 c4:  VAR_Ship(1)(1) + VAR_Ship(2)(1) + VAR_Ship(3)(1) <= 7
 c5:  VAR_Ship(1)(2) + VAR_Ship(2)(2) + VAR_Ship(3)(2) <= 3
 c6:  VAR_Ship(1)(3) + VAR_Ship(2)(3) + VAR_Ship(3)(3) <= 5
 c7:  VAR_Ship(1)(1) + VAR_Ship(1)(2) + VAR_Ship(1)(3) + VAR_Ship(2)(1)
      + VAR_Ship(2)(2) + VAR_Ship(2)(3) + VAR_Ship(3)(1) + VAR_Ship(3)(2)
      + VAR_Ship(3)(3) >= 0
 c8:  VAR_Ship(1)(1) + VAR_Ship(1)(2) + VAR_Ship(1)(3) + VAR_Ship(2)(1)
      + VAR_Ship(2)(2) + VAR_Ship(2)(3) + VAR_Ship(3)(1) + VAR_Ship(3)(2)
      + VAR_Ship(3)(3) >= 0
 c9:  VAR_Ship(1)(1) + VAR_Ship(1)(2) + VAR_Ship(1)(3) + VAR_Ship(2)(1)
      + VAR_Ship(2)(2) + VAR_Ship(2)(3) + VAR_Ship(3)(1) + VAR_Ship(3)(2)
      + VAR_Ship(3)(3) >= 0
 c10: VAR_Ship(1)(1) + VAR_Ship(1)(2) + VAR_Ship(1)(3) + VAR_Ship(2)(1)
      + VAR_Ship(2)(2) + VAR_Ship(2)(3) + VAR_Ship(3)(1) + VAR_Ship(3)(2)
      + VAR_Ship(3)(3) >= 0
 c11: VAR_Ship(1)(1) + VAR_Ship(1)(2) + VAR_Ship(1)(3) + VAR_Ship(2)(1)
      + VAR_Ship(2)(2) + VAR_Ship(2)(3) + VAR_Ship(3)(1) + VAR_Ship(3)(2)
      + VAR_Ship(3)(3) >= 0
 c12: VAR_Ship(1)(1) + VAR_Ship(1)(2) + VAR_Ship(1)(3) + VAR_Ship(2)(1)
      + VAR_Ship(2)(2) + VAR_Ship(2)(3) + VAR_Ship(3)(1) + VAR_Ship(3)(2)
      + VAR_Ship(3)(3) >= 0
 c13: VAR_Ship(1)(1) + VAR_Ship(1)(2) + VAR_Ship(1)(3) + VAR_Ship(2)(1)
      + VAR_Ship(2)(2) + VAR_Ship(2)(3) + VAR_Ship(3)(1) + VAR_Ship(3)(2)
      + VAR_Ship(3)(3) >= 0
 c14: VAR_Ship(1)(1) + VAR_Ship(1)(2) + VAR_Ship(1)(3) + VAR_Ship(2)(1)
      + VAR_Ship(2)(2) + VAR_Ship(2)(3) + VAR_Ship(3)(1) + VAR_Ship(3)(2)
      + VAR_Ship(3)(3) >= 0
 c15: VAR_Ship(1)(1) + VAR_Ship(1)(2) + VAR_Ship(1)(3) + VAR_Ship(2)(1)
      + VAR_Ship(2)(2) + VAR_Ship(2)(3) + VAR_Ship(3)(1) + VAR_Ship(3)(2)
      + VAR_Ship(3)(3) >= 0
 c16: objective_function - 3 VAR_Ship(1)(1) - VAR_Ship(1)(2)
      - 9999 VAR_Ship(1)(3) - 4 VAR_Ship(2)(1) - 2 VAR_Ship(2)(2)
      - 4 VAR_Ship(2)(3) - 9999 VAR_Ship(3)(1) - 3 VAR_Ship(3)(2)
      - 3 VAR_Ship(3)(3)  = 0
Bounds
      objective_function Free
 0 <= VAR_Ship(1)(1) <= 9999
 0 <= VAR_Ship(1)(2) <= 9999
 0 <= VAR_Ship(1)(3) <= 9999
 0 <= VAR_Ship(2)(1) <= 9999
 0 <= VAR_Ship(2)(2) <= 9999
 0 <= VAR_Ship(2)(3) <= 9999
 0 <= VAR_Ship(3)(1) <= 9999
 0 <= VAR_Ship(3)(2) <= 9999
 0 <= VAR_Ship(3)(3) <= 9999
Generals
 objective_function  VAR_Ship(1)(1)  VAR_Ship(1)(2)  VAR_Ship(1)(3) 
 VAR_Ship(2)(1)  VAR_Ship(2)(2)  VAR_Ship(2)(3)  VAR_Ship(3)(1) 
 VAR_Ship(3)(2)  VAR_Ship(3)(3) 
End
