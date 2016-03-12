
int : x = 5 ; %% uma constante
int : y = 6; 

var bool : var_bool_01;
var bool : var_bool_02;


function var bool : testa_paridade(var int : N) =
          if( (N mod 2) == 0)
%         if( N == 5 )
          then
          true
          else
          false
          endif
          ;              

constraint
   var_bool_01 = (testa_paridade(x) <-> true);

constraint
   var_bool_02 == (testa_paridade(y) <-> true);

/*
constraint
  var_bool_01 == ((x mod 2) == 0);

constraint
  var_bool_02 == ((y mod 2) == 0);
 OK's fine
*/

solve satisfy;

output
     ["  VAR_X = ", show(x), "  VAR_Y = ", show(y), "\n",
      "  VAR_B01 = ", show( var_bool_01 ),
      "  VAR_B02 = ", show( fix(var_bool_01) ) ];


