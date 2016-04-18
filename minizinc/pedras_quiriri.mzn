

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

array[1..rows, 1..cols] of var 0..1: X;
%% to store ONE TRIP -- sequencia da viagem

array[1..(rows+cols)] of var 1..(rows+cols) : x_TOUR;


var int: custo_caminho = sum(i in 1..rows, j in 1..cols) (X[i,j]*matriz_pedras[i,j]);



constraint
  exists(i in 1..rows, j in 1..cols, ) 
    (  
       if X[i, j] == 1 then x_TOUR[i] = j else true endif
    )
     /\
    circuit(x_TOUR) %% 
    %circuit(x_TOUR) ath( X , i , j)
    ; 

% permitidos
%%% NAO ESTAH BOA ....
constraint forall(i in 2..(rows-1)) (
              forall(j in 2..(cols-1))(
                if( X[i,j] == 1) then ( X[i-1,j+1] == 1 \/
								                   X[i+1,j+1] == 1 \/
                   								 X[i-1,j-1] == 1 \/
                  								 X[i+1,j-1] == 1 )
                                  else
                                  true
                endif
              )
           );

/*
OR
                 X[i,j] == 1 <-> ( X[i-1,j+1] == 1 \/
								                   X[i+1,j+1] == 1 \/
                   								 X[i-1,j-1] == 1 \/
                  								 X[i+1,j-1] == 1 )


predicate exists_path(array[int,int] of var 0..1 : graph, var int: source, var int: target) =
let {
     set of int: V = index_set_1of2(graph);
    }
  in (
  if graph[source, target] == 1 then true
     else (exists(x in V, where graph[source,x]==1) (exists_path(graph, x, target)))
  endif
);
  
*/
/*
% nao permitidos
constraint forall(i in 2..(rows-1)) (
              forall(j in 2..(cols-1))(
                 X[i,j] == 1 -> ( X[i-1,j] == 0 \/
								                  X[i,j+1] == 0 \/
                   								X[i,j-1] == 0 \/
                  								 X[i+1,j+1] == 0 )
              )
           );
*/
%% total de 1's na MATRIZ no minimo eh largura do rio
constraint sum(i in 1..rows, j in 1..cols) (X[i,j]) >= cols;

%%% NO MINIMO CADA COLUNA TEM 1 ... repetidos SIM
constraint 
            forall(j in 1 .. cols)(
                  sum(i in 1..rows) (X[i,j]) >= 1)
                  ;


%% nem precisam
%constraint sum(i in 1..rows) (X[i,cols]) >= 1; % garante que a ultima coluna tenha no minimo 1

%constraint sum(i in 1..rows) (X[i,1]) >= 1; % garante que a primeira coluna tenha no minimo 1

solve minimize custo_caminho;
%solve satisfy;

output [
  if i = 1 /\ j = 1 then
    "total_cost: " ++ show(custo_caminho)
  else " " endif ++
  if j = 1 then "\n" else " " endif ++
  show(X[i,j])
  | i in 1..rows, j in 1..cols
] ++ ["\n"];
