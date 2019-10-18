int: n = 10; %% total of elements

array[1..n] of int: temp;
temp = [1,-2,3,4,5,-666,7,8,-9,10];


array[1..ub_array(temp)]  of var int: NEGATIVES_1d;

%%%%%%%%%% VAR
var int : n_negatives ;
var int : n_positives ;
%%array[1..fix(n_negative)] of var int: vector_with_negatives;

function var int : num_negatives_of(array[int] of int: vetor, int: n) = 
    let{
      array[1..n] of var 0..1: partial;
      constraint
      forall( i in 1..n )
      ( if (vetor[i] < 0)    then
        partial[i] = 1
        else
        partial[i] = 0 %%% to avoid it....
        endif
       )
     
    } in sum(partial) ;  %%% AQUI O RETORNO DA FUNCAO 



%%% to be IMPROVED
function array[int] of var int : negatives_of(array[int] of int: vetor, int: n) = 
    let{
      array[1..n] of var int: partial;
      constraint
      forall( i in 1..n )
      ( if (vetor[i] < 0)    then
        partial[i] = vetor[i]
        else
        partial[i] = 0 %%% to avoid it....
        endif
       )
     
    } in partial ;  %%% AQUI O RETORNO DA FUNCAO 

%%% using the other function
function var int : num_positives_of(array[int] of int: vetor, int: n) = 
   let {
    var int: temp =   n - num_negatives_of(vetor, n);
   } in temp;


constraint
  NEGATIVES_1d =  negatives_of(temp, n);
  
  
constraint
   n_negatives =  num_negatives_of(temp, n);
  
 
constraint
   n_positives =  num_positives_of(temp, n);
  
    
solve satisfy;
output ["\n Negatives Vector etc: " ++ show(NEGATIVES_1d) ]++
       ["\n The Lower Bound of a vector: ", show(lb_array(NEGATIVES_1d)), "\n"]++
       ["\n Number of Negatives: " ++ show(fix (n_negatives) ) ] ++
       ["\n Number of Positives: " ++ show(fix (n_positives) ) ]
              
       ;
%      " Upper Bound: ", show(ub_array(x_decision)) 
 