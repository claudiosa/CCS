#### BY CCS to studies

'''
Problem Formulation 

Powerco has three electric power plants that supply the needs of four cities.† Each power plant can supply the following numbers of kilowatt-hours (kwh) of electricity: plant 1—35 million; plant 2—50 million; plant 3—40 million (see Table 1). The peak power demands in these cities, which occur at the same time (2 P.M.), are as follows (in kwh): city 1—45 million; city 2—20 million; city 3—30 million; city 4—30 million. The costs of sending 1 million kwh of electricity from plant to city depend on the distance the electricity must travel. Formulate an LP to minimize the cost of meeting each city’s peak power demand.


Solution: To formulate Powerco’s problem as
 an LP, we begin by defining a variable for each decision 
 that Powerco must make. Because Powerco must determine 
 how much power is sent from each plant to each city,
  we define (for i  1, 2, 3 and j  1, 2, 3, 4)

xij:  number of (million) kwh produced at plant i and 
sent to city j

 http://www.producao.ufrgs.br/arquivos/disciplinas/382_winston_cap_7_transportation.pdf

'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model


# model_most_money
def model_powereco_plant():
    t = 'model_powereco_plant'###
    ## creating a model
    the_model = cp_model.CpModel()

    # DATA ---
    C1 = 35 ### Capacity of a supplier ... 1 up to 3
    C2 = 50
    C3 = 40
    suppliers = 3
    cities = 4
    
    
    ### should be come from a file
    
    #### VARIABLES
    ## ANOTHER IDEA AROUND THIS
    x = [the_model.NewIntVar(0, C1, 'x[1][%j]' % j) for j in range(cities) ,
         the_model.NewIntVar(0, C2, 'x[2][%j]' % j) for j in range(cities) ,
         the_model.NewIntVar(0, C3, 'x[3][%j]' % j) for j in range(cities) ]
        ]
    #side_B = [the_model.NewIntVar(0, max(weight), 'x[%i]' % i) for i in range(size - midle)]
    
    # 
    cost = the_model.NewIntVar(0, 999999, 'cost function')


    

    # Binary Decision Vector : 0/1
    
    # CONSTRAINTS ADDED of the problem

    ####x11 + x12 + x13 + x14 <= C1; %(Plant 1 supply constraint)
    for j in range(cities):
        the_model.Add(sum(matrixV_DEC[i]         


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
    model_war_cable()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ')
    print_t(40)
    # return ###### end function


   
