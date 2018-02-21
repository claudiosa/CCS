/*  
USANDO MINIZINC para formulas de 1a ORDEM
*/   
var -4  .. 4 : x;
var -4  .. 4 : y;
var bool : z_REIFY;

constraint
      x >= 0;
    
constraint
      y <= 0; %% MENOR IGUAL
   %%% INCLUIR ISTO 

constraint
    z_REIFY = (x + y >= 3) \/ (x + y <= -(3) ) ;

solve satisfy;

output [" X:"  ,  show(x),"  Y:", show(y) ,"  Z:", show(z_REIFY) , "\n" ];

/**************/
