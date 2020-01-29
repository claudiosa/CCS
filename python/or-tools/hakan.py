from __future__ import print_function
import sys
from ortools.constraint_solver import pywrapcp


def minus(solver, x, y, z):
  solver.Add(z == abs(x - y))


def main():

  # Create the solver.
  solver = pywrapcp.Solver('Olympic')

  #
  # data
  #
  n = 10

  #
  # declare variables
  #
  Vars = [solver.IntVar(1, n, 'Vars[%i]' % i) for i in range(n)]
  X1, X2, X3, X4, X5, X6, X7, X8, X9, X10 = Vars

  #
  # constraints
  #
  solver.Add(solver.AllDifferent(Vars))

  solver.Add(X1 == 3)
  minus(solver, X2, X3, X1)
  minus(solver, X4, X5, X2)
  minus(solver, X5, X6, X3)
  minus(solver, X7, X8, X4)
  minus(solver, X8, X9, X5)
  minus(solver, X9, X10, X6)

  #
  # solution and search
  #
  db = solver.Phase(Vars, solver.INT_VAR_SIMPLE, solver.INT_VALUE_DEFAULT)

  solver.NewSearch(db)

  num_solutions = 0
  while solver.NextSolution():
    num_solutions += 1
    print('Vars:', [Vars[i].Value() for i in range(n)])

  print()
  print('num_solutions:', num_solutions)
  print('failures:', solver.Failures())
  print('branches:', solver.Branches())
  print('WallTime:', solver.WallTime(), 'ms')


if __name__ == '__main__':
  main()