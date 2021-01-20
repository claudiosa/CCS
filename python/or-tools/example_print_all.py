
from ortools.sat.python import cp_model

from print_solutions import VarArraySolutionPrinter
from print_solutions import VarArrayAndObjectiveSolutionPrinter
    
def SearchForAllSolutions():
    """Showcases calling the solver to search for all solutions."""
    # Creates the model.
    model = cp_model.CpModel()

    # Creates the variables.
    num_vals = 4
    x = model.NewIntVar(0, num_vals - 1, 'x')
    y = model.NewIntVar(0, num_vals - 1, 'y')
    z = model.NewIntVar(0, num_vals - 1, 'z')
    f_opt = model.NewIntVar(0, num_vals*num_vals, 'f_obj')
    # Create the constraints.
    model.Add(x != y)
    model.Add(x + y == z)
    model.Add(f_opt == (x + y + z))
    # maximization for instance
    
    #model.Maximize(f_opt)

    # Create a solver and solve.
    solver = cp_model.CpSolver()
    #solution_printer = VarArraySolutionPrinter([x, y, z, f_opt])
    #status = solver.SearchForAllSolutions(model, solution_printer)
    
    ### USANDO NA OTIMIZACAO
    #solution_printer = ObjectiveSolutionPrinter(f_opt.ObjectiveValue())
    solution_printer = VarArrayAndObjectiveSolutionPrinter([x,y,z, f_opt])
    #status = solver.SearchForAllSolutions(model, solution_printer)
    status = solver.Solve(model)
    

    print('Status = %s' % solver.StatusName(status))
    print('Number of solutions found: %i' % solution_printer.solution_count())


SearchForAllSolutions()