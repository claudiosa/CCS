
int : ctex = 5 ; %% a constant
int : ctey = 6; 

var bool : var_bool_01;
var bool : var_bool_02;

%%% My mistake =>  int : N and NOT var int : N ... N is a parameter or constant
function var bool :  testa_paridade(int : N) =
     if( (N mod 2) == 0)
        then
          true
        else
          false
      endif;
  

constraint
   var_bool_01 == testa_paridade(ctex);

constraint
   var_bool_02 == testa_paridade(ctey);

/*
constraint
  var_bool_01 == ((x mod 2) == 0);

constraint
  var_bool_02 == ((y mod 2) == 0);
 OK's fine
*/

solve satisfy;

output
    ["  CTE_X = ", show(ctex), "  CTE_Y = ", show(ctey), "\n",
     "  VAR_B01 = ", show(  var_bool_01 ),
     "  VAR_B02 = ", show( var_bool_02 ) 
    ]
    ;
%%  para o futuro: "  VAR_B01 = ", show(  fix(bool2int(var_bool_01)) ),

