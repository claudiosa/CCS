:- lib(ic).
:- lib(branch_and_bound).

inic:-
	modelo([M1, M2, M3],[C1, C2, C3]),
	writeln("Maq 1 estah na tarefa" :M1 :C1),
	writeln("Maq 2 estah na tarefa" :M2 :C2),
	writeln("Maq 3 estah na tarefa" :M3 :C3).
	
modelo(Maquinas,[CostRow1,CostRow2, CostRow3] ) :-
   Matriz = 
			[[1, 11, 5, 7, 13],
             [4, 6, 2, 8, 10],
             [6, 3, 9, 12, 15]
            ],
   Matriz = [Row1, Row2, Row3],
   
   Maquinas = [M1, M2, M3],
   Maquinas :: 1..5, %%% cada uma das maquinas
   %% serah alocada hah uma das 5 tarefas
   
   %% logo
   alldifferent(Maquinas),%% =[M1, M2, M3] ,
   element(M1, Row1, CostRow1),
   element(M2, Row2, CostRow2),
   element(M3, Row3, CostRow3),
   %% labeling([M1, M2, M3]). testar a arvore
   %%
    
   Valor #= CostRow1 + CostRow2 + CostRow3,
      
   Valor #>= 23, %% estimando uma cota
   
   NegValor #= (-1) * Valor, 
   %%% Para maximizar
   minimize(labeling(Maquinas), NegValor).
   
