from z3 import *
v = Real('v')
clause1 = Or(v**2>10, v+1>3)
clause2 = Or(v**2<=10, v<1)
formula = And(clause1, clause2)
solve(formula)

formula2 = And(clause1, clause2, v!=3)
ans = solve(formula2)

s = Solver()
s.add(formula)
ans=s.check()
if ans==sat:
  print(s.model())
else:
  print("no solution")
