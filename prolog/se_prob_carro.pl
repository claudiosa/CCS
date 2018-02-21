% Caso 1 - valor verdade do objetivo já conhecido.
solucao(Objetivo, FC, _, Limiar) :-
	conhecido(Objetivo,FC),!,
	acima_limiar(FC,Limiar).

% Caso 2 - objetivo negado
solucao(not(Objetivo), FC, Regras, Limiar) :-!,
	inverter_limiar(Limiar,Novo_limiar),
	solucao(Objetivo,FC_objetivo,Regras,Novo_limiar),
	fc_negado(FC_objetivo,FC).

% Caso 3 - Solucoes "conjunctivas"
solucao((Objetivo_1, Objetivo_2), FC,Regras,Limiar) :-!,
	solucao(Objetivo_1,FC_1,Regras,Limiar),
	acima_limiar(FC_1,Limiar),
	solucao(Objetivo_2,FC_2,Regras,Limiar),
	acima_limiar(FC_2,Limiar),
	fc_e(FC_1,FC_2,FC).

% Caso 4 - Corrente anterior na regra na base de conhecimento
solucao(Objetivo, FC, Regras, Limiar) :-
	regra((Objetivo:-(Premissa)),FC_regra),
	solucao(Premissa,FC_premissa,[regra((Objetivo :- Premissa),FC_regra)|Regras], Limiar),
	fc_regra(FC_regra,FC_premissa, FC),
	acima_limiar(FC,Limiar).

% Caso 5 - Afirmação de um fato na base de conhecimento
solucao(Objetivo, FC,_,Limiar):-
	regra(Objetivo, FC),
	acima_limiar(FC,Limiar).

% Caso 6 - Pergunta ao usuário
solucao(Objetivo, FC, Regras, Limiar) :-
	pergunta(Objetivo),
	pergunta_usuario(Objetivo, FC, Regras), !, 
	assert(conhecido(Objetivo,FC)),
	acima_limiar(FC,Limiar).

% ==============================================

% 1 - Mostra um conjunto de instrucoes para o usuario
% 2 - Limpa qualquer informação residual de uma execução prévia da aplicação.
$ 3 - Chama novamente "solução"  com valores apropriados para seus argumentos (um limiar de 30?) 
solucao(Objetivo, FC) :-
	mostra_instrucoes,
	retractall(conhecido(_,_)),
	solucao(Objetivo,FC,[],30).


% Mostra ao usuário as respostas possíveis para uma pergunta
mostra_instrucoes :-
	nl, write('A resposta deve ser ou:'),
	nl, write('  Um valor entre -100 e 100'),
	nl, write('  porque'),
	nl, write('  como(X), onde X é o objetivo'), nl.


% Cojunto de predicados que calcula o FC

fc_e(A,B,A):-
	A=<B.
fc_e(A,B,B):-
	B<A.
	
fc_negado(FC,FC_Negado):-
	FC_Negado is -1*FC.
	
fc_regra(FC_regra,FC_premissa,FC):-
	FC is (FC_regra * FC_premissa/100).
	
acima_limiar(FC,T):-
	T>=0, FC>=T.
acima_limiar(FC,T):-
	T<0, FC=<T.
	
inverter_limiar(Limiar,Novo_limiar):-
	Novo_limiar is -1 *Limiar.


% ==============================================

% Mostra ao usuário uma perguta e lê uma resposta
pergunta_usuario(Objetivo, FC, Regras):-
	nl, write('Pergunta ao usuario: " '),
	write(Objetivo), write(' "?'), nl,
	read(Resposta),
	reacao(Resposta,Objetivo,FC,Regras).

% Caso 1 - Usuario informa um fator de confiança válido
reacao(FC,_,FC,_):-
	number(FC),
	FC=<100, FC >= -100.

% Caso 2 - Usuario informa com a pergunta: porque
reacao(porque,Objetivo, FC,[Regra|Regras]):-
	escreva_regra(Regra),
	pergunta_usuario(Objetivo,FC,Regras).
reacao(porque,Objetivo, FC,[]):-
	write('Volte ao topo da pilha de regras.'),
	pergunta_usuario(Objetivo, FC, []).

% Caso 3 - Usuario informa com a pergunta: como. Constroi e mostra uma prova
reacao(como(X),Objetivo, FC, Regras):-
	constroi_prova(X,FC_X,Prova),!,
	write(X), write(' foi concluido com certeza '), write(FC_X), nl,nl,
	write('A Prova é '), nl,nl,
	escreva_prova(Prova,0),nl,nl,
	pergunta_usuario(Objetivo,FC,Regras).
% Usuario informa com a pergunta: como. Nao pode construir uma prova
reacao(como(X),Objetivo,FC,Regras):-
	write('A verdade de '), write(X), nl,
	write(' ainda não é conhecida.'), nl,
	pergunta_usuario(Objetivo,FC,Regras).

% Caso 4 - Entrada desconhecida
reacao(_,Objetivo, FC, Regras):-
	write('Resposta desconhecida.'),nl,
	pergunta_usuario(Objetivo,FC,Regras).


