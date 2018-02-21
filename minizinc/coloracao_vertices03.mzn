/* Cores dos vertices */
/*
Problema:
O problema eh dado um grafo nao direcionado, definir o numero minimo de cores necessarias para pintar ele. 
*/
/*
Resolucao:
Definir dois vetores que representam as arestas, Ai e Aj, onde o vertice Ai[k] esta conectado com o vertice Aj[k].
Definir um vetor de cores dos vertices "V"
Definir uma variavel que armazenara o numero maximo de cores.
Definir que as cores dos vertices devem ser maiores que 0
Definir que os vertices vizinhos possuem cores diferentes
Encontrar a maior cor dentre as cores dos vertices
Realizar a busca com o parametro indomain_min, para tentar sempre as menores cores nos vertices.
*/
/*
Entradas:
As entradas utilizadas estao divididas em arquivos disponibilizados junto a este codigo.
*/

include "globals.mzn";

%%parametro, o numero de vertices.
int : n;
%%parametro, o numero de arestas.
int : m;

%%parametro, dois vetores para arestas,
%%tal que o vertice Ai[k] esta ligado com o vertice Aj[k]
array[1..m] of 0..(n-1) : Ai;
array[1..m] of 0..(n-1) : Aj;

/* Pode vir de um arquivo SEPARADO */
n = 20;
m = 23;
Ai = [0, 1, 1, 1, 1, 2, 2, 2, 3, 
      3, 3, 4, 4, 4, 5, 5, 6, 9, 
      10, 11, 13, 15, 16];
Aj = [16, 2, 6, 7, 8, 11, 16, 17, 
      14, 16, 17, 7, 13, 17, 6, 11, 
      18, 12, 13, 17, 15, 17, 19];


%%um vetor para vertices
array[1..n] of var int : V;

%%numero de cores necessarias
var int : cores;

%%os vertices devem ser maiores ou iguais a zero
constraint
  forall(k in 1..n)(
    V[k] >= 0  
  );

%%todas os vertices com arestas entre si devem ser diferentes
constraint
	forall(k in 1..m)(
    V[Ai[k]+1] != V[Aj[k]+1]
  );

%%cores recebera o valor maximo dentre os vertices
constraint
  maximum(cores, V);

%%foram utilizados os parametros do search, para iniciar as buscas pelos menores valores do dominio
solve :: int_search(V, smallest, indomain_min, complete) satisfy;
%%opcao seria utilizar a minimizacao abaixo, contudo seria muito lento
%%minimize sum (k in 1..n)(V[k])

%%exibe cada vertice do grafo
output[
  if k = 1 then "Cores necessarias = " ++ show(cores) ++ "\nCores de cada vertice:\n" else "" endif
	++"Vertice " ++ show(k) ++ " com cor = " ++ show(V[k]) ++ "\n"
  | k in 1..n
];

/*
%%%%%%%
%Saida%
%%%%%%%%%%%%%%%%%
%Para a entrada3%
%%%%%%%%%%%%%%%%%
Cores necessarias = 4
Cores de cada vertice:
Vertice 1 com cor = 0
Vertice 2 com cor = 0
Vertice 3 com cor = 1
Vertice 4 com cor = 2
Vertice 5 com cor = 1
Vertice 6 com cor = 0
Vertice 7 com cor = 2
Vertice 8 com cor = 1
Vertice 9 com cor = 0
Vertice 10 com cor = 2
Vertice 11 com cor = 3
Vertice 12 com cor = 4
Vertice 13 com cor = 0
Vertice 14 com cor = 1
Vertice 15 com cor = 0
Vertice 16 com cor = 0
Vertice 17 com cor = 0
Vertice 18 com cor = 0
Vertice 19 com cor = 2
Vertice 20 com cor = 1
----------

*/