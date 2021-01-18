'''
Originally from: https://developers.google.com/optimization/cp/cp_solver
Commented: ccs
How to use:
  solver = cp_model.CpSolver()
  solution_printer = VarArraySolutionPrinter([x, y, z])
  status = solver.SearchForAllSolutions(model, solution_printer)

'''
from ortools.sat.python import cp_model
class VarArraySolutionPrinter(cp_model.CpSolverSolutionCallback):
    """Print intermediate solutions."""

    def __init__(self, variables):
        cp_model.CpSolverSolutionCallback.__init__(self)
        self.__variables = variables
        self.__solution_count = 0

    def on_solution_callback(self):
        self.__solution_count += 1
        for v in self.__variables:
            print('%s=%i' % (v, self.Value(v)), end=' ')
        print()

    def solution_count(self):
        return self.__solution_count