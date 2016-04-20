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

%% decision matrix
array[1..rows, 1..cols] of var 0..1: X;

var set of int : Set_Rows = 2 .. (rows-1); %%% indices validos
var set of int : Set_Cols = 2 .. (cols-1); %%% indices validos

%% custo ....
var int: custo_caminho = 
         sum(i in 1..rows, j in 1..cols) (X[i,j]*matriz_pedras[i,j]);

%%% um predicado ... mas nao usado
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


%% total de 1's na MATRIZ no Minimo eh largura do rio
constraint 
   (sum(i in 1..rows, j in 1..cols) (X[i,j])) > cols+1;


%%% NO MINIMO TODA COLUNA TEM 1 NELA... e repetidos SIM talvez
constraint 
         forall(j in 1 .. cols)(
           sum(i in 1..rows) (X[i,j]) >= 1)
         ;

%%% algumas linhas podem ter 0 ... e repetidos SIM talvez %%% FINS DIDATICOS
%% esta constraint nao faz diferenca 
constraint 
      exists(i in 1 .. rows)(
         (sum(j in 1 .. cols) (X[i,j]) >= 0)
         )
         ;


%%% conectividade na matriz interna internamente
constraint 
     exists(i in Set_Rows, j in Set_Cols )
         (  
          ((X[i,j] == 1) <-> (X[i-1 , j+1] == 1 \/
							                X[i+1 , j+1] == 1 \/
                 							X[i-1 , j-1] == 1 \/
                 							X[i+1 , j-1] == 1 )
             )
          );


%%% nas extremidades-BORDAS da matriz
constraint 
     forall(i in Set_Rows, j in {1} )
     (
      ((X[i,j] == 1) <-> (X[i-1,j+1] == 1))
                     \/
      ((X[i,j] == 1) <-> (X[i+1,j+1] == 1))
     );

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
       ((X[i,j] == 1) <-> (X[i-1,j-1] == 1))
                      \/
       ((X[i,j] == 1) <-> (X[i-1,j+1] == 1))
     );


/*
OR

                 if( X[i,j] == 1) then 
                      ( X[i-1,j+1] == 1 \/
								         X[i+1,j+1] == 1 \/
                   				X[i-1,j-1] == 1 \/
                  				 X[i+1,j-1] == 1 )
                                  else
                          true
                endif

*/
  

%% nem precisam jah contempladas
%%constraint sum(i in 1..rows) (X[i,cols]) >= 1; % garante que a ultima coluna tenha no minimo 1
%% nem precisam jah contempladas
%%constraint sum(i in 1..rows) (X[i,1]) >= 1; % garante que a primeira coluna tenha no minimo 1

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
