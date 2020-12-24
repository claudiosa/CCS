
## CPLEX
# using JuMP, CPLEX
# m = Model(solver = CplexSolver())

using JuMP, GLPK
m = Model(GLPK.Optimizer)
## parameters
set_optimizer_attribute(m, "tm_lim", 60 * 1_000)
set_optimizer_attribute(m, "msg_lev", GLPK.GLP_MSG_OFF)

@variable(m, x <= 5)
@variable(m, y <= 45)
@objective(m, Min, x+y)
@constraint(m,50x + 24y <= 2400)
@constraint(m,30x + 33y <= 2100)
#status = solve(m) ===> for clplex
optimize!(m)

println( "Optimal objective: " , getobjectivevalue(m))
println("x = ", getvalue(x)," y = ", getvalue(y))


println("THE END")

#* ******** to remember 
#$ julia to_fix_OP01.jl 
#ERROR: LoadError: ArgumentError: Package JuMP not found in current path:
#- Run `import Pkg; Pkg.add("JuMP")` to install the JuMP package.
#[ccs@vosges julia]$ julia
#in expression starting at /home/ccs/my_main/CCS/julia/to_fix_OP01.jl:2
#julia> import Pkg; Pkg.add("JuMP")
# Installing known registries into `~/.julia`
####################################################################### 100,0%
*#
