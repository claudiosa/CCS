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
def model_TSP():
    t = 'model_TSP'  ### onde usar isto ....
    ## creating a model
    the_model = cp_model.CpModel()
    '''    
    # Example 01
    n  = 6  #  number of nodes ( n x n matrix)
    # all_nodes = list(range(n)) ## by HAKAN
    ### distance i x j
    #     1   2   3   4   5   6  
    d = [ 
         [0,  11, 7,  6,  8,  14 ],
         [11, 0,  7,  9,  12, 13 ],
         [7,  7,  0,  3,  7,  8  ],
         [6,  9,  3,  0,  4,  8  ],
         [8,  12, 7,  4,  0,  10 ],
         [ 14, 13, 8,  8,  10, 0  ]
        ]; 
    '''
# Example 02
    n  = 7  #  number of nodes ( n x n matrix)
    # all_nodes = list(range(n)) ## by HAKAN
    ### distance i x j
    #    1   2   3   4   5   6  7
    d = [
        [ 0, 4, 8,10, 7,14,15],
        [ 4, 0, 7, 7,10,12, 5],
        [ 8, 7, 0, 4, 6, 8,10],
        [10, 7, 4, 0, 2, 5, 8],
        [ 7,10, 6, 2, 0, 6, 7],
        [14,12, 8, 5, 6, 0, 5],
        [15, 5,10, 8, 7, 5, 0]
        ] 
    
    L_NODES = list(range(n))
    '''
    # Example 02
    ### should be come from a file
    '''
    #### VARIABLES
    #  to store ONE TRIP ==> take care with the MAX value
    tour = [ the_model.NewIntVar(0, (n-1), 'tour[i]' ) 
             for i in range(n)
            ]
    ### go from 0 up to (n-1)
    #             
    x = [
         [the_model.NewIntVar(0, 1, 'x[i][j]' ) 
            for j in range(n) ] 
            for i in range(n)
        ]        
    
    f_objective = the_model.NewIntVar (0, 999999, 'cost function')

    ## see the Taha books'
    # CONSTRAINTS ADDED of the problem
    
    ## NO ARCS no POSSIBLE PATH
    for i in range(n):
        for j in  range(n):
            if (d[i][j] == 0):   ### 
                the_model.Add( x[i][j] == 0) ### NO CONNECTION ALLOWED from i
            
     ### For Line - ROWS -- at least a city MUST be visited
    for i in L_NODES:
        the_model.Add( sum(x[i][j] for j in L_NODES) == 1 )
        
    ### For Cols --- there are more cols than rows -- TAKE CARE HERE
    for j in L_NODES:
        the_model.Add( sum(x[i][j] for i in L_NODES) == 1 )
    
    ## NO ARCS no POSSIBLE PATH over the same nodes -- main diagonal
    for i in L_NODES:
        the_model.Add( x[i][i] == 0 ) 
    
    
    #the_model.AddAllDifferent( tour )
    
    circuit_HAKAN(the_model, tour)
    ### TESTING
    #the_model.AddCircuit( tour[0] )
    #my_circ( tour, the_model)
    #the_model.AddImplication
        
    ### connecting x - decision with the tour vector
    '''
    %% Relacionar as escolhas da M_Decisao com a
    %% Sequencia das Cidades. 
     foreach(I in 1..Len , J  in 1..Len)
      ( M_Decisao[I,J] #= 1 ) #<=> ( Cidades[I] #= J )
     end,    
    
    for i in L_NODES:
        for j in  L_NODES:
            ##if (x[i][j] == 1):    
            ### equivalence_constraint(the_model, tour[i] == j, x[i][j] == 1 )
            #the_model.Add( (x[i][j] == 1) == (tour[i] == j))
            the_model.Add( x[i][j] == 1)
            the_model.Add( tour[i] == j)
    '''

    ### Objective Function => objective to minimize
    the_model.Add(
        f_objective == sum( (d[i][j] * x[i][j] ) 
            for i in range(n) 
            for j in range(n)
            ) ### of sum 
        ) ## of Add
    
    ### optmization  function or objective function 
    # OR:  the_model.Maximize(-less_DIF) 
    the_model.Minimize( f_objective )

    ### data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)
    '''
    db = solver.Phase(x, solver.INT_VAR_DEFAULT, solver.INT_VALUE_DEFAULT)
    '''
    
    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
        my_print_VARS( x, n, n,  f_objective, solver_OUT , tour  )
        
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
def my_print_VARS( x, m, n, f_objective, solver_OUT , tour ):

    print('Min sum of x : %i' % solver_OUT.Value(f_objective) )
    print('TOUR : ', [solver_OUT.Value(tour[i]) for i in range(n)] )
   # print('Out Flow vector : ', [solver_OUT.Value(outFlow[i]) for i in range(n)] )
    ### printing the sequence of the nodes choosen
   
    print("\n ================= Decision Matrix X ==================")
    print(end =  '    ')
    ####### HEADLINE -- TOP of matrix
    for i in range(n):
        print(f'  %i' % ((i+1)%10), end =  '')

    for i in range(m): 
        print(f'\n %i: '  %(i+1) , end =  '' )
        for j in range(n): 
            ## print(f' x[%i][%i] : %i\t' % (i+1, j+1, solver_OUT.Value( x[i][j] ) ), end =  '' )
            print(f'  %i' % ( solver_OUT.Value( x[i][j] ) ), end =  '' )
    print("\n ============== SEQUENCE OF NODES ========= ")
    ### to be improved
   
    ##sequence_by_LUCAS ( x,  solver_OUT )


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

## learning Python
def sequence_visiting ( x,  n, solver_OUT ):
    for i in range(n):
        for j in range(n):
            if (solver_OUT.Value( x[i][j] ) == 1):
                 print((i+1),' --> ',(j+1) )

######### TO BE IMPROVED

### printing the sequence of the nodes choosen
### it does not fine
def sequence_connection ( v1, v2, solver_OUT ):
    size = len(v1)
    or_vetor = [solver_OUT.Value(v1[i]) or solver_OUT.Value(v2[i]) for i in range(size)]
    print(f'Inp OR Out => Sequence Vector ', [or_vetor[i] for i in range(size)])
    
    print("Sequence of Shortest PATH:")
    for index in range(size):
        if (or_vetor[index] == 1):
            print(f'-> %i' %(index+1) , end =  '')
    return

## learning Python
def print_t(n):
    print()
    for i in range(n):
        print('=', end="")
    print()
    return

if __name__ == '__main__':
    print("\n=============== RESULTS ====================")
    model_TSP()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ', end="")
    print_t(40)
    # return ###### end function 
