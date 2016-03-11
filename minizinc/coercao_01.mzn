
int : x = 5 ; %% uma constante
int : y = 6; 

var bool : var_bool_01;
var bool : var_bool_02;

function var int : testa_paridade(var int : N) =
          if( (N mod 2) == 0)
          then
          true
          else
          false
          endif
          ;              

constraint
   var_bool_01 = testa_paridade(x);

constraint
   var_bool_02 = testa_paridade(x+1);


solve satisfy;

output
     ["  VAR_X = ", show(x), 
      "  VAR_B01 = ", show(var_bool_01 ),
      "  VAR_B02 = ", show(var_bool_01 ) ];

/*
*/

