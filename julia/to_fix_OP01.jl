 Ready. Test the following code:
using
JuMP, CPLEX
m
=
Model(solver
=
CplexSolver())
@variable(m, x
<= 5
)
@variable(m, y
<= 45
)
@objective(m, Min, x
+
y)
@constraint(m,
50
x
+ 24
y
<= 2400
)
@constraint(m,
30
x
+ 33
y
<= 2100
)
status
=
solve(m)
println(
"Optimal objective: "
,getobjectivevalue(m))
println(
"x = "
, getvalue(x),
" y = "
, getvalue(y))
