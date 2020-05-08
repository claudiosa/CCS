#### BY CCS to studies

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# model_most_money
def model_CIRCUIT():
    n  = 7  #  number of nodes ( n x n matrix)
    the_model = cp_model.CpModel()

    tour = [ 
            the_model.NewIntVar(0, (n-1), 'tour' ) 
            for i in range(n)
            ]
    
    a =  the_model.NewBoolVar('a')
    b =  the_model.NewBoolVar('b')
    ### TESTING
    the_model.AddAllDifferent( tour )
    ## to do
    # the_model.Add(is_a_circuit( tour, the_model ) == True)
   


    ## ONLY if a True ...  
    the_model.Add(  a == True)
    the_model.Add( tour[2] + tour[3] == 7).OnlyEnforceIf(a)
   

    ## ONLY if a False ... 
    the_model.Add( tour[0] + tour[1] == 7).OnlyEnforceIf(b.Not())
    the_model.Add(  b == False)
      
    #the_model.AddBoolOr([a.Not(),b.Not()]) ## DEFAULT is True
    the_model.AddBoolAnd([a , b.Not()]) ## DEFAULT is True
   
        
    
 ####   ################################################
    ## VERY important ....
    ## take care with the branch in TOUR
     # Search for x values in increasing order.
    the_model.AddDecisionStrategy(tour, cp_model.CHOOSE_FIRST, 
                              cp_model.SELECT_MIN_VALUE)
    
   # Create a solver and solve with a fixed search.
    solver_OUT = cp_model.CpSolver()

    # Force the solver to follow the decision strategy exactly.
    solver_OUT.parameters.search_branching = cp_model.FIXED_SEARCH
   
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)
####################################################    
    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
        my_print_VARS( a, b, tour, n, solver_OUT  )
        
    elif (status == cp_model.INFEASIBLE) :   ##não é UNFEASIBLE 
        print(" INSATISFATÍVEL ")
        raise ValueError("No solution was found for the given input values")

    elif (status == cp_model.UNKNOWN) :
        raise ValueError("The status of the model is unknown because a search limit was reached. ")
    
    else:
        raise ValueError(" .... INVALID  MODEL ....")                        
    
    ### end of if ....
    print("END SOLVER and MODEL ")
    print_t(40)
    return 
###### end function MODEL

def is_a_circuit(x, the_model):
    
    the_model.AddAllDifferent( x )
    n = len(x)
    step, i = 0 , 0 ### any position
    v = []
    v = [0  for i in range(n)]    
    v[i] = 1 ## mark sequentially
    
    while (step < n):
        #solver.AddElement(z[i-1] , x, z[i])

        next = the_model.x[i]
        #the_model.Add(next == x[i])
        v[next] = 1
        i = next
        step = step + 1
        #print(f'i: %i \t next: %i \t step: %i v: %s ' %(i, next, step, v))
        
    if ( sum(v) == n ):
        return True
    else:
        return False
##############################

### PRINTING FUNCTION
## learning Python
def my_print_VARS( a, b,  tour, n, solver_OUT ):

    print('A : ', solver_OUT.Value(a) )
    print('B : ', solver_OUT.Value(b) )
    print("\n ============== SEQUENCE OF NODES ========= ") 
    print('TOUR : ', [solver_OUT.Value(tour[i]) for i in range(n)] )
   
    ## learning Python            
        
    print('\n\n** Final Statistics **')
    print('  - conflicts : %i' % solver_OUT.NumConflicts())
    print('  - branches  : %i' % solver_OUT.NumBranches())
    print('  - wall time : %f s' % solver_OUT.WallTime())
    print('  - user time : %f s' % solver_OUT.UserTime())
    print("\n END PRINTING \n===================================")
    return ###### end function

# =====================================================================================
#### reports =================

######### TO BE IMPROVED

## learning Python
def print_t(n):
    print()
    for i in range(n):
        print('=', end="")
    print()
    return

if __name__ == '__main__':
    print("\n=============== RESULTS ====================")
    model_CIRCUIT()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ', end="")
    print_t(40)
    # return ###### end function 



'''
    
def AddInverse(self, variables, inverse_variables)
Adds Inverse(variables, inverse_variables).

# An inverse constraint enforces that if variables[i] is assigned a value j, then inverse_variables[j] is assigned a value i. And vice versa.
'''