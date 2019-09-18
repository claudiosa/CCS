int: n = 10; %% total de elementos

array[1..n] of int: temp;
temp = [1,-2,3,4,5,-666,7,8,-9,10];
array[1..ub_array(temp)]  of var int: NEGATIVES_1d;

function array[int] of var int : negatives_of_vetor(array[int] of int: vetor, int: n) = 
    let{
      array[1..n] of var int: partial;
      constraint
      forall( i in 1..n )
      ( if (vetor[i] < 0)    then
        partial[i] = vetor[i]
        else
        partial[i] = 0
        endif
       )
     
    } in partial ;  %%% AQUI O RETORNO DA FUNCAO 

constraint
  NEGATIVES_1d =  negatives_of_vetor(temp, n);
    
solve satisfy;
output ["\n Negatives Vector etc: " ++ show(NEGATIVES_1d) ]++
       ["\n The Lower Bound of a vector: ", show(lb_array(NEGATIVES_1d)), "\n"];
%      " Upper Bound: ", show(ub_array(x_decision)) 
 