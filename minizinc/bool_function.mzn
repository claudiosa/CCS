int : X = 5 ; %%  constantes
int : Y = 6; 
var bool : var_bool_01;
var bool : var_bool_02;

%%% Temos if-then-else-endif
function var bool :  testa_paridade(int : N) =
     if( (N mod 2) == 0)
        then
          true
        else
          false
      endif;
  
constraint
   var_bool_01 == testa_paridade(X);

constraint
   var_bool_02 == testa_paridade(Y);

/* OR  var_bool_01 == ((x mod 2) == 0);
       var_bool_02 == ((y mod 2) == 0);  */

solve satisfy;

output
    ["  CTE_X = ", show(X), "  CTE_Y = ", show(Y), "\n",
     "  VAR_B01 = ", show( var_bool_01 ),
     "  VAR_B02 = ", show( var_bool_02 )  ] ;


