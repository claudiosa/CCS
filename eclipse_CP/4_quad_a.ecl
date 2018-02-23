
:- lib(ic). %% Declarando uma biblioteca

quad_1 :-
  [X] :: 1..11,     %%% Dominios 
  [Y] :: 1..7,        
  X #> 3,	      %%% Restricoes
  X #< 9,
  Y #> 2,
  Y #< 5,
  %%% Fase da propagacao e busca
  search([X,Y], 0, anti_first_fail, indomain_middle, complete, []),
  printf("\n Possiveis solucoes: X: %d  Y:%d", [X,Y])
  .
  %%% Um ponto ao termino da clausula 
	
	
