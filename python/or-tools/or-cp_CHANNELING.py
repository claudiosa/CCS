# from __future__ import print_function
# from ortools.constraint_solver import pywrapcp
# TOY PROGRAM to illustrate the CP
from ortools.sat.python import cp_model

# a main function about a model

def channeling_example():

    # Create the model.
    # the_model is an object created by cp_model method from  CpModel class
    the_model = cp_model.CpModel()  # 'Channeling Example')

    #
    # data
    #
    n = 3  # a constant ... not var

    #
    # Creating CP variables
    #
    vetor_BOOL = [the_model.NewBoolVar('vetor_BOOL[%i]' % i) for i in range(n)]
    # bool_var_array

    # Other vars in the_model created by the method NewIntVar
    x = the_model.NewIntVar(0, 10, 'x')
    y = the_model.NewIntVar(0, 10, 'y')
    z = the_model.NewIntVar(0, 10, 'z')
    # NewIntVar(self, lb, ub, name)
    #
    # constraints
    #
    ###
    # x >= 5 and x < 10 then write as:
    the_model.Add(x >= 5) 
    the_model.Add(x < 10)
    ###the_model.Add(y >= 8 and y <= 10)  .... NOT WORKS
    the_model.Add(y > 8) . OnlyEnforceIf ( vetor_BOOL[1] ) 
    the_model.Add( y <= 10 ) . OnlyEnforceIf (vetor_BOOL[1].Not()  ) 
    the_model.Add(z > 7)
    the_model.Add((vetor_BOOL[0] and vetor_BOOL[1] and vetor_BOOL[2]) == True) #### NOT WORKS
    the_model.Add(sum(vetor_BOOL) > 1)
    
    #
    # search and result
    # Search for x values in increasing order.
    the_model.AddDecisionStrategy(vetor_BOOL, cp_model.CHOOSE_FIRST,
                              cp_model.SELECT_MIN_VALUE)
    ## Very interesting Decision Strategy 
    #
    # Create a solver and solve with a fixed search.
    solver = cp_model.CpSolver()
    #solver.parameters.max_time_in_seconds = 10.0
    status = solver.Solve(the_model)
    ### 
    #values_vetor_BOOL = [solver.Value(vetor_BOOL[i]) for i in range(n)]    
    ### VERY BIZARRE
    if (status == cp_model.FEASIBLE):
      print_output_VARS(solver.Value(x), solver.Value(y), solver.Value(z), 
                        [solver.Value(vetor_BOOL[i]) for i in range(n)])
    else:
      print ("NOT OK: ", solver.StatusName(status))
      return

    #print('vetor_BOOL:', [solver.Value(vetor_BOOL[i]) for i in range(n)])

    print('\n\n** Final Statistics **')
    print('  - conflicts : %i' % solver.NumConflicts())
    print('  - branches  : %i' % solver.NumBranches())
    print('  - wall time : %f s' % solver.WallTime())
    print("\n END SOLVER ===================================")

def print_output_VARS(X ,Y ,Z , vetor):
    #, vetor_BOOL):
    print("\n Showing the Answers: ")   
    print('x = ' , X  )
    print('y = ' , Y  )
    print('z = ' , Z )
    n = int(len(vetor))
    print('vetor_BOOL:', [vetor[i] for i in range(n)])
    # print('vetor_BOOL:', [solver.Value(vetor_BOOL[i]) for i in range(n)])
    # print('vetor_BOOL:', [solver.BoolValue(vetor_BOOL[i]) for i in range(n)])
    print("\n END FUNCTION ===================================")
   
# main program ....
if __name__ == '__main__':
  channeling_example()
  print("\n END MAIN ===================================")


'''
  model.Add(x >= 5).OnlyEnforceIf( vetor_BOOL[0] ) 
  model.Add(8 >= y).OnlyEnforceIf( vetor_BOOL[1] ) 
  model.Add(z > 7).OnlyEnforceIf ( vetor_BOOL[2] ) 
'''

