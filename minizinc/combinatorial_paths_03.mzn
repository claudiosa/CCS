/* ############################## DESCRIÇÃO ############################
Inicialmente dado um quadrado n x n dispostos como os dois primeiros exemplos da figura
1. Considerando sempre o mesmo ponto de partida (p) e o de chegada (c). A proposta é
encontrar quantos caminhos possíveis, sem repetições entre nós e arcos, existem entre estes 2
pontos.
######################################################################*/

/* ############################# ESTRATÉGIA ############################
A estratégia consistiu na utilização de duas variaves de decisão, sendo uma matriz e um vetor.
A matriz de decisão é responsavel por escolher quais arestas estão contidas na solução, já o vetor
é responsavel por escolher quais vértices estão contidos na solução.
As restrições tem o papel de garantir que o conjunto de arestas e vertices resultam numa solução valida.
#######################################################################*/

/* ############################## CODE ###############################*/

int: n=2;
int: m=3;

int: s=1;
int: t=n*m;

array[1 .. n*m, 1 .. n*m] of var 0 .. 1: dmtx;

array[1 .. n*m] of var 0 .. 1: dnode;

constraint
	forall(i in 1 .. n*m, j in 1 .. n*m)(
		dmtx[i,j] == 1 -> (( (abs(i-j)==1) /\ (((i-1) div m) == ((j-1) div m)) ) \/ ( abs(i-j)==m ))
	);


constraint
	dnode[s] == 1 /\
	dnode[t] == 1;

constraint
	sum(i in 1 .. n*m)(dmtx[s,i]) == 1 /\
	sum(i in 1 .. n*m)(dmtx[i,s]) == 0;

constraint
	sum(i in 1 .. n*m)(dmtx[t,i]) == 0 /\
	sum(i in 1 .. n*m)(dmtx[i,t]) == 1;

constraint
	forall(i in 1 .. n*m where i!=s /\ i!=t)(
		(dnode[i] == 1 <-> (sum(j in 1 .. n*m)(dmtx[i,j])==1 /\ sum(j in 1 .. n*m)(dmtx[j,i])==1)) /\
		(dnode[i] == 0 <-> (sum(j in 1 .. n*m)(dmtx[i,j])==0 /\ sum(j in 1 .. n*m)(dmtx[j,i])==0))
	);

constraint
	forall(i in 1 .. n*m, j in 1 .. n*m)(
		dmtx[i,j]==1 -> dmtx[j,i] == 0
	);

solve satisfy;

output[/*"nodes:",show(dnode)*/
		show(dmtx[i,j]) ++ if j==n*m then "\n" else " " endif | i in 1 .. n*m, j in 1 .. n*m
];

/*##################### SAIDA ##########################################

NAO HAH MATRIZ de entrada ?
Os valores sao definidos por  m e n?

a saida abaixo é para a entrada n=2 e m=3 e apresenta a matriz de decisão de arestas
0 1 0 0 0 0
0 0 1 0 0 0
0 0 0 0 0 1
0 0 0 0 0 0
0 0 0 0 0 0
0 0 0 0 0 0
----------
0 1 0 0 0 0
0 0 0 0 1 0
0 0 0 0 0 0
0 0 0 0 0 0
0 0 0 0 0 1
0 0 0 0 0 0
----------
0 0 0 1 0 0
0 0 0 0 0 0
0 0 0 0 0 0
0 0 0 0 1 0
0 0 0 0 0 1
0 0 0 0 0 0
----------
0 0 0 1 0 0
0 0 1 0 0 0
0 0 0 0 0 1
0 0 0 0 1 0
0 1 0 0 0 0
0 0 0 0 0 0
----------
==========


##################### SAIDA ##########################################*/
