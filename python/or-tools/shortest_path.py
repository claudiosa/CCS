#### BY CCS to studies

'''
Problem Formulation 

% Model from 
% Taha "Introduction to Operations Research", page 245f .


Data from Hakan Kjellerstrand in MINIZINC
n     = 15;  % number of nodes ( n x n matrix)
start = 1;   % start node
end   = 15;  % end node
M     = 999; % large number

% distance
d =
array2d(1..n, 1..n,
[
  M, 1,........
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
    start = 1   #  start node
    end   = 15  #  end node
    M     = 999 #  large number
    # all_nodes = list(range(n)) ## by HAKAN
    ### distance i x j
    d = [ 
        [M, 1, M, M, M, M, M, M, 1, M, M, M, M, M, M],
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
    f_objective = the_model.NewIntVar (0, 9999, 'cost function')
    
    # array[1..n] of var -1..1: rhs; % requirements (right hand statement)
    rhs = [ the_model.NewIntVar (-1, 1, 'diff of side:[%i]' ) for i in range(n) ]
    # array[1..n] of var 0..1: outFlow;
    # array[1..n] of var 0..1: inFlow;
    outFlow = [the_model.NewIntVar (0, 1, 'Output Flow:[%i]' ) for i in range(n) ]
    inpFlow = [the_model.NewIntVar (0, 1, 'Input Flow:[%i]' ) for i in range(n) ]

    ## see the Taha books' and code of HAKAN in MINIZINC
    # CONSTRAINTS ADDED of the problem
    
    ### set rhs for start/end nodes ... verify who is the first and last node ...
    ### applied in flux cauculus
    for i in range(n):
        if (i == start):
            the_model.Add( rhs[i] == 1 )
        elif (i == end):
            the_model.Add( rhs[i] == -1 )
        else:
            the_model.Add( rhs[i] == 0 )  

    '''
    /\ % calculate out flow
    forall(i in 1..n) (
      outFlow[i] = sum(j in 1..n where d[i,j] < M) (x[i,j])
     )
    /\ % calculate in flow
    forall(j in 1..n) (
    inFlow[j]  = sum(i in 1..n where d[i,j] < M) (x[i,j])
    '''
    ### calculate in flow -- OUT
    for i in range(n):
        the_model.Add( outFlow[i] == sum([ x[i][j] for j in range(n) if (d[i][j] < M) ] ) )

    ### calculate in flow -- IN        
    for j in range(n):
        the_model.Add( inpFlow[j] == sum([ x[i][j] for i in range(n) if (d[i][j] < M) ] ) )
    
    # outflow = inflow
    # forall(i in 1..n) (outFlow[i] - inFlow[i] = rhs[i])
    for i in range(n):
        the_model.Add( (outFlow[i] - inpFlow[i]) == rhs[i] )

    ##  do not loops -- main diagonal   
    for i in range(n):
        the_model.Add( x[i][i] == 0)

    ## IF M exist then ... no connection i in this pair i,j ... once M is LARGER
    ## no connection in x
    for i in range(n):
        for j in  range(n):
            if (d[i][j] >= M):
                the_model.Add( x[i][j] == 0)
            else:
                the_model.Add( x[i][j] >= 0)
    ## from Minizinc code of Hakan

    ### Objective Function => objective to minimize
    the_model.Add(
        f_objective == sum(
            (d[i][j] * x[i][j]) \
            for i in range(n) \
            for j in  range(n)
            )### of sum 
        )## of Add
    
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
        my_print_VARS( x , n, n,  f_objective, solver_OUT , rhs)
        print("\n END SOLVER and Model ")
        print_t(40)

    return ###### end function


### PRINTING FUNCTION
## learning Python
def my_print_VARS( x, m, n, f_objective, solver_OUT,rhs ):

    print('Min sum of x : %i' % solver_OUT.Value(f_objective))
    print('RHS vector : %i' % solver_OUT.Value(rhs) )

    print("\n  ================= Matrix X =================")
    for i in range(m): 
        for j in range(n): 
            print(f' x[%i][%i] : %i\t' % (i+1, j+1, solver_OUT.Value( x[i][j] ) ), end =  '' )
        print("\n ======================")
## learning Python            
        
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
    print("\n =============== RESULTS ====================")
    model_shortest_path()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ')
    print_t(40)
    # return ###### end function 
