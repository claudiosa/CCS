
int : x = 5 ; %% uma constante
var int : y; %% uma variavel

var bool : var_bool_01;
var bool : var_bool_02;

predicate num_par_01(var int : x) =
    let { var int: y } in x = 2 * y;

predicate num_par_02(var int : x) =
          x mod 2 = 0;

%constraint
%   var_bool_01 = num_par_01(x);

%constraint
 %  var_bool_02 = num_par_02(x+1);


solve satisfy;

output
     ["  VAR_X = ", show(x), 
      "  VAR_B01 = ", show(num_par_01(x)),
      "  VAR_B02 = ", show(num_par_02(x)) ];

/*
==========
Compiling ex02.mzn
Running ex02.mzn
VAR_X = 1VAR_Y = 0
----------
VAR_X = 2VAR_Y = 0
----------
.........................
----------
VAR_X = 4VAR_Y = 2
----------
VAR_X = 4VAR_Y = 3
----------
==========
*/

