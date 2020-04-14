#### BY CCS to studies
'''
Problem Formulation 
% Model from :

"Optimization Modelling A Practical Approach"
Ruhul A. Sarker Charles S. Newton
AND
Taha "Introduction to Operations Research" (PORTUGESE edition - 8 nth.)

'''

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
    
    #circuit_HAKAN(the_model, tour)
    ### TESTING
    the_model.AddCircuit( tour )
    #my_circ( tour, the_model)
    #the_model.AddImplication
        
    
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)
    
    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
        my_print_VARS( tour, n, solver_OUT  )
        
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

###############
def circuit_HAKAN(solver, x):
        n = len(x)
        ## MODIFIED here by CCS
        z = [solver.NewIntVar(0, n - 1, "z%i" % i) for i in range(n)]
        ## MODIFIED here by CCS
        solver.AddAllDifferent(x)
        solver.AddAllDifferent(z)

        # put the orbit of x[0] in in z[0..n-1]
        solver.Add(z[0] == x[0])
        for i in range(1, n - 1):
            # The following constraint give the error
            # "TypeError: list indices must be integers, not IntVar"
            # solver.Add(z[i] == x[z[i-1]])

            # solution: use Element instead
            #solver.Add(z[i] == solver.Element(x, z[i - 1]))
            ## MODIFIED here by CCS
            solver.AddElement(z[i-1] , x, z[i])

        #
        # Note: At least one of the following two constraint must be set.
        #
        # may not be 0 for i < n-1
        for i in range(1, n - 1):
            solver.Add(z[i] != 0)

        # when i = n-1 it must be 0
        solver.Add(z[n - 1] == 0)
###############

###############
def my_circ( c, the_model):
    #https://acrogenesis.com/or-tools/documentation/user_manual/manual/introduction/theory.html
    
    n = len(c)
    print("INDEX MAX" , (n-1))
    x = the_model.NewIntVar(0, (n-1), 'aux' ) 
    for i in range(n):
        ###the_model.Add( c[i] != x and c[x] != i ) 
        the_model.Add( c[i] != x and c[i] != i )  
###############
def is_a_circuit (model, x ):
    
    n = len(x)
    step, i = 0 , 0 ### any position
    v = []
    v = [0  for i in range(n)]    
    v[i] = 1 ## mark sequentially
    
    next = model.NewIntVar(0,(n-1),"")
    
    while (step < n):
        model.Add( next ==  x[i] )
        temp =   model.Value(next)
        v[ temp ] = 1
        i = model.Value(next)
        step = step + 1
        #print(f'i: %i \t next: %i \t step: %i v: %s ' %(i, next, step, v))
        
    if ( sum(v) == n ):
        return True
    else:
        return False
###############

def equivalence_constraint(model , x, y ):
    model.AddImplication(x,y)
    model.AddImplication(y,x)
###############

### PRINTING FUNCTION
## learning Python
def my_print_VARS( tour, n, solver_OUT ):

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
