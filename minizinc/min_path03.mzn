%% LUCAS MACHADO
/* ############################## DESCRIÇÃO ############################
Implemente um algoritmo para um caminho mínimo entre dois pontos.
######################################################################*/

/* ############################# ESTRATÉGIA ############################
A estratégia consistiu na utilização de duas variaves de decisão, sendo uma matriz e um vetor.
A matriz de decisão é responsavel por escolher quais arestas estão contidas na solução, já o vetor
é responsavel por escolher quais vértices estão contidos na solução.
As restrições tem o papel de garantir que o conjunto de arestas e vertices resultam numa solução valida.
Para achar a melhor solução (caminho minímo) executa-se uma busca com intuito de minimizar o soma dos custos das arestas escolhidas.
#######################################################################*/

/* ############################## CODE ###############################*/

int: s = 1;
int: t = 10 ;
int: n = 10;

array[1..n, 1..n] of int: mtx;
mtx = [|
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


array[1..n, 1..n] of var 0..1: dmtx;

array[1..n] of var 0..1: dnode;

var int: soma = sum(i in 1..n, j in 1..n)(dmtx[i,j]*mtx[i,j]);

constraint
	forall(i in 1..n, j in 1..n)(
		dmtx[i,j] == 1 -> mtx[i,j] > 0
	);

constraint
	dnode[s] == 1 /\
	dnode[t] == 1;

constraint
	sum(i in 1..n)(dmtx[s,i]) == 1 /\
	sum(i in 1..n)(dmtx[i,s]) == 0;

constraint
	sum(i in 1..n)(dmtx[t,i]) == 0 /\
	sum(i in 1..n)(dmtx[i,t]) == 1;
	
constraint
	forall(i in 1..n where i!=s /\ i!=t)
   (
		(dnode[i] == 1 <-> (sum(j in 1..n)(dmtx[i,j])==1 /\ sum(j in 1..n)(dmtx[j,i])==1)) /\
		(dnode[i] == 0 <-> (sum(j in 1..n)(dmtx[i,j])==0 /\ sum(j in 1..n)(dmtx[j,i])==0))
	 );
	


solve minimize soma;


output [
 if i = 1 /\ j = 1 then
  "\t Custo=" ++ show(soma) ++ "\n" ++
  "\t Nos escolhidos:" ++ show(dnode) ++ "\n\tGraficamente: \n\n"
  else "" endif ++
 if j = 1 then show(i) ++ " : " else "" endif ++
       show(dmtx[i,j]) ++ if j = n then "\n" else " " endif
       | i in 1..n, j in 1..n
];
%###############################################################
