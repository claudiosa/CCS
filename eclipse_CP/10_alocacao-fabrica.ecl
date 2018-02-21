:- lib(ic).
alocacao(Tarefa,Custo) :-
   Custo = [[5, 1, 3, 4, 6],
		    [8, 8, 5, 7, 3],
            [4, 9, 1, 5, 2]],
   Tarefa = [T1, T2, T3],
   Tarefa :: 1..5,
   Custo = [Row1, Row2, Row3],
   element(T1, Row1, CostRow1),
   element(T2, Row2, CostRow2),
   element(T3, Row3, CostRow3),
   alldifferent(Tarefa),
   Valor #= CostRow1 + CostRow2 + CostRow3,
   Valor #>= 15,
   labeling(Tarefa).

/* , 
   Para  otimização .... adicione esta parte.
   NegValor #= (-1) * Valor, 
   %%%Para maximizar
   minimize(labeling(Tarefa), NegValor).
*/


print :-
       alocacao( [I,J,K] , [M1, M2, M3] ),
      %%	W1 is M1[I], W2 is M2[J], W3 is M3[K],
      element( I, M1, W1),
      element( J, M2, W2),
      element( K, M3, W3),

	printf("\n Trabalhador 1 esta na tarefa/tipo: %w custo: %w", [I,W1]),
	printf("\n Trabalhador 2 esta na tarefa/tipo: %w custo: %w", [J,W2]),
	printf("\n Trabalhador 3 esta na tarefa/tipo: %w custo: %w", [K,W3]),
	Total is (W1 + W2 + W3),
	printf("\n Total: %w", [Total]).