%===============================================

constroi_prova(Objetivo, FC,(Objetivo,FC:-given)):-
	conhecido(Objetivo, FC), !.
	
constroi_prova(not(Objetivo),FC, not(Prova)):-
	!, constroi_prova(Objetivo, FC_Objetivo, Prova), fc_negado(FC_Objetivo, FC).

constroi_prova((Objetivo_1, Objetivo_2), FC,(Prova_1,Prova_2)):-
	!,constroi_prova(Objetivo_1, FC_1, Prova_1),
	constroi_prova(Objetivo_2,FC_2, Prova_2), 
	fc_e(FC_1, FC_2, FC).

constroi_prova(Objetivo,FC,(Objetivo,FC:-Prova)):-
	regra((Objetivo:-Premissa),FC_Regra),
	constroi_prova(Premissa,FC_Premissa,Prova),
	fc_regra(FC_Regra,FC_Premissa,FC).

constroi_prova(Objetivo,FC,(Objetivo,FC:-fact)):-
	regra(Objetivo,FC).

escreva_regra(regra((Objetivo :- (Premissa)),FC)):-
	write(Objetivo), write(':-'), nl,
	escreva_premissa(Premissa),nl,
	write('FC = '),write(FC),nl.

escreva_regra(regra(Objetivo,FC)):-
	write(Objetivo), nl,
	write('FC = '),write(FC), nl.

escreva_premissa(Premissa_1,Premissa_2):-
	!, escreva_premissa(Premissa_1),
	escreva_premissa(Premissa_2).

escreva_premissa(not(Premissa)):-
	!, write(' '), write(not), write(' '), write(Premissa), nl.

escreva_premissa(Premissa):-
	write(' '), write(Premissa), nl.

escreva_prova((Objetivo, FC:-given), Nivel):-
	indentar(Nivel), write(Objetivo),
	write(' FC= '), write(FC),
	write(' foi concluido pelo usuario'), nl, !.

escreva_prova((Objetivo, FC:-fact), Nivel):-
	indentar(Nivel), write(Objetivo), write(' FC= '), write(FC),
	write(' foi um fato na base de conhecimento.'),nl,!.

escreva_prova((Objetivo, FC :- Prova), Nivel):-
	indentar(Nivel), write(Objetivo), write('FC= '), write(FC), write(':-'),
	nl , Novo_nivel is nivel+1, escreva_prova(Prova, Novo_nivel),!.

escreva_prova(not(Prova), Nivel):-
	indentar(Nivel), write((not)),nl,
	Novo_nivel is Nivel+1, escreva_prova(Prova,Novo_nivel),!.

escreva_prova((Prova_1, Prova_2), Nivel):-
	escreva_prova(Prova_1, Nivel), escreva_prova(Prova_2, Nivel),!.

indentar(0).
indentar(nivel) :-
	write('    '), nivel_novo is nivel-1, indentar(nivel_novo).

regra((fix(Aviso) :-
	(componente_ruim(X), fix(X, Aviso))), 100).

regra((componente_ruim(arranque):-
	(sistema_ruim(sistema_arranque), luzes(ligam))), 65).
	
regra((componente_ruim(combustivel):-
	(sistema_ruim(sistema_arranque), luzes(ligam), not(combustivel_no_tanque))), 95).

regra((componente_ruim(bateria):-
	(sistema_ruim(sistema_arranque), not(luzes(ligam)))), 90).
	
regra((componente_ruim(cabos):-
	(sistema_ruim(sistema_ignicao), cabos(sujos))), 90).
	
regra((componente_ruim(cabos_ignicao):-
	(sistema_ruim(sistema_ignicao), not(cabos(sujos)))), 80).

regra((componente_ruim(injecao):-
	(sistema_ruim(sistema_injecao), not(cabos(sujos), anda(morre)))), 90).




regra((sistema_ruim(sistema_arranque):-
	(not(carro_liga), not(da_partida))), 90).

regra((sistema_ruim(sistema_ignicao):-
	(not(carro_liga), da_partida, combustivel_no_tanque)), 80).
	
regra((sistema_ruim(sistema_injecao):-
	(carro_liga, combustivel_no_tanque, anda(falhando))), 90).

% regra((sistema_ruim(sistema_ignicao):-
% 	(anda(falhando), combustivel_no_tanque)), 80).

% regra((sistema_ruim(sistema_ignicao):-
%	(carro_liga, anda(morre), combustivel_no_tanque)), 70).



regra(fix(arranque, 'trocar arranque'), 100).
regra(fix(bateria, 'trocar ou recarregar bateria'), 100).
regra(fix(cabos, 'trocar cabos spark'), 100).
regra(fix(cabos_ignicao, 'checar cabos de ignição'), 100).
regra(fix(combustivel, 'abastecer veiculo'),100).
regra(fix(injecao, 'fazer revisão no sistema de injeção eletrônica'),100).


pergunta(carro_liga).
pergunta(da_partida).
pergunta(luzes(_)).
pergunta(combustivel_no_tanque).
pergunta(anda(_)).
pergunta(cabos(_)).
