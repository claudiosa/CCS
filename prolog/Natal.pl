% PRESENTE DE NATAL - LMA 2014.2
% TRABALHO EM GRUPO
% ELOY E MARLON HENRY



start:- meninos([M1, M2, M3, M4,M5]),
	     writeln("\n MENINO 1: ":M1),
	     writeln("\n MENINO 2: ":M2),
         writeln("\n MENINO 3: ":M3),
		 writeln("\n MENINO 4: ":M4),
         writeln("\n MENINO 5: ":M5).

meninos([(COR1, NOME1, IDADE1, PRESENTE1, SUCO1, PROFISSAO1),
        (COR2, NOME2, IDADE2, PRESENTE2, SUCO2, PROFISSAO2),
        (COR3, NOME3, IDADE3, PRESENTE3, SUCO3, PROFISSAO3),
        (COR4, NOME4, IDADE4, PRESENTE4, SUCO4, PROFISSAO4),
        (COR5, NOME5, IDADE5, PRESENTE5, SUCO5, PROFISSAO5)]):-
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%COR
cor(COR1), cor(COR2), cor(COR3), cor(COR4), 
cor(COR5), 
alldifferent([COR1, COR2, COR3, COR4, COR5]),

% 23. A primeira casa é Amarela.

COR1==amarelo,

% 20. Eduardo mora na casa de cor Verde. 
COR4==verde,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%nomes     
nome(NOME1), nome(NOME2), nome(NOME3), nome(NOME4), 
nome(NOME5), 
alldifferent([NOME1, NOME2, NOME3, NOME4, NOME5]),

% 18. Pedro mora na terceira casa. 

NOME3==paulete,

% 19. Eduardo mora exatamente à direita de Pedro. 

NOME4==eduzinho,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%idade     
idade(IDADE1), idade(IDADE2), idade(IDADE3), idade(IDADE4), 
idade(IDADE5), 
alldifferent([IDADE1, IDADE2, IDADE3, IDADE4, IDADE5]),

% 16. O garoto de 10 anos está em algum lugar entre o de 7 e o de 9 anos, nessa ordem. 
(
(IDADE1==7,IDADE3==9,(IDADE2==10));
(IDADE1==7,IDADE4==9,(IDADE2==10;IDADE3==10));
(IDADE1==7,IDADE5==9,(IDADE2==10;IDADE3==10;IDADE4==10));
(IDADE2==7,IDADE4==9,(IDADE2==10));
(IDADE2==7,IDADE5==9,(IDADE3==10;IDADE4==10));
(IDADE3==7,IDADE5==9,(IDADE4==10))
),
% 15. O menino mais novo mora na quinta casa.

IDADE5==6,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%presente     
presente(PRESENTE1), presente(PRESENTE2), presente(PRESENTE3), presente(PRESENTE4), 
presente(PRESENTE5), 
alldifferent([PRESENTE1, PRESENTE2, PRESENTE3, PRESENTE4, PRESENTE5]),

% 14. Quem quer uma Bicicleta mora ao lado de quem deseja um Vídeo Game de presente. 
(
(PRESENTE1==bicicleta,PRESENTE2==game);
(PRESENTE2==bicicleta,(PRESENTE1==game;PRESENTE3==game));
(PRESENTE3==bicicleta,(PRESENTE2==game;PRESENTE4==game));
(PRESENTE4==bicicleta,(PRESENTE3==game;PRESENTE5==game));
(PRESENTE5==bicicleta,PRESENTE4==game)
),
% 13. Na primeira casa mora o garoto que quer uma Bola de presente de natal. 

PRESENTE1==bola,

% 12. Na casa de cor Branca mora o menino que deseja um Vídeo Game de natal.
(
(COR1==branco,PRESENTE1==game);
(COR2==branco,PRESENTE2==game);
(COR3==branco,PRESENTE3==game);
(COR4==branco,PRESENTE4==game);
(COR5==branco,PRESENTE5==game)
),
% 11. O garoto que quer um Skate está exatamente à esquerda da casa do Alex

(
(PRESENTE1==skate,NOME2==marlon);
(PRESENTE2==skate,NOME3==marlon);
(PRESENTE3==skate,NOME4==marlon);
(PRESENTE4==skate,NOME5==marlon)
),

% 10. O menino de 8 anos mora ao lado do que quer um Computador de presente
(
(PRESENTE1==computador,IDADE2==8);
(PRESENTE2==computador,(IDADE1==8;IDADE3==8));
(PRESENTE3==computador,(IDADE2==8;IDADE4==8));
(PRESENTE4==computador,(IDADE3==8;IDADE5==8));
(PRESENTE5==computador,(IDADE4==8))
),

