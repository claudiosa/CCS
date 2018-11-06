% Trabalho - Resoluções de ano novo.
% URL do problema - http://rachacuca.com.br/logica/problemas/resolucoes-de-ano-novo/
% Aluno - Matheus Rambo da Roza


main :-
	statistics(cputime, T0),
	amiga([AMIGA1, AMIGA2, AMIGA3, AMIGA4, AMIGA5]),
	format("\n AMIGA 1: ~w", AMIGA1),
	format("\n AMIGA 2 : ~w", AMIGA2),
	format("\n AMIGA 3 : ~w", AMIGA3),
	format("\n AMIGA 4 : ~w", AMIGA4),
	format("\n AMIGA 5 : ~w", AMIGA5),
	statistics(cputime, T1),
	TEMPO_TOTAL is T1 - T0,
	format("\nO tempo de execução é: ~10f sec", TEMPO_TOTAL),
	fail.

main :- nl, write('UMA UNICA RESPOSTA e pronto!!!!!!!!!!!!!!').


amiga([ 
         (NOME1, BOLSA1, RESOLUCAO1, NAMORADO1, IDADE1),
	     (NOME2, BOLSA2, RESOLUCAO2, NAMORADO2, IDADE2),
	     (NOME3, BOLSA3, RESOLUCAO3, NAMORADO3, IDADE3),
	     (NOME4, BOLSA4, RESOLUCAO4, NAMORADO4, IDADE4),
	     (NOME5, BOLSA5, RESOLUCAO5, NAMORADO5, IDADE5)
	   ]) :- 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nome(NOME1),nome(NOME2),nome(NOME3),nome(NOME4),nome(NOME5),
alldifferent([NOME1,NOME2,NOME3,NOME4,NOME5]),

% 16-A Thaís está ao lado da fabiana.

(
(NOME1 == thais, NOME2 == fabiana);
(NOME2 == thais, (NOME1 == fabiana;NOME3 == fabiana));
(NOME3 == thais, (NOME2 == fabiana;NOME4 == fabiana));
(NOME4 == thais, (NOME3 == fabiana;NOME5 == fabiana));
(NOME5 == thais, NOME4 == fabiana)
),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BOLSA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bolsa(BOLSA1),bolsa(BOLSA2),bolsa(BOLSA3),bolsa(BOLSA4),bolsa(BOLSA5),
alldifferent([BOLSA1,BOLSA2,BOLSA3,BOLSA4,BOLSA5]),

% 15-A cor da bolsa da ana é vermelha.

(
(NOME1 == ana, BOLSA1 == vermelha);
(NOME2 == ana, BOLSA2 == vermelha);
(NOME3 == ana, BOLSA3 == vermelha);
(NOME4 == ana, BOLSA4 == vermelha);
(NOME5 == ana, BOLSA5 == vermelha)
),

% 18-A mulher de bolsa verde está em algum lugar à direita da Thaís.

(
(NOME1 == thais, (BOLSA2 == verde; BOLSA3 == verde; BOLSA4 == verde; BOLSA5 == verde));
(NOME2 == thais, (BOLSA3 == verde; BOLSA4 == verde; BOLSA5 == verde));
(NOME3 == thais, (BOLSA4 == verde; BOLSA5 == verde));
(NOME4 == thais, BOLSA5 == verde)
),

% 12-A moça de bolsa amarela está exatamente à esquerda da ana.

(
(NOME2 == ana, BOLSA1 == amarela);
(NOME3 == ana, BOLSA2 == amarela);
(NOME4 == ana, BOLSA3 == amarela);
(NOME5 == ana, BOLSA4 == amarela)
),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RESOLUCAO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

resolucao(RESOLUCAO1),resolucao(RESOLUCAO2),resolucao(RESOLUCAO3),resolucao(RESOLUCAO4),resolucao(RESOLUCAO5),
alldifferent([RESOLUCAO1,RESOLUCAO2,RESOLUCAO3,RESOLUCAO4,RESOLUCAO5]),

% 10-Quem gostaria de emagrecer está na segunda posição.

RESOLUCAO2 == emagrecer,

% 8-A vivian está em algum lugar à esquerda de quem pretende economizar dinheiro.

(
(RESOLUCAO5 == poupar_dinheiro, (NOME1 == vivian; NOME2 == vivian; NOME2 == vivian; NOME4 == vivian));
(RESOLUCAO4 == poupar_dinheiro, (NOME1 == vivian; NOME2 == vivian; NOME3 == vivian));
(RESOLUCAO3 == poupar_dinheiro, (NOME1 == vivian; NOME2 == vivian))
),

% 9-Quem quer ler mais no ano novo está ao lado da vivian.

(
(NOME2 == vivian, (RESOLUCAO1 == ler_mais;RESOLUCAO3 == ler_mais));
(NOME4 == vivian, (RESOLUCAO3 == ler_mais;RESOLUCAO5 == ler_mais ));
(NOME5 == vivian, RESOLUCAO4 == ler_mais)
),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NAMORADO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

namorado(NAMORADO1),namorado(NAMORADO2),namorado(NAMORADO3),namorado(NAMORADO4),namorado(NAMORADO5),
alldifferent([NAMORADO1,NAMORADO2,NAMORADO3,NAMORADO4,NAMORADO5]),

% 5-A moça que namora o daniel está na última posição.

NAMORADO5 == daniel,

