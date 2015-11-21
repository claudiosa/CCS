%%% do prof Parpinelli
/*
Seja uma fabrica de radios que produz 2 tipos de radios.
O total de trabalhadores da fabrica é igual a 40.
O radio 2  precisa do dobro de de trabalhadores que o radio 1.
O custo por trabalhador no radio 1 é 30  e no radio 2 é 40. 
Quantos trabalhadores em cada tipo de radio devem estar trabalhando 
para que o custo/lucro seja Maximo?

A: [0..24]
B: [0..16]
Sujeito a: A + 2B <= 40
Maximizar: 30A + 40B	   
Ponto ótimo é custo de 1040 (MAXIMO)

*/

:- lib(ic).
:- lib(branch_and_bound).

sol :- fab([A,B, CUSTO]),
	   writeln([a: A, b: B, maximizado_custo: CUSTO]).


fab([A,B, CUSTO]) :-
   %% trabalhadores
   A #:: 0 .. 24,
   B  #:: 0 .. 16,
   %% teria-se outra alternativa para o caso acima 
    A + 2*B #= 40,
    30*A + 40*B #= CUSTO,
   %% faça o grafico para visualizar os pontos de corte
    MAX_CUSTO #= -CUSTO, %% Maximizar
    minimize(labeling([A,B]), MAX_CUSTO).
	

/*
 ?- sol.
Yes (0.02s cpu)
fab_radios.ecl compiled 2480 bytes in 0.01 seconds
Found a solution with cost -880
Found a solution with cost -900
Found a solution with cost -920
Found a solution with cost -940
Found a solution with cost -960
Found a solution with cost -980
Found a solution with cost -1000
Found a solution with cost -1020
Found a solution with cost -1040
Found no solution with cost -1360.0 .. -1041.0
[a : 24, b : 8, maximizado_custo : 1040]

*/