% 22. A casa de cor Azul está exatamente à esquerda da casa do garoto que quer um Vídeo Game. 

(
(COR1==azul,PRESENTE2==game);
(COR2==azul,PRESENTE3==game);
(COR3==azul,PRESENTE4==game);
(COR4==azul,PRESENTE5==game)
),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%suco     
suco(SUCO1), suco(SUCO2), suco(SUCO3), suco(SUCO4), 
suco(SUCO5), 
alldifferent([SUCO1, SUCO2, SUCO3, SUCO4, SUCO5]),

% 21. A casa de cor Branca está exatamente à esquerda da casa do menino que gosta de suco de Maracujá. 
(
(COR1==branco,SUCO2==maracuja);
(COR2==branco,SUCO3==maracuja);
(COR3==branco,SUCO4==maracuja);
(COR4==branco,SUCO5==maracuja)
),

% 9. Cristian gosta de suco de Limão.
(
(NOME1==eloy,SUCO1==limao);
(NOME2==eloy,SUCO2==limao);
(NOME3==eloy,SUCO3==limao);
(NOME4==eloy,SUCO4==limao);
(NOME5==eloy,SUCO5==limao)
),

% 7. O garoto que gosta de limonada está exatamente à esquerda do que gosta de
% suco de Morango.
(
(SUCO1==limao,SUCO2==morango);
(SUCO2==limao,SUCO3==morango);
(SUCO3==limao,SUCO4==morango);
(SUCO4==limao,SUCO5==morango)
),

% 6. O menino que gosta de suco de Laranja está em uma das pontas

(SUCO1==laranja;SUCO5==laranja),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%profissao     
profissao(PROFISSAO1), profissao(PROFISSAO2), profissao(PROFISSAO3), profissao(PROFISSAO4), 
profissao(PROFISSAO5), 
alldifferent([PROFISSAO1, PROFISSAO2, PROFISSAO3, PROFISSAO4, PROFISSAO5]),

% 17. O garoto de 9 anos quer ser Professor quando crescer.
(
(IDADE1==9,PROFISSAO1==professor);
(IDADE2==9,PROFISSAO2==professor);
(IDADE3==9,PROFISSAO3==professor);
(IDADE4==9,PROFISSAO4==professor);
(IDADE5==9,PROFISSAO5==professor)
),

% 8. Quem quer ser Médico está exatamente à direita de quem gosta de suco de
% Abacaxi.
(
(SUCO1==abacaxi,PROFISSAO2==medico);
(SUCO2==abacaxi,PROFISSAO3==medico);
(SUCO3==abacaxi,PROFISSAO4==medico);
(SUCO4==abacaxi,PROFISSAO5==medico)
),

% 5. Na quinta casa está o garoto que deseja ser Bombeiro quando crescer.

PROFISSAO5==bombeiro,

% 4. Em uma das pontas mora o menino que quer ser Policial.

(PROFISSAO1==policial;PROFISSAO5==policial),

% 3. Na terceira casa está o garoto que quer ser Professor.

PROFISSAO3==professor,

% 2. Quem gosta de Maracujá quer ser Médico.

(
(SUCO1==maracuja,PROFISSAO1==medico);
(SUCO2==maracuja,PROFISSAO2==medico);
(SUCO3==maracuja,PROFISSAO3==medico);
(SUCO4==maracuja,PROFISSAO4==medico);
(SUCO5==maracuja,PROFISSAO5==medico)
),

% 1. O garoto que quer ser Bombeiro mora em alguma das casas das pontas.

(PROFISSAO1==bombeiro;PROFISSAO5==bombeiro).

% biblioteca
cor(amarelo).
cor(azul).
cor(branco).
cor(verde).
cor(vermelho).

nome(marlon).
nome(eloy).
nome(eduzinho).
nome(luigi).
nome(paulete).

idade(6).
idade(7).
idade(8).
idade(9).
idade(10).

presente(bicicleta).
presente(bola).
presente(computador).
presente(skate).
presente(game).

suco(abacaxi).
suco(laranja).
suco(limao).
suco(morango).
suco(maracuja).

profissao(astronalta).
profissao(bombeiro).
profissao(medico).
profissao(policial).
profissao(professor).

  



% DEFINICAO DE ALLDIFERENT  
alldifferent([]).
alldifferent([H|T]):- not(member(H,T)),
                      alldifferent(T).

imprime_lista([]):- write('\n FIM \n').
imprime_lista([H|T]):- write('\n.............\n'),
                       write(H),
                       imprime_lista(T).