% 7-Quem namora o marcelo está ao lado da vivian.

(
(NAMORADO1 == marcelo,(NOME2 == vivian));
(NAMORADO2 == marcelo,(NOME1 == vivian; NOME3 == vivian));
(NAMORADO3 == marcelo,(NOME2 == vivian; NOME4 == vivian));
(NAMORADO4 == marcelo,(NOME3 == vivian; NOME5 == vivian))
),

% 11-A Thaís está ao lado da mulher que namora o Otávio.

(
(NAMORADO1 == otavio,(NOME2 == thais));
(NAMORADO2 == otavio,(NOME1 == thais; NOME3 == thais));
(NAMORADO3 == otavio,(NOME2 == thais; NOME4 == thais));
(NAMORADO4 == otavio,(NOME3 == thais; NOME5 == thais))
),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IDADE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

idade(IDADE1),idade(IDADE2),idade(IDADE3),idade(IDADE4),idade(IDADE5),
alldifferent([IDADE1,IDADE2,IDADE3,IDADE4,IDADE5]),

% 17-A mulher de 26 anos está exatamente à esquerda da mulher que namora o alexandre.

(
(NAMORADO2 == alexandre, IDADE1 == 26);
(NAMORADO3 == alexandre, IDADE2 == 26);
(NAMORADO4 == alexandre, IDADE3 == 26)
),

% 1-A moça que quer viajar está ao lado de quem tem 24 anos.

(
(IDADE1 == 24, RESOLUCAO2 == viajar);
(IDADE2 == 24, (RESOLUCAO1 == viajar;RESOLUCAO3 == viajar));
(IDADE3 == 24, (RESOLUCAO2 == viajar;RESOLUCAO4 == viajar));
(IDADE4 == 24, (RESOLUCAO3 == viajar;RESOLUCAO5 == viajar ));
(IDADE5 == 24, RESOLUCAO4 == viajar)
),

% 2-A clarissa está em algum lugar à esquerda de quem tem 23 anos.

(
(IDADE5 == 23, (NOME1 == clarissa; NOME2 == clarissa; NOME2 == clarissa; NOME4 == clarissa));
(IDADE4 == 23, (NOME1 == clarissa; NOME2 == clarissa; NOME3 == clarissa));
(IDADE3 == 23, (NOME1 == clarissa; NOME2 == clarissa));
(IDADE2 == 23, NOME1 == clarissa)
),
 
 % 3-A vivian está exatamente à direita da mulher mais velha.

(
(IDADE1 == 26, NOME2 == vivian);
(IDADE2 == 26, NOME3 == vivian);
(IDADE3 == 26, NOME4 == vivian);
(IDADE4 == 26, NOME5 == vivian)
),

% 4-A namorada do Otávio é a mulher mais nova do grupo.

(
(IDADE1 == 19, NAMORADO1 == otavio);
(IDADE2 == 19, NAMORADO2 == otavio);
(IDADE3 == 19, NAMORADO3 == otavio);
(IDADE4 == 19, NAMORADO4 == otavio)
),

% 13-A mulher de 19 anos está ao lado da mulher de bolsa verde.

(
(BOLSA1 == verde, IDADE2 == 19);
(BOLSA2 == verde, (IDADE1 == 19;IDADE3 == 19));
(BOLSA3 == verde, (IDADE2 == 19;IDADE4 == 19));
(BOLSA4 == verde, (IDADE3 == 19;IDADE5 == 19 ));
(BOLSA5 == verde, IDADE4 == 19)
),

% 6-A fabiana está em algum lugar entre quem tem 20 anos e quem quer viajar, nessa ordem.

(
	(NOME2 == fabiana, (IDADE1 == 20, RESOLUCAO3 == viajar));
	((NOME2 == fabiana; NOME3 == fabiana), (IDADE1 == 20, RESOLUCAO4 == viajar));
	((NOME2 == fabiana; NOME3 == fabiana; NOME4 == fabiana), (IDADE1 == 20, RESOLUCAO5 == viajar));
	((NOME3 == fabiana; NOME4 == fabiana), (IDADE2 == 20, RESOLUCAO5 == viajar));
	((NOME4 == fabiana), (IDADE3 == 20, RESOLUCAO5 == viajar))
),

% 14-Quem tem a bolsa branca está em algum lugar entre a moça de 20 anos e a de 26 anos, nessa ordem.

(
	(BOLSA2 == branca, (IDADE1 == 20, IDADE3 == 26));
	((BOLSA2 == branca; BOLSA3 == branca), (IDADE1 == 20, IDADE4 == 26))
)
,
nl,
format("\n Passou no final do Modelo\n").



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Biblioteca
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nome(ana).
nome(clarissa).
nome(fabiana).
nome(thais).
nome(vivian).

bolsa(amarela).
bolsa(azul).
bolsa(branca).
bolsa(verde).
bolsa(vermelha).

resolucao(aprender_ingles).
resolucao(emagrecer).
resolucao(ler_mais).
resolucao(poupar_dinheiro).
resolucao(viajar).

namorado(alexandre).
namorado(daniel).
namorado(julio).
namorado(marcelo).
namorado(otavio).

idade(19).
idade(20).
idade(23).
idade(24).
idade(26).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINICAO DE ALLDIFERENT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alldifferent([]).
alldifferent([H|T]) :-
	not(member(H,T)),
	alldifferent(T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
