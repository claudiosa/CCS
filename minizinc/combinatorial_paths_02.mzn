%Dada a descricao de um grafo e um ponto de origem e outro de fim,
%encontrar todos os caminhos distintos entre estes dois pontos.

int : n;
1..n : inicio;
1..n : final;

%%matriz de adjacencia
array[1..n,1..n] of 0..1 : mat;
%%vetor que marca o caminho
array[1..n] of var 0..n : caminho;

%%definir que o ultimo eh o objetivo, e que todos os anteriores sao != de 0 e todos apos sao 0
constraint
  exists(i in 1..n)(
    caminho[i] = final
    /\ forall(j in i+1..n) ( caminho[j] = 0 )
    /\ forall(j in 1..i) ( caminho[j] != 0 )
  );

%%define que todos sao !=, exceto os 0
constraint
  forall(i in 1..n, j in 1..n where i!=j)(
    ( caminho[i] != 0 \/ caminho[j] != 0 ) <-> ( caminho[i] != caminho[j] )
  );

%%define os caminhos
constraint
  caminho[1] = inicio /\
  forall(i in 2..n)(
    ( caminho[i] != 0 ) -> ( mat[caminho[i-1],caminho[i]] = 1)
  );

solve satisfy;

output[
  "Caminho: " ++ show(caminho)
];

n = 6;
inicio = 1;
final = 6;
mat = [|0,1,0,1,0,0,
       |1,0,1,0,0,0,
       |0,1,0,0,0,1,
       |1,0,0,0,1,0,
       |0,0,0,1,0,1,
       |0,0,1,0,1,0|];

/*
%ENTRADA
n = 4;
inicio = 1;
final = 4;
mat =  [|0,1,1,0,
	      |1,0,0,1,
	      |1,0,0,1,
	      |0,1,1,0|];
%SAIDA
Caminho: [1, 2, 4, 0]
----------
Caminho: [1, 3, 4, 0]
----------
%ENTRADA
n = 6;
inicio = 1;
final = 6;
mat = [|0,1,0,1,0,0,
       |1,0,1,0,0,0,
       |0,1,0,0,0,1,
       |1,0,0,0,1,0,
       |0,0,0,1,0,1,
       |0,0,1,0,1,0|];
%SAIDA
Caminho: [1, 2, 3, 6, 0, 0]
----------
*/