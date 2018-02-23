
:- lib(ic).
sol :- example_CP([X,Y]),
          printf("X: %w   Y: %w   \n", [X,Y]).

example_CP( [X,Y] ) :-
   X  #:: [0..107] ,
   Y  #:: [0..1007] ,
 
   ((X #> 1)  ,
   (X #< 4) ,
   (Y #> 1) , 
   (Y #< 4)),
   or
   ((X #> 104) ,
   (X #< 107) ,
   (Y #> 1004) , 
   (Y #< 1007)),
 %  labeling([X,Y])
% search(+L, ++Arg, ++Select, +Choice, ++Method, +Option)
   %search([X,Y], 0 , random, indomain_random, complete,[])
   search([X,Y], 0 , input_order , indomain_random, complete,[])
   .
