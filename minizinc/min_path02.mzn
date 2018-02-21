% Ramon e Jonathan
%Dado um grafo e um ponto de inicio e fim, 
%encontrar o menor caminho entre os dois pontos.x

int : n;
1..n : inicio;
1..n : final;

%%matriz de adjacencia
array[1..n,1..n] of int : mat;
%%vetor que marca o caminho
array[1..n] of var 0..n : caminho;
%%custo do caminho
var int : custo;
array[1..n] of var int : custos_parciais;

constraint
  custo = sum(i in 1..n) (  
    custos_parciais[i]
  );

%%defi4nir que o ultimo eh o objetivo, 
%e que todos os anteriores sao != de 0 e todos apos sao 0
constraint
  exists(i in 1..n)(
    caminho[i] = final
    /\ forall(j in i+1..n) ( caminho[j] = 0 /\ custos_parciais[j] = 0 )
    /\ forall(j in 1..i) ( caminho[j] != 0 )
    /\ forall(j in 2..i) ( custos_parciais[j] != 0 )
  );

%%define que todos sao !=, exceto os 0
constraint
  forall(i in 1..n, j in 1..n where i!=j)(
    ( caminho[i] != 0 \/ caminho[j] != 0 ) <-> ( caminho[i] != caminho[j] )
  );

%%define os caminhos
constraint
  caminho[1] = inicio /\
  custos_parciais[1] = 0 /\
  forall(i in 2..n)(
    ( caminho[i] != 0 ) ->
      (
        mat[caminho[i-1],caminho[i]] > 0
        /\ custos_parciais[i] = mat[caminho[i-1],caminho[i]]
      )
  );

solve minimize custo;

output[
  "Custo: " ++ show(custo)
  ++ "\nCaminho: " ++ show(caminho)
];

n = 10;
inicio = 1;
final = 10;
/*
mat = [|0,16,10,0,0,0,0,8,0,0,
       |16,0,0,18,0,50,0,0,0,42,
       |10,0,0,50,0,0,0,20,0,0,
       |0,18,50,0,0,0,0,30,15,0,
       |0,0,0,0,0,9,3,0,30,0,
       |0,50,0,0,9,0,10,0,16,10,
       |0,0,0,0,3,10,0,0,0,0,
       |8,0,20,30,0,0,0,0,0,0,
       |0,0,0,15,30,16,0,0,0,8,
       |0,42,0,0,0,10,0,0,8,0|];
*/
%% idem do Rafael e Fernanda
mat = [|
% 00, 01, 02, 03, 04, 05, 06, 07, 08, 09
   0, 16, 10,  0,  0,  0,  0,  8,  0,  0 |   %% 00
  16,  0,  0, 18,  0, 50,  0,  0,  0, 42 |   %% 01
  10,  0,  0, 50,  0,  0,  0, 20,  0,  0 |   %% 02
   0, 18, 50,  0,  0,  0,  0, 30, 15,  0 |   %% 03
   0,  0,  0,  0,  0,  9,  3,  0, 30,  0 |   %% 04
   0, 50,  0,  0,  9,  0, 10,  0, 16, 10 |   %% 05
   0,  0,  0,  0,  3, 10,  0,  0,  0,  0 |   %% 06
   8,  0, 20, 30,  0,  0,  0,  0,  0,  0 |   %% 07
   0,  0,  0, 15, 30, 16,  0,  0,  0,  8 |   %% 08
   0, 42,  0,  0,  0, 10,  0,  0,  8,  0 |]; %% 09


/*
%ENTRADA
n = 7;
inicio = 1;
final = 7;
mat = [|0, 5, 0, 3, 0, 0, 0,
       |0, 0, 5, 0, 0, 0, 0,
       |3, 0, 0, 2, 4, 0, 0,
       |0, 0, 0, 0, 2, 6, 0,
       |0, 1, 0, 0, 0, 0, 1,
       |0, 0, 0, 0, 0, 0, 9,
       |0, 0, 0, 0, 0, 0, 0|];
%SAIDA
Custo: 6
Caminho: [1, 4, 5, 7, 0, 0, 0]
----------
%ENTRADA
n = 10;
inicio = 1;
final = 10;
mat = [|0,16,10,0,0,0,0,8,0,0,
       |16,0,0,18,0,50,0,0,0,42,
       |10,0,0,50,0,0,0,20,0,0,
       |0,18,50,0,0,0,0,30,15,0,
       |0,0,0,0,0,9,3,0,30,0,
       |0,50,0,0,9,0,10,0,16,10,
       |0,0,0,0,3,10,0,0,0,0,
       |8,0,20,30,0,0,0,0,0,0,
       |0,0,0,15,30,16,0,0,0,8,
       |0,42,0,0,0,10,0,0,8,0|];
%SAIDA
Custo: 57
Caminho: [1, 2, 4, 9, 10, 0, 0, 0, 0, 0]
----------
*/