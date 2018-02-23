

:-lib(ic).

go:-
	titias([Hortencia, Honoria , Leticia ,Eugenia, Eustaquia],
	[Tequila, Maratona, Cachimbo, Ovo, Vodka],
	[Lata, Logica, Piranha, Tilapia, Pesos]),
	printf("\n NOME-IDADE ( onde idade eh o index ou chave-secundaria )",[]),
	printf("\n Hortencia: %w, Honoria:  %w, Leticia:  %w, Eugenia: %w, Eustaquia: %w.", [Hortencia, Honoria , Leticia ,Eugenia, Eustaquia]),
	printf("\n Tequila:   %w, Maratona: %w, Cachimbo: %w, Ovo:     %w, Vodka:     %w.", [Tequila, Maratona, Cachimbo,Ovo, Vodka]),
	printf("\n Lata:      %w, Logica:   %w, Piranha:  %w, Tilapia: %w, Pesos:     %w.", [Lata, Logica, Piranha, Tilapia, Pesos]).


titias([Hortencia, Honoria , Leticia ,Eugenia, Eustaquia],
	[Tequila, Maratona, Cachimbo, Ovo, Vodka],
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
   
search(Lista2, 0 , first_fail, indomain, complete, []).


/*
 NOME-IDADE ( onde idade eh o index ou chave-secundaria )
 Hortencia: 76, Honoria:  74, Leticia:  75, Eugenia: 77, Eustaquia: 78.
 Tequila:   76, Maratona: 78, Cachimbo: 75, Ovo:     74, Vodka:     77.
 Lata:      74, Logica:   78, Piranha:  75, Tilapia: 77, Pesos:     76.
 */
