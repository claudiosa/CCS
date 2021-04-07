from z3 import *

## Declare variables
x, y, z = Reals('x y z')

## Creating an object s for this solver -- from method Solver( )
s = Solver() 

## Adding some constraints
## s.add(x > 1, Or(y > 1, z > 1), x + y > 3, z - x < 10)
## OR
c1 = [x > 1]
c2 = [Or(y > 1, z > 1)]
c3 = [x + y > 3]
c4 = [z - x < 10]

constraints = c1+c2+c3+c4

## the constraint must be posted .... and s takes 
## a new value to the solver
s.add(constraints)
### printing them
print("Asserted constraints...")
for c in s.assertions():
    print(c)
print(s)
print("\n Constraints %s:" % constraints)

print("\n If exist a solution...")
print(s.check())

print("Producing a model m from object s ...")
m = s.model()
print(m)
sol = list(map(m.evaluate, (x,y,z) ))
print(sol)

print("\nTraversing model...")
for d in m.decls():
    print("%s = %s" % (d.name(), m[d]))

print("\nStatistics for the last check method...")
print(s.statistics())
# Traversing statistics
for k, v in s.statistics():
    print( "%s : %s"%(k, v) )
########################################################