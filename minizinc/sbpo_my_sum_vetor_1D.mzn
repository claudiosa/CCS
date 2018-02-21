var int: y;
%% EQUIVALE ao sum( i in 1..n ) (vetor_1d[i]);
function var int: sum_array_1D(array[int] of var int: x_1D) =
 let{ 
      int : n = length(x_1D);
      array[1..n] of var int : temp;
      constraint                    %%%% C_1
      temp[1] == x_1D[1]; 
      constraint                    %%%% C_2
      forall(i in 2..n)
        ( temp[i] == temp[i-1] + x_1D[i] );
      } in temp[n] ; %%% Valor acumulado e RETORNO
   
constraint
      y = sum_array_1D([3,4,-7,17,13,0]);

solve satisfy;
output [" SOMA: " ++ show(y),  "\n",
      " Lim Inf: ", show(lb_array([3,4,-7,17,13,0])), "\n",
      " Lim Sup: ", show(ub_array([3,4,-7,17,13,0]))]; 
 