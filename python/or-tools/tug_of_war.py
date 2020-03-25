#### BY CCS to studies

'''
swing's problem -- war cable

'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

## learning Python
def half(N) :
    return ( N // 2) ### integer DIV 

# model_most_money
def model_tug_of_war():
    t = 'model__tug_of_war'###
    ## creating a model
    the_model = cp_model.CpModel()

    # DATA ---
    weight = [ 77, 97, 120, 45, 57, 96, 100, 59 ]
    size = len (weight) ## learning Python
    midle = half (size) ## learning Python
    weight_TOTAL = sum(weight) ## learning Python
    ### should be come from a file
    
    #### VARIABLES
    ## ANOTHER IDEA AROUND THIS
    #side_A = [the_model.NewIntVar(0, max(weight), 'x[%i]' % i) for i in range(midle)]
    #side_B = [the_model.NewIntVar(0, max(weight), 'x[%i]' % i) for i in range(size - midle)]
    
    # Vars about the weight in A and B
    weight_A = the_model.NewIntVar(0, weight_TOTAL, 'Weight in A side')
    weight_B = the_model.NewIntVar(0, weight_TOTAL, 'Weight in B side')
    ### to be used in ABS constraint
    temp_AUX = the_model.NewIntVar(-weight_TOTAL, weight_TOTAL, 'temporary')

    # Binary Decision Vector : 0/1
    V_DEC =  [the_model.NewIntVar(0, 1, 'v[%i]' % i) for i in range(size)]
    less_DIF = the_model.NewIntVar(0, max(weight), 'DIFF')
   
    # CONSTRAINTS ADDED of the problem
    
    ## Select ONE SIDE ...in this case side B -- my choice
    # A = midle
    # B = size - midle
    ### THE MOST important constraint ... only (size-midle) with 1  will be selected
    the_model.Add((size-midle) == sum(V_DEC[i] for i in range(size) )  )

    ### due some 1's are selected ... how much we have in B 
    the_model.Add(weight_B == sum((weight[i] * V_DEC[i]) for i in range(size) )      )
    
    ## Obviously that weight A is ...
    the_model.Add(weight_A == (weight_TOTAL - weight_B) )

  
    ### to use a ABS constraint about an absolut difference
    the_model.Add(temp_AUX == (weight_A - weight_B))
    ## Reading in OR-TOOLS manual
    ### AddAbsEquality(x, y) --> x = abs(y)
    the_model.AddAbsEquality(less_DIF, temp_AUX)
    # NOT ALLOWED ...     
    #the_model.AddAbsEquality(less_DIF , (weight_A - weight_B))
    

    ### optmization  function or objective function 
    # OR:  the_model.Maximize(-less_DIF) 
    the_model.Minimize(less_DIF)

    ### data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)

    if status not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        raise ValueError("No solution was found for the given input values")
    else :
        my_print_VARS( weight, V_DEC, weight_A, weight_B, less_DIF, solver_OUT )
        print("\n END SOLVER and Model ")
        print_t(40)

    return ###### end function


### PRINTING FUNCTION
## learning Python
def my_print_VARS( weight, V_DEC, weight_A, weight_B, less_DIF, solver_OUT  ):

        print('Difference abs(A-B) : %i' % solver_OUT.Value(less_DIF))

        print(f'weight_A:%i || weight_B:%i ' 
            % ( 
                solver_OUT.Value(weight_A), 
                solver_OUT.Value(weight_B),
            ) ),
        
        for index in range(len(weight)): 
            if (solver_OUT.Value(V_DEC[index]) == 0):
                print(f'A: V[%i] : %i ==> A' % (index, solver_OUT.Value(weight[index]) ) )
            else:
                print(f'B: V[%i] : %i ==> B' % (index, solver_OUT.Value(weight[index]) ) )

        print("\nDecision Vector is given  by: ")   
        print('V_DEC  by: ', V_DEC)   
        ###print('V_DEC  by: ', solver_OUT.Value(V_DEC) ) ## Not works
        for index in range(len(weight)): 
            print(f'V[%i]:%i || ' % (index, solver_OUT.Value(V_DEC[index]) ), end =  '')            

        print('\n\n** Final Statistics **')
        print('  - conflicts : %i' % solver_OUT.NumConflicts())
        print('  - branches  : %i' % solver_OUT.NumBranches())
        print('  - wall time : %f s' % solver_OUT.WallTime())
        print("\n END PRINTING \n ===================================")
        return ###### end function

#### print =================
## learning Python
def print_t(n):
    print()
    for i in range(n):
        print('=', end="")
    print()
    return

if __name__ == '__main__':
    print("\n=============== RESULTS ====================")
    model_tug_of_war()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ')
    print_t(40)
    # return ###### end function


   
