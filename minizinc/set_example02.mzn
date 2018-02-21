
set of int : set_1 = {1,2,3,4,5,6} ;
set of int : set_2 = { 3,4,5 } ;
int: K = 2;
%%
var set of int : var_SET;
   var_SET = set_function_example(set_1 , set_2); 
   %% tem que definir antes de usar .....       

function var set of int:  
     set_function_example(set  of int: x , set  of int: y) 
     % SIMPLESMENTE esta linha  =  x intersect y;   OU
     = 
     let {
           var set of int : aux_SET = x intersect y
         } 
     in aux_SET;    

%%%
constraint
    card(var_SET) > K; %%% operações permitidas em CONSTRAINTS
 

solve satisfy;

output["\n Cardinal: "++show(card(var_SET))++
       "\n Intersec: "++show(var_SET)++
       "\n Set_1: "++show(set_1)++
       "\n Set_2: "++show(set_2)
       ];



