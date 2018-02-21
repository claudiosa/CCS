int: n = 7; %% total de elementos
int: m = 4; %% m itens a serem selecionados

array[1..n] of var {0,1} : x_decision;

%% OK e direto via sum( i in 1..n ) (vetor_1d[i]);
function var int: sum_array_1d(array[1..n] of var int: vetor_1d) =
 let{
      array[1..n] of var int : temp;
      constraint                    %%%% C_1
      temp[1] == vetor_1d[1]; 
      constraint                    %%%% C_2
      forall(i in 2..n)
        ( temp[i] == temp[i-1] + vetor_1d[i] );
      } in temp[n] %%% Valor acumulado aqui
   ;

%%% constraint  m == sum( i in 1..n ) (x_decision[i]);

constraint
   m == sum_array_1d( x_decision );

solve satisfy;
output [" x_decision: " ++ show(x_decision) ];
%      " Lower Bound: ", show(lb_array(x_decision)), "\n",
%      " Upper Bound: ", show(ub_array(x_decision)) 
 