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

var int: custo_caminho = sum(i in 1..rows, j in 1..cols) (X[i,j]*matriz_pedras[i,j]);

% permitidos
%%% NAO ESTAH BOA ....
constraint forall(i in 2..(rows-1)) (
              forall(j in 2..(cols-1))(
                 X[i,j] == 1 <-> ( X[i-1,j+1] == 1 \/
								                   X[i+1,j+1] == 1 \/
                   								 X[i-1,j-1] == 1 \/
                  								 X[i+1,j-1] == 1 )
              )
           );

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

% solve minimize custo_caminho;
solve satisfy;

output [
  if i = 1 /\ j = 1 then
    "total_cost: " ++ show(custo_caminho)
  else " " endif ++
  if j = 1 then "\n" else " " endif ++
  show(X[i,j])
  | i in 1..rows, j in 1..cols
] ++ ["\n"];
