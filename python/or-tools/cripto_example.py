'''
A toy cripto-aritmetic problem ..
printing intermediate solutions
created by CCS
S + U = B + I + T
where
S<U, B<I, I<T and all different numbers from 0 up to 9
'''

from ortools.sat.python import cp_model
### CLASSES FROM OR
#from print_ALL_solutions import VarArraySolutionPrinter
### using with Maxmimize and Minimize
from print_ALL_solutions import VarArrayAndObjectiveSolutionPrinter

def a_crypto_model():
    """Showcases calling the solver to search for all solutions."""
    # Creates the model.
    the_model = cp_model.CpModel()

    # Creates the variables.
    num_var = 5 # S + U = B + I + T
    letters = [the_model.NewIntVar(0, 9, 'x[i]' ) \
               for i in range(num_var) ]

    f_opt = the_model.NewIntVar(0,99, 'Cost Function')
    # Create the constraints...
    # 
    the_model.Add(letters[0] + letters[1] == letters[2] + letters[3] + letters[4] )
    
    #the_model.Add(letters[0] < letters[1])
    #the_model.Add(letters[2] < letters[3])
    #the_model.Add(letters[3] < letters[4] )
    the_model.AddAllDifferent(letters)

    # Adding a maximization
    # COMMENT yet ... 
    ##the_model.Maximize(letters[0] + letters[1])
    the_model.Add(f_opt == (letters[2] + letters[4]))
    the_model.Minimize( f_opt )
    all_vars = letters
    all_vars.append( f_opt )



    # Create a solver and solve.
    solver_OUT = cp_model.CpSolver()

    # Search for letters values in increasing order.
    # letters[0] ...letters[4]
    # def AddDecisionStrategy(self, variables, var_strategy, domain_strategy) 
    the_model.AddDecisionStrategy(letters, cp_model.CHOOSE_FIRST,
                            cp_model.SELECT_MIN_VALUE)
    
    # Force the solver to follow the decision strategy exactly.
    solver_OUT.parameters.search_branching = cp_model.FIXED_SEARCH
    
    # FOR OPTMIZATION
    ## callback to ... for intermediate solutions
    #solution_printer = VarArraySolutionPrinter(letters)
    solution_printer = VarArrayAndObjectiveSolutionPrinter(all_vars)
    ## options for solver 
    status = solver_OUT.SolveWithSolutionCallback(the_model, solution_printer)
    
    ## without OPTMIZATION --- MINIMIZE OR MAXIMIZE does not works 
    #status = solver_OUT.SearchForAllSolutions(the_model, solution_printer)
    
    ### printing::: something strange
    print('Status = %s' % solver_OUT.StatusName(status))
    print('Number of solutions found: %i' % solution_printer.solution_count())
    if status == cp_model.OPTIMAL:
        for i in range(num_var): 
            print('OPT => letter[%i] = %i' % (i,solver_OUT.Value(letters[i])))
            #print(letters)

    if status == cp_model.FEASIBLE:
        for i in range(num_var): 
            print('FEA => letter[%i] = %i' % (i,solver_OUT.Value(letters[i])))
 
### main ....
if __name__ == '__main__':
    a_crypto_model()