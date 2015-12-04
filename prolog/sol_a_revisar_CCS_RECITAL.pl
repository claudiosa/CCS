go :-	%% Tempo inicial
	statistics(cputime,T1),

	recital( [R1 ,R2 ,R3 ,R4, R5] ),
	imprime_lista(  [R1, R2, R3, R4, R5]  ),

	%% Tempo final
        statistics(cputime ,T2),
        Tempo_BUSCA is T2 - T1,
	format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
	format('\n Tempo total: ~10f  msec', Tempo_BUSCA), !.

recital([(V1, N1, P1, I1, A1, S1),
		(V2, N2, P2, I2, A2, S2),
		(V3, N3, P3, I3, A3, S3),
		(V4, N4, P4, I4, A4, S4),
		(V5, N5, P5, I5, A5, S5)]
		):-


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	suco(S1),suco(S2),suco(S3),suco(S4),suco(S5),
	alldifferent([S1, S2, S3, S4, S5]),
		
	%Na segunda posição está a garota que gosta de suco de Limão.%
	S2==limao,
		
	%As meninas que gostam de suco de Limão e Manga estão lado a lado.%
	
	(S1==manga;S3==manga),

	%Quem gosta de suco de Maracujá está em uma das pontas.%
	
	(S1==maracuja;S5==maracuja),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	vestido(V1),vestido(V2),vestido(V3),vestido(V4),vestido(V5),
	alldifferent([V1, V2, V3, V4, V5]),
	
	%A menina que gosta de suco de Uva está exatamente à esquerda da menina do vestido Azul.%
	(
	(V2==azul,S1==uva);
	(V4==azul,S3==uva);
	(V5==azul,S4==uva)
	),
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	nome(N1),nome(N2),nome(N3),nome(N4),nome(N5),
	alldifferent([N1, N2, N3, N4, N5]),
	
		%Márcia está em algum lugar à direita da garota do vestido Branco.%
	(
	(V1==branco,(N2==marcia;N3==marcia;N4==marcia;N5==marcia));
	(V2==branco,(N3==marcia;N4==marcia;N5==marcia));
	(V3==branco,(N4==marcia;N5==marcia));
	(V4==branco,N5==marcia)
	),
	
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
	poeta(P1),poeta(P2),poeta(P3),poeta(P4),poeta(P5),
	alldifferent([P1, P2, P3, P4, P5]),
	
	%Na primeira posição está a menina que recitará um poema do Guimarães Rosa.%
	P1==guimaraes,
		
	%A menina do vestido Vermelho está em algum lugar à esquerda de quem vai recitar um poema do Vinícius de Moraes.%
	(
	(P2==vinicius,V1==vermelho);
	(P3==vinicius,(V1==vermelho;V2==vermelho));
	(P4==vinicius,(V1==vermelho;V2==vermelho;V3==vermelho));
	(P5==vinicius,(V1==vermelho;V2==vermelho;V3==vermelho;V4==vermelho))
	),
	
	% A menina que gosta de suco de Laranja está exatamente à esquerda de quem recitará um poema do Drummond.%
	(
	(P2==drummond,S1==laranja);
	(P3==drummond,S2==laranja);
	(P4==drummond,S3==laranja);
	(P5==drummond,S4==laranja)
	),
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	idade(I1),idade(I2),idade(I3),idade(I4),idade(I5),
	alldifferent([I1, I2, I3, I4, I5]),
	
	%A menina mais velha está em uma das pontas.%
	(I1==doze;I5==doze),
	
	%A menina que gosta de Gatos está ao lado da menina de 8 anos.%
	(
	(I3==oito;I5==oito)
	),
	%A garota de 11 anos está exatamente à direita da menina de Verde.%
	(
	(V1==verde,I2==onze);
	(V2==verde,I3==onze);
	(V3==verde,I4==onze);
	(V4==verde,I5==onze)
	),
	% A garota de 9 anos está em algum lugar entre a garota de 10 anos e a de 11 anos, nessa ordem.%
	(
	(I1==dez,I3==onze,I2==nove);
	(I1==dez,I4==onze,(I2==nove;I3==nove));
	(I1==dez,I5==onze,(I2==nove;I3==nove;I4==nove));
	(I2==dez,I4==onze,I3==nove);
	(I2==dez,I5==onze,(I3==nove;I4==nove));
	(I3==dez,I4==nove,I5==onze)
	),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
	animal(A1),animal(A2),animal(A3),animal(A4),animal(A5),
	alldifferent([A1, A2, A3, A4, A5]),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
	%A garota que gosta de Gatos está na quarta posição.%
	A4==gato,
		%A menina do vestido Amarelo está em algum lugar à esquerda da menina que gosta de Pássaros.%
	(
	(A2==passaro,V1==amarelo);
	(A3==passaro,(V1==amarelo;V2==amarelo));
	(A5==passaro,(V1==amarelo;V2==amarelo;V3==amarelo;V4==amarelo))
	),
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	%A garota mais nova está exatamente à esquerda de quem vai recitar um poema do Drummond.%
	(
	(P2==drummond,I1==oito);
	(P3==drummond,I2==oito);
	(P4==drummond,I3==oito);
	(P5==drummond,I4==oito)
	),
	
	%A menina do vestido Verde tem 9 anos.%
	(
	(V1==verde,I1==nove);
	(V2==verde,I2==nove);
	(V3==verde,I3==nove);
	(V4==verde,I4==nove);
	(V5==verde,I5==nove)
	),
	
	
	
	%Márcia está em algum lugar à direita da garota do vestido Branco.%
	(
	(V1==branco,(N2==marcia;N3==marcia;N4==marcia;N5==marcia));
	(V2==branco,(N3==marcia;N4==marcia;N5==marcia));
	(V3==branco,(N4==marcia;N5==marcia));
	(V4==branco,N5==marcia)
	),
	
	
	%A menina de Amarelo está em algum lugar entre a que gosta de Cavalos e a Giovanna, nessa ordem.%
	(
	(A1==cavalo,N3==giovanna,V2==amarelo);
	(A1==cavalo,N4==giovanna,(V2==amarelo;V3=amarelo));
	(A1==cavalo,N5==giovanna,(V2==amarelo;V3==amarelo;V4==amarelo));
	(A2==cavalo,N4==giovanna,V3==amarelo);
	(A2==cavalo,N5==giovanna,(V3==amarelo;V4=amarelo));
	(A3==cavalo,N5==giovanna,V4=amarelo)
	),

	%A garota do vestido Verde está em algum lugar à esquerda da Simone.%
	(
	(S2==simone,V1==verde);
	(S3==simone,(V1==verde;V2==verde));
	(S4==simone,(V1==verde;V2==verde;V3==verde));
	(S5==simone,(V1==verde;V2==verde;V3==verde;V4==verde))
	),
	
	%A menina de Amarelo está ao lado da menina que gosta de Tartarugas.%
	(
	(A1==tartaruga,V2==amarelo);
	(A2==tartaruga,(V1==amarelo;V3==amarelo));
	(A3==tartaruga,(V2==amarelo;V4==amarelo));
	(A5==tartaruga,V4==amarelo)
	),
	
	%A garota do vestido Amarelo está em algum lugar à esquerda da que gosta de suco de Uva.%
	(
	(S3==uva,(V1==amarelo;V2==amarelo));
	(S4==uva,(V1==amarelo;V2==amarelo;V3==amarelo));
	(S5==uva,(V1==amarelo;V2==amarelo;V3==amarelo;V4==amarelo))
	),

	
	%A garota que recitará um poema do Olavo Bilac está em algum lugar à direita da menina de Amarelo.%
	(
	(V1==amarelo,(P2==olavo;P3==olavo;P4==olavo;P5==olavo));
	(V2==amarelo,(P3==olavo;P4==olavo;P5==olavo));
	(V3==amarelo,(P4==olavo;P5==olavo));
	(V4==amarelo,P5==olavo)
	),
	
	%Giovanna está em algum lugar entre quem recitará um poema de Guimarães Rosa e a Janaina, nessa ordem.%
	(
	(P1==guimaraes,N3==janaina,N2==giovanna);
	(P1==guimaraes,N4==janaina,(N2==giovanna;N3==giovanna));
	(P1==guimaraes,N5==janaina,(N2==giovanna;N3==giovanna;N4==giovanna))
	)
	
	
	
	
	.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recital([ ' Problemas ????? ',
         ' revise o codigo acima ',
         ' Revise mais uma vez  ',
         ' Procure o prof  que vai revisar mais uma vez  ',
         ' FOREVER  REVISING CODES ....']).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vestido(verde).
vestido(branco).
vestido(vermelho).
vestido(azul).
vestido(amarelo).

nome(luana).
nome(simone).
nome(janaina).
nome(giovanna).
nome(marcia).

poeta(drummond).
poeta(olavo).
poeta(guimaraes).
poeta(vinicius).
poeta(mario).

idade(oito).
idade(nove).
idade(dez).
idade(onze).
idade(doze).

animal(cavalo).
animal(passaro).
animal(gato).
animal(cachorro).
animal(tartaruga).

suco(uva).
suco(limao).
suco(maracuja).
suco(laranja).
suco(manga).

% DEFINICAO DE ALLDIFERENT
	alldifferent([]).
	alldifferent([H|T]):- not(member(H,T)),
	                      alldifferent(T).

	imprime_lista([]):- write('\n FIM \n').
	imprime_lista([H|T]):- write('\n......................................\n'),
	                       write(H), write(' : '),
	                       imprime_lista(T).




