#### BY CCS to studies

'''
Problem Formulation 
% Model from 
% Taha "Introduction to Operations Research", page 245f .

'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# model_most_money
def model_shortest_path():
    t = 'model_assignment'  ### onde usar isto ....
    ## creating a model
    the_model = cp_model.CpModel()
    # DATA --- from HAKAN
    n     = 15  #  number of nodes ( n x n matrix)
    start = 0   #  start node -- attention here ... Python start in 
    end   = 14  #  end -- destination node
    M     = 999 #  large number ... means NO CONNECTION
    # all_nodes = list(range(n)) ## by HAKAN
    ### distance i x j
    d = [ 
        [500, 1, M, M, M, M, M, M, 1, M, M, M, M, M, M],
        [M, M, 1, M, M, M, M, M, M, M, M, M, M, M, M],
        [M, M, M, 1, M, M, M, M, 1, M, M, M, M, M, M],
        [M, M, M, M, 1, M, M, M, M, M, M, M, M, M, M],
        [M, M, M, M, M, 1, M, M, 1, M, M, M, M, M, M],
        [M, M, M, M, M, M, 1, M, M, M, M, M, M, M, M],
        [M, M, M, M, M, M, M, 1, 1, M, M, M, M, M, M],
        [M, M, M, M, M, M, M, M, M, M, M, M, M, M, 1], 
        [M, M, M, M, M, M, M, M, M, 1, M, M, M, M, M],
        [M, 1, M, M, M, M, M, M, M, M, 1, M, M, M, M],
        [M, M, M, M, M, M, M, M, M, M, M, 1, M, M, M],
        [M, 1, M, M, M, M, M, M, M, M, M, M, 1, M, M],
        [M, M, M, M, M, M, M, M, M, M, M, M, M, 1, M],
        [M, 1, M, M, M, M, M, M, M, M, M, M, M, M, 1], 
        [M, M, M, M, M, M, M, M, M, M, M, M, M, M, M]
        ]
    ### should be come from a file
    
    #### VARIABLES
    ## array[1..n, 1..n] of var 0..1: x; % the resulting matrix, 1 if connected, 0 else
    ## the resulting connection matrix
    x = [
         [the_model.NewIntVar(0, 1, 'x[i][j]' ) \
            for j in range(n) ] \
            for i in range(n)
        ]
    ### range(start, range ) --- start in specific index   
    ### index accept ... only "i" .... WHY ....
    # 
    f_objective = the_model.NewIntVar (0, 999999, 'cost function')
  
    # array[1..n] of var 0..1: outFlow  AND array[1..n] of var 0..1: inFlow;
    outFlow = [the_model.NewIntVar (0, 1, 'Output Flow:[%i]' ) for i in range(n) ]
    inpFlow = [the_model.NewIntVar (0, 1, 'Input Flow:[%i]' ) for i in range(n) ]

    ## see the Taha books'
    # CONSTRAINTS ADDED of the problem
            
    ### calculate in flow -- OUT -- in a row versus for all the cols
    ## output Flow of all nodes ... sum of a column of a row i:
    for i in [x for x in range(n) if (x != end) ]:
        the_model.Add( outFlow[i] == sum([ x[i][j] \
            for j in range(n) \
            if (d[i][j] < M) ] ) )

    ### calculate in flow -- IN        
    ## HERE is a column ... sum all the rows of this column
    for j in  [x for x in range(n) if (x != start) ]:
        the_model.Add( inpFlow[j] == sum([ x[i][j] \
            for i in range(n) \
            if  (d[i][j] < M) ] ) )
    
    # outflow = inflow
    ## Input - Output flow must be the equal ... 
    for i in [x for x in range(n) if ((x != start) and (x != end)) ]:  
        ## removing the start and end nodes form Flow cauculus
        the_model.Add( (inpFlow[i] - outFlow[i]) == 0) 

    ## EXCEPT in start and end nodes:
    the_model.Add( inpFlow[start] - outFlow[start] == -1 )
    the_model.Add( inpFlow[end] - outFlow[end] == 1 )
    
    ##  do not loops over the same node -- main diagonal in the matrix
    for i in range(n):  
        the_model.Add( x[i][i] == 0 )

    ## IF M exist then ... no connection i in this pair i,j ... once M is LARGER
    ## no connection in x
    
    for i in range(n):
        for j in  range(n):
            if (d[i][j] >= M):   ### M is BIG ... NO connection
                the_model.Add( x[i][j] == 0) ### NO CONNECTION ALLOWED
            else:   
                the_model.Add( x[i][j] >= 0) ### 0 or 1 -- GENERAL CASE
    
    
    ### Objective Function => objective to minimize
    the_model.Add(
        f_objective == sum( (d[i][j] * x[i][j]) \
            for i in range(n) \
            for j in  range(n)
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
    if status not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        print("\n UNFEASIBLE ")
        raise ValueError("No solution was found for the given input values")

    else :
        my_print_VARS( x, n, n,  f_objective, solver_OUT , inpFlow, outFlow )
        print("\n END SOLVER and Model ", end="")
        print_t(40)

    return ###### end function


### PRINTING FUNCTION
## learning Python
def my_print_VARS( x, m, n, f_objective, solver_OUT, inpFlow, outFlow ):

    print('Min sum of x : %i' % solver_OUT.Value(f_objective) )
    print('Inp Flow vector : ', [solver_OUT.Value(inpFlow[i]) for i in range(n)] )
    print('Out Flow vector : ', [solver_OUT.Value(outFlow[i]) for i in range(n)] )
    ### printing the sequence of the nodes choosen
    sequence_connection(inpFlow,outFlow, solver_OUT)
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
        #print("\n ======================")
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
### printing the sequence of the nodes choosen
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
    model_shortest_path()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ', end="")
    print_t(40)
    # return ###### end function 
