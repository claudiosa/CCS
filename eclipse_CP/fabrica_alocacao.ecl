:- lib(ic).
:- lib(branch_and_bound).

imp_sol:-
    model_fab( [A:T1,B:T2,C:T3] ), nl,
	( 
  	%% param(T1,T2,T3), se quisesse algo local ao foreach
	  count( T, 1, 3),
	  foreach(X:Y , [A:T1,B:T2,C:T3]) 
  	do
  	printf("\n Trabalhador %w esta na tarefa/tipo: %w custo: %w", [T, X,Y])
	), %% fim do bloco
  	Total is (T1 + T2 + T3),
  	printf("\n Total: %w", [Total]).


/* 		Primeira solucao 
	 Trabalhador 1 esta na tarefa/tipo: 1 custo: 5
	 Trabalhador 2 esta na tarefa/tipo: 2 custo: 8
	 Trabalhador 3 esta na tarefa/tipo: 4 custo: 5
	 Total: 18
*/
 
model_fab( [A:Custo_1,B:Custo_2,C:Custo_3] ) :-
/* 
  Dominios e Variaveis ... opcionais NESTE EXEMPLO, 
  pois estah tudo declarado na lista member
       Indice_tarefa = [A,B,C], 
	   Indice_tarefa :: [1 .. 5],
	   Custo_1 :: [ 5, 1, 3, 4, 6] ,
	   Custo_2 :: [ 8, 8 , 5, 7, 3] ,
	   Custo_3 :: [ 4, 9, 1, 5, 2], 
  
*/	   
    alldifferent([A,B,C]),
	member( A:Custo_1, [ 1:5, 2:1, 3:3, 4:4, 5:6] ),
	member( B:Custo_2, [ 1:8, 2:8, 3:5, 4:7, 5:3] ),
	member( C:Custo_3, [ 1:4, 2:9, 3:1, 4:5, 5:2] ),
    Custo_1 + Custo_2 + Custo_3 #> 15,
	
	labeling( [A, Custo_1, B, Custo_2, C, Custo_3] ).



/* outra versao com matriz */

fab_2( [I:T1, J:T2, K:T3]) :-    
       [I,J,K] :: [1 .. 5],
     	M1 =  [] (5, 1, 3, 4, 6) ,
	    M2 =  [] (8, 8 , 5, 7, 3),
	    M3 =  [] (4, 9, 1, 5, 2), 
       % dim(M1, [1,5]),
       % dim(M2, [1,5]),
       % dim(M3, [1,5]),
     	labeling( [ I, J, K]),
     	alldifferent([I,J,K]),
	subscript(M1, [I], T1),
	subscript(M2, [J], T2),
	subscript(M3, [K], T3),
	 %% OU  T1 + T2 + T3 #> 15.
	 M1[I] + M2[J] + M3[K] #> 15.

/*******************************************************/

fab_3( [I:M1, J:M2, K:M3] ) :-    
     	[I,J,K] :: [1 .. 5],
     	M1 =  [](5, 1, 3, 4, 6) ,
     	M2 =  [](8, 8 , 5, 7, 3),
     	M3 =  [](4, 9, 1, 5, 2), 
     	labeling( [ I, J, K]),
     	alldifferent([I,J,K]),
     	M1[I] + M2[J] + M3[K] #> 15.
	

imp_fab_3:-
		fab_3( [I:M1, J:M2, K:M3] ),
		W1 is M1[I], W2 is M2[J], W3 is M3[K],
		printf("\n Trabalhador 1 esta na tarefa/tipo: %w custo: %w", [I,W1]),
		printf("\n Trabalhador 2 esta na tarefa/tipo: %w custo: %w", [J,W2]),
		printf("\n Trabalhador 3 esta na tarefa/tipo: %w custo: %w", [K,W3]),
		Total is (W1 + W2 + W3),
		printf("\n Total: %w", [Total]).      

/*******************************************************/      	 
      
t10 :- herman([A:T1,B:T2,C:T3] ),
	( count( T, 1, 3),
	  foreach(X:Y , [A:T1,B:T2,C:T3]) 
	  do
	  printf("\n Trabalhador %w esta na tarefa/tipo: %w custo: %w", [T, X, Y])
	).
      
herman([T1:X1, T2:X2, T3:X3]) :-
	W1 = [](5,1,3,4,6),
	W2 = [](8,8,5,7,3),
	W3 = [](4,9,1,5,2),
	T1 :: 1..5,
	T2 :: 1..5,
	T3 :: 1..5,
	%%%  ou  simplesmente [T1,T2,T3] :: [1 .. 5],
	alldifferent([](T1,T2,T3)),
	labeling([](T1,T2,T3)),
	subscript(W1,[T1],X1),
	subscript(W2,[T2],X2),
	subscript(W3,[T3],X3),
	X1 + X2 + X3 #> 15.

/* Com minimizacao */
ismael(Tarefa) :-
   Custo = [[5, 1, 3, 4, 6],
            	[8, 8, 5, 7, 3],
            	[4, 9, 1, 5, 2]],
   Tarefa = [T1, T2, T3],
   Tarefa :: 1..5,
   Custo = [Row1, Row2, Row3],
   element(T1, Row1, CostRow1),
   element(T2, Row2, CostRow2),
   element(T3, Row3, CostRow3),
   Valor #= CostRow1 + CostRow2 + CostRow3,
   Valor #>= 15,
   NegValor #= (-1) * Valor, 
   %%% Para maximizar
   minimize(labeling(Tarefa), NegValor).

/*
?- ismael(X).
X = [5, 1, 2]
Yes (0.02s cpu)
.....
Found a solution with cost -17
Found a solution with cost -22
Found a solution with cost -23
 */
 	
