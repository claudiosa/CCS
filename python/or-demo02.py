

#https://github.com/google/or-tools/tree/stable/ortools/linear_solver/samples
"""Minimal example to call the GLOP solver."""
# [START program]
# [START import]
from __future__ import print_function
from ortools.linear_solver import pywraplp
# [END import]

'''
$ python or-demo02.py 
Number of variables = 2
Number of constraints = 1
Solution:
Objective value = 4.0
x = 1.0
y = 1.0
https://github.com/google/or-tools/blob/stable/ortools/linear_solver/samples/simple_lp_program.py
'''
def main():
    # [START solver]
    # Create the linear solver with the GLOP backend.
    solver = pywraplp.Solver('simple_lp_program',
                             pywraplp.Solver.GLOP_LINEAR_PROGRAMMING)
    # [END solver]

    # [START variables]
    # Create the variables x and y.
    x = solver.NumVar(0, 1, 'x')
    y = solver.NumVar(0, 2, 'y')

    print('Number of variables =', solver.NumVariables())
    # [END variables]

    # [START constraints]
    # Create a linear constraint, 0 <= x + y <= 2.
    ct = solver.Constraint(0, 2, 'ct')
    ct.SetCoefficient(x, 1)
    ct.SetCoefficient(y, 1)

    print('Number of constraints =', solver.NumConstraints())
    # [END constraints]

    # [START objective]
    # Create the objective function, 3 * x + y.
    objective = solver.Objective()
    objective.SetCoefficient(x, 3)
    objective.SetCoefficient(y, 1)
    objective.SetMaximization()
    # [END objective]

    # [START solve]
    solver.Solve()
    # [END solve]

    # [START print_solution]
    print('Solution:')
    print('Objective value =', objective.Value())
    print('x =', x.solution_value())
    print('y =', y.solution_value())
    # [END print_solution]


if __name__ == '__main__':
    main()
# [END program]
