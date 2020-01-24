#from __future__ import print_function
# from ortools.constraint_solver import pywrapcp
from ortools.sat.python import cp_model


def channeling_example():

  # Create the model.
  model = cp_model.CpModel() #'Channeling Example')

  #
  # data
  #
  n = 3  # number of speakers
 
  #
  # variables
  #
  vetor_BOOL = [ model.NewBoolVar( 'vetor_BOOL[%i]' % i) for i in range(n) ]
  ##bool_var_array
  x = model.NewIntVar(0, 10, 'x')
  y = model.NewIntVar(0, 10, 'y')
  z = model.NewIntVar(0, 10, 'z')
  ## NewIntVar(self, lb, ub, name)
  #
  # constraints
  #
  ### Erro aqui ....
  ### x >= 5 then vetor_Bool[0] <- true
  model.Add(x >= 5).OnlyEnforceIf( vetor_BOOL[0] ) 
  model.Add(8 >= y).OnlyEnforceIf( vetor_BOOL[1] ) 
  model.Add(z > 7).OnlyEnforceIf ( vetor_BOOL[2] ) 
  
  model.Add((vetor_BOOL[0] and vetor_BOOL[0] and vetor_BOOL[0]) == True)
  
  #
  # search and result
  #
  # Create a solver and solve with a fixed search.
  solver = cp_model.CpSolver()
  solver.parameters.max_time_in_seconds = 10.0
  status = solver.Solve(model)
  print ("OK or NOT: ", solver.StatusName(status))
  
  print('x = %i' % solver.Value(x))
  print('y = %i' % solver.Value(y))
  print('z = %i' % solver.Value(z))
  print('V = %i' % solver.Value(vetor_BOOL))
  ##print('vetor_BOOL:', [vetor_BOOL[i] for i in range(n)])
  print('vetor_BOOL:', [solver.Value(vetor_BOOL[i]) for i in range(n)])
  #print('vetor_BOOL:', [solver.BoolValue(vetor_BOOL[i]) for i in range(n)])
  print('\n\n** Statistics **')
  print('  - conflicts : %i' % solver.NumConflicts())
  print('  - branches  : %i' % solver.NumBranches())
  print('  - wall time : %f s' % solver.WallTime())
  

if __name__ == '__main__':
  channeling_example()