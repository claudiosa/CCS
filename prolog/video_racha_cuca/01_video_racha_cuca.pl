
%% Problema Referência
% http://rachacuca.com.br/logica/problemas/laboratorio-de-informatica/

% UDESC -- Joinville
% Lógica Matematica -- LMA (parte prática)
% Codigos em https://github.com/claudiosa
% Claudio Cesar de Sá e demais estudantes


%%% menino(Mochila,Nome,Mes,Jogo,Materia,Suco).

main :-
    %% Tempo inicial
    statistics(cputime,T1),

    modelo(L), 
    imprime_lista(L),
 
    %% Tempo final
    statistics(cputime ,T2), 
    Tempo_BUSCA is (T2 - T1), 
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Tempo total: ~10f  msec', Tempo_BUSCA), 
    fail.

main :- 
        nl, 
        write('xxxx AQUI SOH PODE VIR UMA RESPOSTA ....'),
        nl, 
        write('........ UFA apos o fail .......'). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

modelo([ (Mo1, N1, Mes1, J1, Mat1, S1),
         (Mo2, N2, Mes2, J2, Mat2, S2),
         (Mo3, N3, Mes3, J3, Mat3, S3),
         (Mo4, N4, Mes4, J4, Mat4, S4),
         (Mo5, N5, Mes5, J5, Mat5, S5)
        ])
          
         :-

    %%%%%%%%%%%%%%%%%%%%%%%% Mochila
    mochila(Mo1), 
    mochila(Mo2), 
    mochila(Mo3), 
    mochila(Mo4), 
    mochila(Mo5),
    alldifferent([Mo1, Mo2, Mo3, Mo4, Mo5]),

    %%%%%%%%%% SOH REGRAS COM MOCHILA ... e nada mais

    %%%%%%%%%%%%%%%%%%%%%%%% Nome
    nome(N1), 
    nome(N2), 
    nome(N3), 
    nome(N4), 
    nome(N5),

    %Lenin está na quinta posição.
    (N5==lenin) , %%% notacao INFIXA
       
    %Otávio está em uma das pontas. >>>> pois eh contraditorio com anterios...
    (N1==otavio) ,

    alldifferent([N1, N2, N3, N4, N5]),


    %%%%%%%%%% SOH REGRAS COM MOCHILA + NOMES ... e nada mais
       
    %%%%%%%%%%%%%%%%%%%%%%%% Mês
    mes(Mes1), 
    mes(Mes2), 
    mes(Mes3), 
    mes(Mes4), 
    mes(Mes5),
    alldifferent([Mes1, Mes2, Mes3, Mes4, Mes5]),

    %%%%write('CHEGAMOS lah '),

    %%%%%%%%%% SOH REGRAS COM MOCHILA + NOMES + MES ... e nada mais
    %%% USANDO A NEGACAO 
    Mes1 \== ago, 
    Mes1 \== set, 
    Mes1 \== jan,
    \==(Mes1 , dez),  %%% notacao PREFIXA
    %%%%%%%%%%%%%%%%%%%%%%%% Jogo
    jogo(J1), 
    jogo(J2), 
    jogo(J3), 
    jogo(J4), 
    jogo(J5),

    %Na terceira posição está o menino que gosta do Jogo da Forca
    (J3 == forca),
    alldifferent([J1, J2, J3, J4, J5]),

     write('TODAS regras com jogo e as demais acima ... menos da SUCO '),
        
    %Will está ao lado do menino que gosta de Problemas de Lógica.

     %%%%%%%%%%%%%%%%%%%%%%%% Matéria
    materia(Mat1), 
    materia(Mat2), 
    materia(Mat3), 
    materia(Mat4), 
    materia(Mat5),
    alldifferent([Mat1, Mat2, Mat3, Mat4, Mat5]),

    %%% AQUI PODE VIR REGRAS COM TODOS OS FATOS RELACIONADOS acima
    %%% MENOS SUCO POIS eh O PROXIMO

    %%%%%%%%%%%%%%%%%%%%%%%% INSTANCIA ..... Suco

    suco(S1),
    suco(S2), 
    suco(S3), 
    suco(S4), 
    suco(S5),

    %Na primeira posição está quem gosta de suco de Limão.
    S1==limao,
      
    %Na terceira posição está quem gosta de suco de Morango.
    S3==morango,
    alldifferent([S1, S2, S3, S4, S5]),

    %%%%%%%%%%%%%%% OUTRAS REGRAS COMBINADAS  .... pois esta é a ultima
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    nl,

    write('CHEGAMOS AO FIM DO MODELO')

    . %%% <== NAO ESQUECA O PONTO FINAL
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    %%%%BASE DE DADOS%%%%

    %MOCHILAS
    mochila(amarela).
    mochila(azul).
    mochila(branca).
    mochila(verde).
    mochila(vermelha).

    %NOMES
    nome(denis).
    nome(joao).
    nome(lenin).
    nome(otavio).
    nome(will).

    %MÊS
    mes(ago).
    mes(dez).
    mes(jan).
    mes(maio).
    mes(set).

    %JOGOS
    jogo(tmais).
    jogo(cacap).
    jogo(cubo).
    jogo(forca).
    jogo(logica).

    %MATÉRIAS
    materia(bio).
    materia(geo).
    materia(hist).
    materia(mat).
    materia(port).

    %SUCOS
    suco(laranja).
    suco(limao).
    suco(maracuja).
    suco(morango).
    suco(uva).
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DEFINICAO DE ALLDIFERENT  
	alldifferent([]).
	alldifferent([H|T]):- not(member(H,T)),
	                      alldifferent(T).
	
	imprime_lista([]):- write('\n FIM \n').
	imprime_lista([H|T]):- write('\n......................................\n'),
	                       write(H), write(' : '),
	                       imprime_lista(T).

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	



    
    
