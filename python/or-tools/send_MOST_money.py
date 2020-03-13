####MODIFIED BY CCS to studies

###--from ortools.linear_solver
'''
S E N D
M O S T
-- -- -- -- -- -- -- --
M O N E Y
    .......................
'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

#model_most_money
def model_most_money():
    t = 'model_most_money'###
    the_model = cp_model.CpModel()

    # VARS....take care the supported types of cp_model
    S = the_model.NewIntVar(0, 9, 'S')
    E = the_model.NewIntVar(0, 9, 'E')
    N = the_model.NewIntVar(0, 9, 'N')
    D = the_model.NewIntVar(0, 9, 'D')

    M = the_model.NewIntVar(0, 9, 'M')### S
    O = the_model.NewIntVar(0, 9, 'O')
    T = the_model.NewIntVar(0, 9, 'T')

    Y = the_model.NewIntVar(0, 9, 'Y')

    ## CARRY VECTOR
    ''' >>>
    x = [(i) for i in range(3)] >>>
        print(x)[0, 1, 2] >>>
        print(x[1])
    1
        >>>
    '''
    carry = [the_model.NewIntVar(0, 1, 'x[%i]' % i) for i in range(4)]
    f_most = the_model.NewIntVar(0, 999999, 'f_most')

    # CONSTRAINTS ADDED of the problem
    the_model.Add(S > 0)
    the_model.Add(M > 0)
    the_model.Add(carry[3] == M)

    the_model.Add(D + T == Y + carry[0] * 10)
    the_model.Add(N + S + carry[0] == E + carry[1] * 10)
    the_model.Add(E + O + carry[1] == N + carry[2] * 10)
    the_model.Add(S + M + carry[2] == O + carry[3] * 10)

    ### all different
    the_model.AddAllDifferent([S, E, N, D, M, O, T, Y])

    ### maximizefunction F_MOST such

    the_model.Add(f_most == M * 1000 + O * 100 + S * 10 + T)

    ### optmization  function
    the_model.Maximize(f_most)

    ### data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)

    if status not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        raise ValueError("No solution was found for the given input values")
    else :
        my_print_VARS(f_most, S, E, N, D, M, O, T, Y, carry, solver_OUT )
        print("\n END SOLVER and Model ")
        print_t(40)

    return ###### end function


### PRINTING FUNCTION

def my_print_VARS(f_most, S, E, N, D, M, O, T, Y, carry, solver_OUT ):

        print('MAX = %i' % solver_OUT.Value(f_most))

        print(f'S:%i || E:%i || N:%i || D:%i || M:%i || O:%i ||  T:%i ||  Y:%i' 
            % ( 
            solver_OUT.Value(S), 
            solver_OUT.Value(E),
            solver_OUT.Value(N),
            solver_OUT.Value(D),
            solver_OUT.Value(M),
            solver_OUT.Value(O),
            solver_OUT.Value(T),
            solver_OUT.Value(Y) 
            ) ),
        
        for index in range(len(carry)): 
            print(f'carry[%i] : %i ' % (index, solver_OUT.Value(carry[index]) ))

        print('\n\n** Final Statistics **')
        print('  - conflicts : %i' % solver_OUT.NumConflicts())
        print('  - branches  : %i' % solver_OUT.NumBranches())
        print('  - wall time : %f s' % solver_OUT.WallTime())
        print("\n END PRINTING \n ===================================")
        return ###### end function

#### print =================

def print_t(n):
    print()
    for i in range(n):
        print('=', end="")
    print()
    return

if __name__ == '__main__':
    print("\n=============== RESULTS ====================")
    model_most_money()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ')
    print_t(40)
    # return ###### end function


    '''
    TEM QUE FICAR NESTE ANINHAMENTO
    print('x0 = %i' % solver_OUT.Value(carry[0]))
    print('x1 = %i' % solver_OUT.Value(carry[1]))
    print('x2 = %i' % solver_OUT.Value(carry[2]))
    print('x3 = %i' % solver_OUT.Value(carry[3]))
    '''
