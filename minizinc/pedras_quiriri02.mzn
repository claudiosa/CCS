%% pedras do rio quiriri

include "globals.mzn";
int: rows;
int: cols;
rows = 5;
cols = 4;

array[1..rows, 1..cols] of int:  matriz_pedras;
matriz_pedras =
[| 1,  99,  99, 99
 | 99,  1,  99, 99
 | 1,  99,  99, 99
 | 99,  1,  99,  1
 | 99, 99,   1,  99
|]
;

var int: teste1;
var int:  teste2;
var int:  teste3;

%% decision matrix
array[1..rows, 1..cols] of var 0..1: X;

var set of int : Set_Rows = 2 .. (rows-1); %%% indices validos
var set of int : Set_Cols = 2 .. (cols-1); %%% indices validos

%% custo ....
var int: custo_caminho = 
         sum(i in 1..rows, j in 1..cols) (X[i,j]*matriz_pedras[i,j]);

%% M num de colunas
function var int: desloca (var int: i, var int: j , int: M) =
   let{
       var int: dist = M*(i-1) + j;
%      dist = M*(i-1) + j;
      }
     in (
         if (j >  M)
         then
         -99 %%% mensagem de erro.... incluir assert
         else
         M*(i-1) + j
         endif 
        )
    ;

%%% qual linha?? Falta
function var int: get_i (var int: K , int: COL) =
     if (K <= COL)
     then 
        1
     else
       (K div COL)
     endif;

%%% qual coluna? Falta
function var int: get_j (var int: K , int: COLS) =
     if (K <= COLS)
     then 
       K
     else
      (COLS - (K mod COLS))
     endif;

%%% M num de colunas 
    
constraint
    teste1 = desloca (1 , 3 ,cols) /\
    teste2 = get_i(teste1, cols)
      /\
    teste3 = get_j(teste1, cols);
%            existe_cam(X, rows ,cols) == true;


%% total de 1's na MATRIZ no Minimo eh largura do rio
constraint 
   (sum(i in 1..rows, j in 1..cols) (X[i,j])) >= cols;

%%% NO MINIMO TODA COLUNA TEM 1 NELA... e repetidos SIM talvez
constraint 
         forall(j in 1 .. cols)(
           sum(i in 1..rows) (X[i,j]) >= 1) ;

/*
%%% conectividade na matriz interna internamente
constraint 
     exists(i in Set_Rows, j in Set_Cols )
         (  
          ((X[i,j] == 1) <-> (X[i-1 , j+1] == 1)) \/
					((X[i,j] == 1) <-> (X[i+1 , j+1] == 1)) \/
          ((X[i,j] == 1) <-> (X[i-1 , j-1] == 1)) \/
          ((X[i,j] == 1) <-> (X[i+1 , j-1] == 1))
          );

%%% nas extremidades-BORDAS da matriz
%% coluna a esquerda
constraint 
     forall(i in Set_Rows, j in {1} )
     (
      ((X[i,j] == 1) <-> (X[i-1,j+1] == 1))
                     \/
      ((X[i,j] == 1) <-> (X[i+1,j+1] == 1))
     );
%% coluna a direita
constraint 
     forall(i in Set_Rows, j in {cols} )
     (  
      ((X[i,j] == 1) <->  (X[i-1, j-1] == 1))
                     \/
      ((X[i,j] == 1) <-> (X[i+1, j-1] == 1))
     );

%%%% para linha superior
constraint 
     forall(j in Set_Cols, i in {1} )
     (  
       ((X[i,j] == 1) <-> (X[i+1, j-1] == 1))
                      \/
       ((X[i,j] == 1) <-> (X[i+1, j+1] == 1) )     
     );

%% linha inferior
constraint 
     forall(j in Set_Cols, i in {rows} )
     (  
       ((X[i,j] == 1) <-> (X[i-1 , j-1] == 1))
                      \/
       ((X[i,j] == 1) <-> (X[i-1 , j+1] == 1))
     );

%% CANTOS

constraint 
  (X[1,1] == 1) <-> (X[2,2] == 1);

constraint 
  (X[rows,1] == 1) <-> (X[(rows-1),2] == 1);

constraint 
  (X[1,cols] == 1) <-> (X[2,(cols-1)] == 1);

constraint 
  (X[rows,cols] == 1) <-> (X[(rows-1),(cols-1)] == 1);

*/

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
  ++["\n"]++
  [show(fix(teste1))]  ++["\n"]++
  [show(teste2)] ++["\n"]++
  [show(teste3)] ;

