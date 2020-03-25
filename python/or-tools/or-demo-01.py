'''
Problem:
Maximize 3x + y subject to the following constraints:
0	≤	x	≤	1
0	≤	y	≤	2
x + y	≤	2

https://developers.google.com/optimization/introduction/python

Use:
$ python or-demo01.py 
Number of variables = 2
Number of constraints = 1
Solution:
Objective value = 4.0
x = 1.0
y = 1.0
[ccs@gerzat python]$ 
 FAST ...

'''

from __future__ import print_function
from ortools.linear_solver import pywraplp



def main():
    # Create the linear solver with the GLOP backend.
    solver = pywraplp.Solver('simple_lp_program',
                             pywraplp.Solver.GLOP_LINEAR_PROGRAMMING)

    # Create the variables x and y.
    x = solver.NumVar(0, 1, 'x')
    y = solver.NumVar(0, 2, 'y')

    print('Number of variables =', solver.NumVariables())

    # Create a linear constraint, 0 <= x + y <= 2.
    ct = solver.Constraint(0, 2, 'ct')
    ct.SetCoefficient(x, 1)
    ct.SetCoefficient(y, 1)

    print('Number of constraints =', solver.NumConstraints())

    # Create the objective function, 3 * x + y.
    objective = solver.Objective()
    objective.SetCoefficient(x, 3)
    objective.SetCoefficient(y, 1)
    objective.SetMaximization()

    solver.Solve()

    print('Solution:')
    print('Objective value =', objective.Value())
    print('x =', x.solution_value())
    print('y =', y.solution_value())


if __name__ == '__main__':
    main()
