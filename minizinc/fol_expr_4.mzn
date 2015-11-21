
int: nx = 3;
int: ny = 3;
%%% "domain operations"
%array[1..nx] of var 3..3: x;
array[1 .. nx] of var 4..6: x;
array[1 .. ny] of var 3..5: y;
var bool : reify_var;
%% lb_array   for lower bound index

   constraint
 reify_var = forall( i in lb_array(x)..ub_array(x), 
                     j in lb_array(y)..ub_array(y) ) 
      (
       i >= j %% i assume x[1] ateh x[n]
       % idem para j
      )
      ; 

solve satisfy;

output ["  X: "  ,  show(x),"  Y: ", show(y) , "   Reify_var: ", show(reify_var) , "\n"  ];

/*****

Running fol_expr_4.mzn
  X: [4, 4, 4]  Y: [1, 1, 1]   Reify_var: false

*********/