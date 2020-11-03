
#### BY CCS
'''
#!/usr/bin/python
# -*- coding: iso-8859-15 -*-
#import os, sys

Problem Formulation 
https://github.com/claudiosa/CCS/blob/master/eclipse_CP/8_train.ecl

'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# model_FUNCTION
def model_small_disjunctive():
    
    ## creating a model
    the_model = cp_model.CpModel()
    
    # Input Data
    ## duration =  [10 ,10 ,10]  # --   the train stay in each station for 10 units
    duration = 10
    max_time = 100 ## horizon -- the trains will depart in this inverval time
    
    n = 6  #### 3 stations
    # 2 trains .... one rail, they train takes the same rail ? is not allowed
    a_big_value = 99
    
    #### VARIABLES
    start_t =[the_model.NewIntVar(0, max_time, 'start_t[i]' )  \
             for i*2 in range(n) ]
    end_t =[the_model.NewIntVar(0, a_big_value, 'end_t[i]' )  \
             for i*2 in range(n) ]              
    
   # this type is required to cumulative constraint  
    intervals_t = [the_model.NewIntervalVar(start_t[i], duration[i], end_t[i], 'intervals_[i]') \
                 for i*2 in range(n) ]
    ## capacity could be a variable also
    # capacity = the_model.NewIntVar(0, 4, "capacity") # can only cook one meal at a time   
    
    # CONSTRAINTS ADDED of the problem
            
    ### 
    ## Constraint from the original problem
    the_model.Add( start_t[3] == 15 ) -- train B departs in time 15 from station 3
   
    
    ## duration (data) and start_t and end_t (variables)
    ##for i in range(n) :
    the_model.Add(start_t[0] + duration =< end_t[i])

............................

    ### Maybe necessary intervals
    #for i in range(n) :
    #    the_model.Add(intervals[i] == end_t[i] - start_t[i])


    ### to use the Add Cumulative
    # add capacities and demands
    # intervals has a special type .... usage and capacity -> input data
    ### the_model.AddDisjunctive( intervals_t, duration )
............................
    
    the_model.AddNoOverlap(intervals_t)


    ### Attention: intervals type is mandatory .... special type
   
  # Create and add disjunctive constraints.--- for the future
  # for i in range(n) :
  #      the_model.AddNoOverlap(start_t[i])


    ### optmization  function or objective function 
    # OR:  the_model.Maximize(-less_DIF) 
    #the_model.Minimize( sum (end_t) )
    ## missing something ... if you uncomment it works also
    obj_var = the_model.NewIntVar(0, a_big_value, 'makespan')
    ### Start soon ... a naive heuristic
    the_model.Add(obj_var == sum (start_t))
    the_model.Minimize( obj_var )
    
    ### data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)
    '''
    db = solver.Phase(x, solver.INT_VAR_DEFAULT, solver.INT_VALUE_DEFAULT)
    '''
    
    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
       my_print_VARS( start_t, end_t, duration, solver_OUT )
        
    elif (status == cp_model.INFEASIBLE) :   ##nao é UNFEASIBLE 
        print(" INSATISFATIVEL ")
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
def my_print_VARS( x, y, duration, solver_OUT):

    n = len (x)
    print('Start Time : ', [solver_OUT.Value(x[i]) for i in range(n)] )
    print('Duration Time :', [(duration[i]) for i in range(n)] )
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
    model_small_disjunctive()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print("\n END MAIN ", end="")
    print_t(40)
    # return ###### end function 
