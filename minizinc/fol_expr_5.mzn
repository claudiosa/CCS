
int: nx = 3;
int: ny = 3;

%array[1..n] of var 1..3: x;
array[1 .. nx] of var 4..6: x;
array[1 .. ny] of var 1..3: y;
var bool : reify_var;
%% lb_array   for lower bound index

   constraint
   reify_var = exists( i in lb_array(x)..ub_array(x), 
                    j in lb_array(y)..ub_array(y) ) 
      (

%      x[i] > y[j]
       i > j
      )
      ; 

solve satisfy;

output ["  X: "  ,  show(x),"  Y: ", show(y) , "   Reify_var: ", show(reify_var) , "\n"  ];

/*****



*********/