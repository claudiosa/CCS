%% pedras do rio quiriri

include "globals.mzn";
int: rows;
int: cols;
%%%%%%%%
rows = 5;
cols = 4;
set of int : K_set  = 1 .. (rows*cols);
%%%%%%%%
array[1..rows, 1..cols] of int:  matriz_pedras;
matriz_pedras =
[| 1,  99,  99, 99
 | 99,  1,  99, 99
 | 1,  99,  99, 99
 | 99,  1,  99,  1
 | 99, 99,   1,  99
|]
;

var int:  teste1;
var int:  teste2;
var int:  teste3;

%% decision matrix
array[1..rows, 1..cols] of var 0..1: X;

array[K_set] of var int : distancias;

var set of int : Set_Rows = 2 .. (rows-1); %%% indices validos
var set of int : Set_Cols = 2 .. (cols-1); %%% indices validos

%% custo ....
var int: custo_caminho = 
         sum(i in 1..rows, j in 1..cols) (X[i,j]*matriz_pedras[i,j]);

%% function for distance in a matrix 
function var int: desloca (var int: i, var int: j , int: n_COLS) =
%   let{
%       var int: dist = n_COLS*(i-1) + j;
%       dist = M*(i-1) + j;
%      }
%     in (
         if (j >  n_COLS)
         then
         -999999 %%% mensagem de erro.... incluir assert
         else
         n_COLS*(i-1) + j
         endif 
%        ) %% in
    ;

%%% Which is the row?? suposition: i and j starting with 1
%%% attention: n_cols .... vertical coluns
function var int: get_i (var int: Dist , int: n_COLS) =
     if (Dist <= n_COLS)
     then 
        1
     else
       ((Dist - 1) div n_COLS) + 1
     endif;

%%% Which is the Column?? suposition: i and j starting with 1
function var int: get_j (var int: Dist , int: n_COLS) =
     if (Dist <= n_COLS)
     then 
       Dist
     else
      ((Dist - 1) mod n_COLS) + 1
     endif;
%%% M num de colunas 

function array[K_set] of var int: fill_index (set of int : K_set, int: rows , int:  cols) =
     let{
         array[K_set] of var int : distancias;
         set of int : Set_Rows = 1 .. rows;
         int :  t_1 = rows ;
         constraint %%% It is local  EVERYTHING
%%%%%%%%%%%%%%%%%%%%%%%%%WHY .....
         forall(k in K_set, i in 2 .. 2 , j in 1 .. 1)   
         ( 
           distancias[k] =  desloca(i , j , cols)
         );
           % distancias[1] = desloca(1 , 3 , cols) /\
           % distancias[2] = desloca(1 , 2 , cols);
        } 
        in
        distancias;  

constraint
      distancias = fill_index (K_set, rows , cols);
/* OK    distancias[1] = 100       /\
       distancias[10] = 100      /\
       distancias[20] = 100;

constraint
    teste1 = desloca (3 , 2 ,cols) 
      /\
    teste2 = get_i(teste1, cols)
      /\
    teste3 = get_j(teste1, cols);
%            existe_cam(X, rows ,cols) == true;
*/

%% total de 1's na MATRIZ no Minimo eh largura do rio
constraint 
   (sum(i in 1..rows, j in 1..cols) (X[i,j])) >= cols;

%%% NO MINIMO TODA COLUNA TEM 1 NELA... e repetidos SIM talvez
constraint 
         forall(j in 1 .. cols)(
           sum(i in 1..rows) (X[i,j]) >= 1) ;


%solve minimize custo_caminho;
solve satisfy;

output [
  if i = 1 /\ j = 1 then
    "total_cost: " ++ show(custo_caminho)
  else " " endif ++
  if j == 1 then "\n" else " " endif ++
  show(X[i,j])++ ":" ++   show(matriz_pedras[i,j])
  | i in 1..rows, j in 1..cols
  ] %++ ["\n"++ "Inicial: " ++ show(x_inicial) ++ 
  %    " Final: " ++ show(x_final)] 
  ++["\n Distance Vector: " ]++ 
  [show(distancias)] ++ ["\n"] 
 % ++
 % [show(fix(teste1))]  ++ ["\n Row: "]++
 % [show(teste2)] ++ ["\n Colun: "]++
 % [show(teste3)] 
 ;

