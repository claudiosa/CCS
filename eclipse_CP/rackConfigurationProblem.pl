% Autor: Vinicius Oliverio

% Data: 25/10/2009
:- lib(ic).
:- lib(branch_and_bound).

%Grupo de cartões existentes.
/*

cartao(20, 10).
cartao(40, 4).
cartao(50, 2).
cartao(75, 1).

Found a solution with cost 600
Found a solution with cost 550
Found no solution with cost 0.0 .. 549.0
[1, 2, 535, 17, 550]
Found a solution with cost 600
Found a solution with cost 550
Found no solution with cost 0.0 .. 549.0
[2, 1, 535, 17, 550]


*/
%%%%%%%%% troquei por isto ....
lista_cartoes([(20, 10), (40, 4), (50, 2), (75, 1) ] ).

y :- rackproblem(N), writeln(N).

%Predicado que resolve o problema.

rackproblem(X) :-
   [Qt_prat_mod_1,Qt_prat_mod_2] :: [0..100],
   [T1,T2] :: [1,2],
   %Determina os valores de T1 e T2
   alldifferent([T1,T2]),
   labeling([T1,T2]),   %%% depois ver isto aqui ... no lugar errado
    
   %Define os possiveis valores dos Racks
	
   EnergiasRack = [](150,200),
   ConectoresRack = [](8,16),
   PrecoRack = [](150,200),

   %Traz uma lista com os cartoes existentes.
   %%%%%%%%%%%%%% findall((X,Y), cartao(X,Y), Cartoes), 
   lista_cartoes( Cartoes),

   %Coloca na variavel EnergiaCartao o valor de
   %energia necessário pelo rack.
   soma(Cartoes, EnergiaCartao),

   %Coloca na variavel ConectoresCartao o número
   %de conectores necessários pelo cartão.
   somaY(Cartoes,ConectoresCartao),
	
   %Restrições do problema.
   (Qt_prat_mod_1 * EnergiasRack[T1]) + (Qt_prat_mod_2 * EnergiasRack[T2]) #>=  EnergiaCartao,
   (Qt_prat_mod_1 * ConectoresRack[T1]) + (Qt_prat_mod_2 * ConectoresRack[T2]) #>= ConectoresCartao,
   %Minimiza o custo
	
   Custo #= (Qt_prat_mod_1 * PrecoRack[T1]) + (Qt_prat_mod_2 * PrecoRack[T2]),
 
   minimize(search([Qt_prat_mod_1,Qt_prat_mod_2], 0, first_fail, indomain_split, complete, []), Custo),

   %Variavel para impressão.
   X = [Qt_prat_mod_1, Qt_prat_mod_2, EnergiaCartao, ConectoresCartao, Custo].



soma([(X,Y)], R) :- R is (X*Y), !.

soma([(X,Y) | L] , R ) :-
   Aux is (X * Y),
   soma(L, R1),
   R is Aux + R1.



somaY([(_,Y)], R) :- R is Y, !.
somaY([(_,Y) | L] , R ) :-
   Aux is Y,
   somaY(L, R1),
   R is Aux + R1.
	 	
