set of int: B = {1,2,3};
% OU set of int: B = 1 .. 3;
set of int: A = {4,5};

var set of   1 .. 5 : var_uniao;
var set of   1 .. 5 : var_inters ;

constraint
  var_uniao = B union A;

constraint
  var_inters = B intersect A;

solve satisfy;

output
     ["VAR_Uniao = " , show(var_uniao),"\n",
      "VAR_Inters = " , show(var_inters),"\n"];