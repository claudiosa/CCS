

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

%array[1..(rows+cols)] of var 1..(rows+cols) : x_TOUR;

var 1 .. rows : x_inicial;
var 1 .. rows : x_final;

var int: custo_caminho = sum(i in 1..rows, j in 1..cols) (X[i,j]*matriz_pedras[i,j]);


predicate existe_cam(array[int,int] of var 0..1 : graph, int: lin, int: col)
 =
let {
      var set of int : Linhas = 1..lin;
      var set of int : Colunas = 1..col;
    }
  in (

      exists(i in Linhas, j in Colunas where graph[i,j] == 1) 
          ( 
            graph[i-1,j+1] == 1 \/
						graph[i+1,j+1] == 1 \/
            graph[i-1,j-1] == 1 \/
            graph[i+1,j-1] == 1 
           )
       );

%constraint
%            existe_cam(X, rows ,cols) == true;

%% total de 1's na MATRIZ no minimo eh largura do rio
constraint sum(i in 1..rows, j in 1..cols) 
           (X[i,j]) >= cols;


%%% NO MINIMO CADA COLUNA TEM 1 ... e repetidos SIM talvez
constraint 
          forall(j in 1 .. cols)(
          sum(i in 1.. rows) (X[i,j]) >= 1)
         ;
        %  forall(i in 1 .. rows)(
        %  sum(j in 1..cols) (X[i,j]) >= 1)
/*
constraint exists(i in 1..rows )
           (
            X[i,1] == 1 <-> x_inicial == i  /\
            X[i,cols] == 1 <-> x_final == i
            );
*/
% permitidos
%%% NAO ESTAH BOA ....
constraint %exists(i in 1..(rows), j in 1..(cols) )
           exists(i in 2..(rows-1), j in 2..(cols-1) )
                 (
                 if( X[i,j] == 1) then 
                                 ( X[i-1,j+1] == 1 \/
								                   X[i+1,j+1] == 1 \/
                   								 X[i-1,j-1] == 1 \/
                  								 X[i+1,j-1] == 1 )
                                  else
                                  true
                endif
              );

/*
OR
                 X[i,j] == 1 <-> ( X[i-1,j+1] == 1 \/
								                   X[i+1,j+1] == 1 \/
                   								 X[i-1,j-1] == 1 \/
                  								 X[i+1,j-1] == 1 )

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


%% nem precisam
%constraint sum(i in 1..rows) (X[i,cols]) >= 1; % garante que a ultima coluna tenha no minimo 1

%constraint sum(i in 1..rows) (X[i,1]) >= 1; % garante que a primeira coluna tenha no minimo 1

solve minimize custo_caminho;
%solve satisfy;

output [
  if i = 1 /\ j = 1 then
    "total_cost: " ++ show(custo_caminho)
  else " " endif ++
  if j == 1 then "\n" else " " endif ++
  show(X[i,j])++ ":" ++   show(matriz_pedras[i,j])
  | i in 1..rows, j in 1..cols
] %++ ["\n"++ "Inicial: " ++ show(x_inicial) ++ 
  %    " Final: " ++ show(x_final)] 
++["\n"];
