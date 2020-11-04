
#### BY CCS
'''
#!/usr/bin/python
# -*- coding: iso-8859-15 -*-
#import os, sys

Problem Formulation 
https://github.com/claudiosa/CCS/blob/master/eclipse_CP/8_train.ecl

    A1 #>= A0 + D,
    A2 #>= A1 + D,
    B1 #>= B0 + D,
    B2 #>= B1 + D,
    
    disjunctive([A0,B1], [D,D]),   % trilho 1
    disjunctive([A1,B0], [D,D]),   % trilho 2
    
    Cost #= A2 + B2, %A2 e B2 = tempo de chegada na ultima estacao

Problem
Station 1  <==================> Station 2 <==================> Station 3
Train 1 ->                                                     <- Train 2
the rail ONLY ONE TRAIN
'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# model_FUNCTION
def model_small_non_overlap():
    
    ## creating a model
    the_model = cp_model.CpModel()
    
    # Input Data
    ## duration =  [10 ,10 ,10]  # --   the train stay in each station for 10 units
    duration = 10
    max_time = 100   ## horizon -- the trains will depart in this inverval time
    
    n = 4  #### 3 stations and 2 trains ... thinks before to follow
    # 2 trains .... one rail, they train takes the same rail ? is not allowed
    
    #### VARIABLES
    start_t =[the_model.NewIntVar(0, max_time, 'start_t[i]' )  \
             for i in range(n) ]
    end_t =[the_model.NewIntVar(0, max_time, 'end_t[i]' )  \
             for i in range(n) ]              
    
   # this type is required to nonoverlapping constraint  
    interval_t = [the_model.NewIntervalVar(start_t[i], duration, end_t[i], 'interval_t[i]') 
                 for i in range(n) ]
    
    # CONSTRAINTS ADDED of the problem
            
    ### 
    ## Constraint from the original problem
    the_model.Add( start_t[3] == 15 ) ### train B departs in time 15 from station 3
        
    ## duration (data) and start_t and end_t (variables)
    
    # train 1
    the_model.Add(start_t[0] + duration <= end_t[0]) ## end_t = next station
    the_model.Add(start_t[1] + duration <= end_t[1])
    
    # train 2 departure of station 3 arriving in station 1
    the_model.Add(start_t[2] + duration <= end_t[2])
    the_model.Add(start_t[3] + duration <= end_t[3])
    
    '''
    YOU CAN NOT MIX TYPES OF CONSTRAINTS
    the_model.Add(interval_t[0] == (end_t[0] - (start_t[0] + duration)))
    the_model.Add(interval_t[1] == (end_t[1] - (start_t[1] + duration)))
    the_model.Add(interval_t[2] == (end_t[2] - (start_t[2] + duration)))
    the_model.Add(interval_t[3] == (end_t[3] - (start_t[3] + duration)))
    '''
    # rail ocuppied start_t[0] train 1 left station 1,
    # train 2 left station 2 start_t[4]]
##########     AddNoOverlap(self, interval_vars)
    the_model.AddNoOverlap([interval_t[0], interval_t[2]])
    # the occupation of a rail in a interval
    the_model.AddNoOverlap([interval_t[1], interval_t[3]])
   
    ### optmization  function or objective function 
    # OR:  the_model.Maximize(-less_DIF) 
    obj_var = the_model.NewIntVar(0, max_time, 'makespan')
    ### Start soon ... a naive heuristic
    the_model.Add( obj_var == (end_t[1] + end_t[3])   )
    ## END TIME ...when the train 1 arrive in 3 and train 2 arrive in station 1
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
   # print('Duration Time :', [(duration[i]) for i in range(n)] )
    print('Duration Time :', duration )
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
    model_small_non_overlap()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print("\n END MAIN ", end="")
    print_t(40)
    # return ###### end function 
