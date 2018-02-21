var set of int: x;
var set of int: y;
var set of  -100 .. 100: var_Z1; %%%% LOOK AT DOMAIN
var set of  -100 .. 100: var_Z2; %%%% LOOK AT DOMAIN
%%% INICIALIZA
  x = { 0, -1, 1, 5,  99};
  y = { 0, -5, 10, 8, 3, 99 };

constraint
    var_Z1 = x union y;

constraint
  var_Z2 = x intersect y;

solve satisfy;

output
     ["VAR_Uniao = ",show(var_Z1),"\n",
      "VAR_Inters = ",show(var_Z2),"\n"];

