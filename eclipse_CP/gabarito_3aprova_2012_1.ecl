/* as boas solucoes */

:-lib(ic).
:-lib(branch_and_bound).


%%Questão Imediata
imediata([A, B, C, D, E, F, G, H, I]) :-
	Valores = [A, B, C, D, E, F, G, H, I],
	Valores :: [1..9],
	%%Sugestão do professor para evitar divisões, pois dá erro no Windows
	[K1,K2,K3] :: [1..72],
	K1 #= B*C,
	K2 #= E*F,
	K3 #= H*I,
	((A*K2*K3) + (D*K1*K3) + (G*K1*K2)) #= K1*K2*K3,
	alldifferent(Valores),
	labeling(Valores).
	
	
%%Questão Preço do peru
preco_peru(Preco) :-
	Milhar :: 1..9,
	Unidade :: 0..9,
	Mi #= Milhar * 1000,
	(Mi+670+Unidade)/Preco #= 72,
	labeling([Milhar,Unidade]).


%%Questao Maratona de Natação
maratona([A, B, C, D, E]) :-
	Competidores = [A, B, C, D, E],
	Competidores :: [1..5],
	%%APENAS UMA RESTRIÇÃO DEVERÁ SER VERDADEIRA POR VEZ
	(A #\= 1) #\= (B #\= 2),
	(D #\= 2) #\= (E #\= 3),
	(C #=< 3) #\= (D #>= 4),
	(A #=< 3) #\= (C #>= 4),
	(D #=< 3) #\= (E #=< 3),
	alldifferent(Competidores),
	labeling(Competidores).
/*
Entrada: maratona([A, B, C, D, E])
OBS: Legenda:
     1 - OURO
     2 - PRATA
     3 - BRONZE
     4 E 5 - NÃO GANHARAM MEDALHA
*/

	
maratona2([A, B, C, D, E]) :-
	Competidores = [A, B, C, D, E],
	Competidores :: [1..5],
	
	(A #\= 1) #\= (B #\= 2),
	(D #\= 2) #\= (E #\= 3),
	(C #< 4) #\= (D #> 3),
	(A #< 4) #\= (C #> 3),
	(D #< 4) #\= (E #< 4),

	alldifferent(Competidores),
	labeling(Competidores).

titias([Hortencia, Honoria , Leticia ,Eugenia, Eustaquia],
	[Tequila, Maratona, Cachimbo,Ovo, Vodka],
	[Lata, Logica, Piranha, Tilapia, Pesos]):-
Tias = [Hortencia, Honoria , Leticia ,Eugenia, Eustaquia],
Tias :: 74..78,

Habitos = [Tequila, Maratona, Cachimbo,Ovo, Vodka],
Habitos :: 74..78,

Hobbies = [Lata, Logica, Piranha, Tilapia, Pesos],
Hobbies :: 74..78,

Honoria #= 74,
Honoria #\= Cachimbo,
Honoria #\= Vodka,
Hortencia #= Tequila,
Hortencia #= Lata+2,
Eugenia #\= Logica,
Eugenia #\= Maratona,
Leticia #= Piranha,
Leticia #\= 78,
Tilapia #= 77,
Logica  #= Maratona,
Ovo #= Pesos - 2,

alldifferent(Tias),
alldifferent(Habitos),
alldifferent(Hobbies),
 
append(Tias, Habitos, Lista1),
append(Lista1, Hobbies, Lista2),
   
search(Lista2, 0 , first_fail, indomain, complete, []),
printf("\n Hortencia: %w, Honoria:  %w, Leticia:  %w, Eugenia: %w, Eustaquia: %w.", [Hortencia, Honoria , Leticia ,Eugenia, Eustaquia]),
printf("\n Tequila:   %w, Maratona: %w, Cachimbo: %w, Ovo:     %w, Vodka:     %w.", [Tequila, Maratona, Cachimbo,Ovo, Vodka]),
printf("\n Lata:      %w, Logica:   %w, Piranha:  %w, Tilapia: %w, Pesos:     %w.", [Lata, Logica, Piranha, Tilapia, Pesos]).

