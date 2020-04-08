#### BY CCS to studies

'''
Problem Formulation 
% Model from :

"Optimization Modelling A Practical Approach"
Ruhul A. Sarker Charles S. Newton
AND
Taha "Introduction to Operations Research" (PORTUGESE edition - 8 nth.)
Max flow problem in Minizinc.

HELP FROM HAKAN:
% From http://taha.ineg.uark.edu/maxflo.txt
% Taha "Introduction to Operations Research", Example 6.4-2)
% (ported from the AMPL code)
% 
% Model created by Hakan Kjellerstrand, hakank@bonetmail.com 
% See also my MiniZinc page: http://www.hakank.org/minizinc
'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# function defining the model
def model_max_flow():
    t = 'model_max_flow'  ### onde usar isto ....
    ## creating a model
    the_model = cp_model.CpModel()

    # Example 01
    # DATA --- from HAKAN 
    n     = 5  #  number of nodes ( n x n matrix)
    start = 0  #  start node -- attention here ... Python start in 0
    end   = 4  #  end -- destination node
    
    # all_nodes = list(range(n)) ## by HAKAN
    ### cost or CAPACITY between i x j
    c = [ 
        [0, 20, 30, 10,  0],
        [0,  0, 40,  0, 30],
        [0,  0,  0, 10, 20],
        [0,  0,  5,  0, 20],
        [0,  0,  0,  0,  0]
        ]

    A_BIG_VALUE = sum(map(sum, c))  * 2
    ## for * 2 warranty      
    ##= max(map(max, c))        
   
    '''
    # Example 02
    
    
    ### should be come from a file
    '''
    #### VARIABLES
    ## a decision matrix x .... the kernel of the solution
    ## how much flow is going from i (row) to j (column)

    x = [
         [the_model.NewIntVar(0, A_BIG_VALUE, 'x[i][j]' ) \
            for j in range(n) ] \
            for i in range(n)
        ]
    ### range(start, range ) --- start in specific index   
    ### index accept ... only "i" .... WHY ....
    # 
    f_objective = the_model.NewIntVar (0, 999999, 'cost function')
  
    # solution based in flow in each node
    # array[1..n] of var 0..1: outFlow  AND array[1..n] of var 0..1: inFlow;
    outFlow = [the_model.NewIntVar (0, A_BIG_VALUE, 'Output Flow:[%i]' ) for i in range(n) ]
    inpFlow = [the_model.NewIntVar (0, A_BIG_VALUE, 'Input Flow:[%i]' ) for i in range(n) ]

    ## see the Taha books'
    # CONSTRAINTS ADDED of the problem
     
    ## all the flow MUST be positives and less than the capacity
    for i in range(n):
        for j in  range(n):
            the_model.Add( 
            (x[i][j] >= 0) and (x[i][j] <= c[i][j])
            ) 
    
    ## output flow in each node i ... if exist something flowing throw out from i          
    for i in range(n):
        the_model.Add( outFlow[i] == sum( [ x[i][j]  
            for j in range(n) if (c[i][j] > 0) ] ) )
    ## It will flow out if exist something as output in this node           

    ### calculate in flow -- IN        
    ## HERE is a column ... sum all the rows of this column
    #for j in  [x for x in range(n) if (x != start) ]:
    for i in range(n):
        the_model.Add( inpFlow[i] == sum([ x[j][i]  
            for j in range(n)  if  (c[j][i] > 0) ] ) )
    ## Exist some flow only if exist some node arriving in i
    # HERE is the column considered            
    
    # outflow = inflow
    # Input - Output flow must be the equal for all nodes except
    without_start_end = [x for x in range(n) if (x != start) and (x != end)]    
    #without_start_end = filter(lambda x: (x != start) and (x != end), range(n))
    #print('\n the nodes' , without_start_end)
    for i in  without_start_end :  
        ## removing the start and end nodes form Flow cauculus
        the_model.Add( (inpFlow[i] - outFlow[i]) == 0) 
    
    # not necessary ... already calculed
    # the_model.Add( (inpFlow[start] == 0) and 
    #                (outFlow[end] == 0)  )

    ### None flow arriving in the start node
    the_model.Add( 
        sum( [x[i][start] for i in range(n) if (c[i][start] > 0)] ) 
        == 0 )
    
    ### None flow departure from the end node
    the_model.Add( 
        sum( [x[end][j] for j in range(n) if (c[end][j] > 0) ] )
        == 0 )

    ### Objective Function => objective to minimize/maximize
    '''
    the max flow is defined by: the flow max arriving at the END node or
    the  flow max departuring from the START node
    '''
    ## for instance:
    the_model.Add( (inpFlow[start] - outFlow[start]) == -f_objective )
    #the_model.Add( (inpFlow[end] - outFlow[end]) == f_objective )
    ### optmization  function or objective function 
   
    the_model.Maximize( f_objective )

    ### data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)
    '''
    db = solver.Phase(x, solver.INT_VAR_DEFAULT, solver.INT_VALUE_DEFAULT)
    '''
    
    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
        my_print_VARS( x, n,  f_objective, solver_OUT , inpFlow, outFlow )
        
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
def my_print_VARS( x,  n, f_objective, solver_OUT, inpFlow, outFlow ):

    print('Max FLOW for this graph : %i' % solver_OUT.Value(f_objective) )
    print('Inp Flow vector : ', [solver_OUT.Value(inpFlow[i]) for i in range(n)] )
    print('Out Flow vector : ', [solver_OUT.Value(outFlow[i]) for i in range(n)] )
        
    print("\n ================= Decision Matrix X ==================")
    print(end =  '    ')
    ####### HEADLINE -- TOP of matrix
    for i in range(n):
        print(f'  %i' % ((i+1)%10), end =  '')

    for i in range(n): 
        print(f'\n %i: '  %(i+1) , end =  '' )
        for j in range(n): 
            ## print(f' x[%i][%i] : %i\t' % (i+1, j+1, solver_OUT.Value( x[i][j] ) ), end =  '' )
            print(f'  %i' % ( solver_OUT.Value( x[i][j] ) ), end =  '' )
    print("\n ============== SEQUENCE OF NODES ========= ")
    ### to be improved
    

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
def print_t(n):
    print()
    for i in range(n):
        print('=', end="")
    print()
    return

if __name__ == '__main__':
    print("\n=============== RESULTS ====================")
    model_max_flow()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ', end="")
    print_t(40)
    # return ###### end function 
