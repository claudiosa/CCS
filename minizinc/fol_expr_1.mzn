/*  
*/   
var -5  .. 5 : x;
var -5  .. 5 : y;

constraint
      x > 0;
    
constraint
      y <= 0;
   %%% INCLUIR ISTO 

constraint
     x + y > 0;


solve satisfy;

output ["   X: "  ,  show(x),"     Y: ", show(y) , "\n" ];



/*****
*********/
