#### BY CCS to studies

'''
Problem Formulation 

Winston "Operations Research", Assignment Problems, page 393f

Data from Hakan Kjellerstrand in MINIZINC
rows = 4;
cols = 5;

% added the fifth column
cost = 
[|14,  5, 8,  7, 15,
 | 2, 12, 6,  5,  3,
 | 7,  8, 3,  9,  7,
 | 2,  4, 6, 10,  1
|]
;
'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# model_most_money
def model_assignment():
    t = 'model_assignment'  ### onde usar isto ....
    ## creating a model
    the_model = cp_model.CpModel()
    # DATA --- from HAKAN
    rows = 4
    cols = 5
   
    cost = [ 
            [14,  5, 8,  7, 15],
            [2, 12, 6,  5,  3],
            [7,  8, 3,  9,  7],
            [2,  4, 6, 10,  1]
           ]
    ### should be come from a file


    ### Many tricks to a sum of a MATRIX           
    MAX = sum(sum(cost,[])) ### an additional constant
    
    #### VARIABLES
    ### Example x=[[s.NumVar(0,C[i][j],'')for j in range(n)]for i in range(n)
    ## array[1..rows, 1..cols] of var 0..1: x;
    x = [
         [the_model.NewIntVar(0, 1, 'x[i][j]' ) \
            for j in range(cols) ] \
            for i in range(rows)
        ]
    '''
     # define variables --- other trick -- Classical
       x = {}
       for i in range(matrixRows): # rows
         for j in range(matrixColumns):
            x[(i,j)] = model.NewBoolVar('company_%d,%d' % (i,j))
    '''        
    ### range(start, range ) --- start in specific index   
    ### index accept ... only "i" .... WHY ....
    # 
    f_objective = the_model.NewIntVar (0, MAX, 'cost function')
    
    # CONSTRAINTS ADDED of the problem
    '''
      % exacly one assignment per row, all rows must be assigned
        constraint  
        forall(i in 1..rows) (
                sum(j in 1..cols) (x[i,j]) = 1
    '''
    ### For Line - ROWS
    for i in range(rows):
        the_model.Add( sum(x[i][j] for j in range(cols)) == 1 )
        
    ### For Cols --- there are more cols than rows -- TAKE CARE HERE
    for j in range(cols):
        the_model.Add( sum(x[i][j] for i in range(rows)) <= 1 )
    
    ### Objective Function
    the_model.Add(
        f_objective == sum(
            (cost[i][j] * x[i][j]) \
            for i in range(rows) \
            for j in  range(cols)
            )### of sum 
        )## of Add
    
    ### optmization  function or objective function 
    # OR:  the_model.Maximize(-less_DIF) 
    the_model.Minimize(f_objective)

    ### data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)

    if status not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        raise ValueError("No solution was found for the given input values")
    else :
        my_print_VARS( x , rows, cols,  f_objective, solver_OUT )
        print("\n END SOLVER and Model ")
        print_t(40)

    return ###### end function


### PRINTING FUNCTION
## learning Python
def my_print_VARS( x, m, n, f_objective, solver_OUT  ):

    print('Min sum of x : %i' % solver_OUT.Value(f_objective))
    
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
    model_assignment()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ')
    print_t(40)
    # return ###### end function 
