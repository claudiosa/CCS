"""Simple solve::: from Google adapted by CCS"""

# [START program]
"""
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
"""

from ortools.sat.python import cp_model


def Simple_Program_MODEL():
    """Minimal CP-SAT example to showcase calling the solver."""
    # Creates the model.
    # [START model]
    model = cp_model.CpModel()
    # [END model]

    # Creates the variables.
    # [START variables]
    num_vals = 3
    x = model.NewIntVar(0, num_vals - 1, 'x')
    y = model.NewIntVar(0, num_vals - 1, 'y')
    z = model.NewIntVar(0, num_vals - 1, 'z')
    # [END variables]

    # Creates the constraints.
    # [START constraints]
    model.Add(x != y)
    # [END constraints]

    # Creates a solver and solves the model.
    # [START solve]
    solver = cp_model.CpSolver()
    status = solver.Solve(model)
    # [END solve]

    if status == cp_model.FEASIBLE:
        print_Solution(solver.Value(x), solver.Value(y), solver.Value(z))
	
######################################
def print_Solution(X, Y, Z):
	print("\n Showing the Answers: ")   
	print('x = ' , X  )
	print('y = ', Y  )
	print('z = ' , Z )


######################################

if __name__ == '__main__':
	Simple_Program_MODEL()
# [END program]