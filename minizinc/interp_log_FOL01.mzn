%%% Se estes limites fossem variaveis?
%int: n = 3; %%% OU ABAIXO VIA EXPLICITO
int : n;

int: m = 4;

%%% \Phi interpretacoes logicas
var  bool : Phi01;
var  bool : Phi02;
var  bool : Phi03;


x = [1, 3, 5];
y = [2, 4, 6, 8];
array[1..n] of int : x;
array[1..m] of int : y;

constraint %% Para todos x > .... em .....
/*
  forall  (i  in 1..n ) 
   (x[i] > 4) <-> (Phi01 == true);
%%%OU simplesmente
*/
   Phi01 == forall  (i  in 1.. length(x) ) 
            (x[i] > 4);

constraint %%% Existe  um y para  todos x tal que y>x 
Phi02 == 
     exists(i in 1..  length(y))(
      forall  (j  in 1.. length(x) )( 
%%   (x[j] <= y[i]) %%% OU
       y[i] > x[j]
      )
     );
/* OU simplesmente
 exists(i in 1..m)(
  forall  (j  in 1..n )( 
%%   (x[j] <= y[i]) <-> (Phi02 == true) %%% OU
     (y[i] > x[j]) <-> (Phi02 == true)
   )
  );

*/
constraint %%% Existe um x para  todos x tal que x>=x 
 exists(i in 1..n)(
  forall  (j  in 1..m )( 
   (x[i] >= y[j]) <-> (Phi03 == true) %%% OU
%     (y[j] > x[i]) <-> (Phi03 == true)
   )
   );

% minimize or maximize something
solve satisfy; 

output [
  "Phi01: " ++ show(Phi01) ++"\n"++
  "Phi02: " ++ show(Phi02) ++"\n"++
  "Phi03: " ++ show(Phi03) ++"\n"++
   "x: " ++ show( x ) ++ "\n" ++
   "y: " ++ show( y ) ++ "\n" ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%