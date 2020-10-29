#### BY CCS
'''
Problem Formulation 

These taskies  = [ A, B, C, D, E , F ] ,
will start from  0 . . 20 unit time
Duration = [3 ,4 ,2 ,3 ,2 ,3] ,
Usage = [ 2 , 2 , 2 , 1 , 2 , 1 ] ,
Limit = 4 ,
'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# model_FUNCTION
def model_small_jbs():
    
    ## creating a model
    the_model = cp_model.CpModel()
    
    # Data
    duration =  [3 ,4 ,2 ,3 ,2 ,3]
    usage = [ 2 , 2 , 2 , 1 , 2 , 1 ]
    #resource_limitation = 4
    max_time = 20
    n = len (duration)
    
    #### VARIABLES
    ## array[1..n, 1..n] of var 0..1: x; % the resulting matrix, 1 if connected, 0 else
    ## the resulting connection matrix
    start_t =[the_model.NewIntVar(0, max_time, 'start_t[i]' )  \
             for i in range(n) ]
    end_t =[the_model.NewIntVar(0, max_time, 'end_t[i]' )  \
             for i in range(n) ]              
    
    capacity = the_model.NewIntVar(0, 4, "capacity") # can only cook one meal at a time   
    ## see the Taha books'
    # CONSTRAINTS ADDED of the problem
            
    ### 
    ##for i in  range(n) :
    the_model.Add( start_t[0] <= start_t[2] )
    the_model.Add( start_t[2] <= start_t[4] )
    the_model.Add( start_t[1] <= start_t[5] )
    the_model.Add( start_t[1] <= start_t[3] )
   
    ## IF M exist then ... no connection i in this pair i,j ... once M is LARGER
    ## no connection in x
    
    ##the_model.AddCumulative(intervals, demands, capacity)
    #the_model.AddCumulative(duration, usage, capacity)

    for i in range(n) :
        the_model.Add(start_t[i] + duration[i] == end_t[i])

   
  # Create and add disjunctive constraints.
  #  for i in range(n) :
  #      the_model.AddNoOverlap(start_t[i])


  ###AddCumulative(self, intervals, demands, capacity)
    ### optmization  function or objective function 
    # OR:  the_model.Maximize(-less_DIF) 
#    the_model.Minimize( f_objective )

    ### data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)
    '''
    db = solver.Phase(x, solver.INT_VAR_DEFAULT, solver.INT_VALUE_DEFAULT)
    '''
    
    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
       my_print_VARS( start_t, end_t,  solver_OUT )
        
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
    return ###### end function


### PRINTING FUNCTION
## learning Python
def my_print_VARS( x, y,  solver_OUT):

    n = len (x)
    print('Start Time : ', [solver_OUT.Value(x[i]) for i in range(n)] )
    print('End Time : ', [solver_OUT.Value(y[i]) for i in range(n)] )
       
    print("\n ===================================")
    
    ####### HEADLINE -- TOP of matrix
    
   


## learning Python            
        
    print('\n\n** Final Statistics **')
    print('  - conflicts : %i' % solver_OUT.NumConflicts())
    print('  - branches  : %i' % solver_OUT.NumBranches())
    print('  - wall time : %f s' % solver_OUT.WallTime())
    print("\n END PRINTING \n===================================")
    return ###### end function

# =====================================================================================
#### reports =================



## learning Python
def print_t(n):   ## imprime  n tracejados
    print()
    for i in range(n):
        print('=', end="")
    print()
    return

if __name__ == '__main__':
    print("\n=============== RESULTS ====================")
    model_small_jbs()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ', end="")
    print_t(40)
    # return ###### end function 
