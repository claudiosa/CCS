%
%Amigas na Piscina

go_swipl:- amigas(L), imprime_lista(L).

go:- amigas([ME1, ME2, ME3, ME4]),
	     writeln("\n ME1":ME1),
	     writeln("\n ME2":ME2),
         writeln("\n ME3":ME3),
         writeln("\n ME4":ME4).

%%% A POSICAO DA MENINA ESTAH IMPLICITO
%% NA ORDEM DAS TUPLAS .... 
%% LOGO NAO SEGUE COMO ARGUMENTO
%menina(maio, nome, idade, suco, protetor, animal)
amigas( [(MA1, N1, I1, S1, P1, A1),
         (MA2, N2, I2, S2, P2, A2),
         (MA3, N3, I3, S3, P3, A3),
         (MA4, N4, I4, S4, P4, A4)]):-

  animal(A1), animal(A2), animal(A3), animal(A4),
  /*A garota que gosta de Gatos estah na primeira posicao.*/
  A1==gatos,
  /*Na terceira posicao estah a menina que gosta de Cachorros.*/
  A3==cachorros,
  /*Quem gosta de Peixes estah em uma das pontas.*/
  A4==peixes,
  alldifferent([A1, A2, A3, A4]),

  nome(N1), nome(N2), nome(N3), nome(N4),
  /*Vivian gosta de Pahssaros.*/
  N2==vivian,
  /*Raquel estah na primeira posicao.*/
  N1==raquel,
  alldifferent([N1, N2, N3, N4]),

  protetor(P1), protetor(P2), protetor(P3), protetor(P4),
  /*Na segunda posicao estah a menina que usa filtro solar com FPS 55.*/
  P2==fps55,
  /*A garota mais nova estah ao lado da que usa protetor solar de menor FPS.*/
  P3==fps40,
  alldifferent([P1, P2, P3, P4]),

  idade(I1), idade(I2), idade(I3), idade(I4),
  /*A garota de 8 anos estah na quarta posicao.*/
  I4==8,
  /*A garota de 11 anos estah em uma das pontas.*/
  I1==11,
  alldifferent([I1, I2, I3, I4]),

  suco(S1), suco(S2), suco(S3), suco(S4),
  /*Quem gosta de suco de Morango estah na quarta posicao.*/
  S4==morango,
  /*Quem gosta de suco de Laranja estah em uma das pontas.*/
  S1==laranja,
  alldifferent([S1, S2, S3, S4]),

  maio(MA1), maio(MA2), maio(MA3), maio(MA4),
  /*A menina de maio^ Verde estah na quarta posicao.*/
  MA4==verde,
  /*A menina de maio^ Branco estah em uma das pontas.*/
  MA1==branco,
  alldifferent([MA1, MA2, MA3, MA4]),

  /*Ana usa protetor solar de FPS 50.*/
  N4==ana,P4==fps50,

  /*A menina que gosta de suco de Maracujah estah ao lado da que gosta de Pahssaros.*/
  ((A2==passaros,S3==maracuja);(A2==passaros,S1==maracuja)),

  /*A menina que gosta de limonada estah ao lado da que gosta de suco de Maracujah.*/
  (
   (S2==limao,S3==maracuja);
   (S3==limao,S2==maracuja)

  ),

  /*A menina de maio^ Azul estah em algum lugar ah esquerda da menina de 9 anos.*/

  (
   (I2==9,MA1==azul);
   (I3==9,MA2==azul)
  ).

%------------------------------------------------

%FATOS
%Maios
 maio(amarelo).
 maio(azul).
 maio(branco).
 maio(verde).

%Nomes
 nome(ana).
 nome(bruna).
 nome(raquel).
 nome(vivian).

%Idades
 idade(8).
 idade(9).
 idade(10).
 idade(11).

%Sucos
 suco(laranja).
 suco(limao).
 suco(maracuja).
 suco(morango).

%Protetor
 protetor(fps40).
 protetor(fps45).
 protetor(fps50).
 protetor(fps55).

%Animais
 animal(cachorros).
 animal(gatos).
 animal(passaros).
 animal(peixes).

%-------------------------------------------------------
%%% ESTUDO INDIVIDUAL ... REUSE exit

alldifferent([]).
alldifferent([H|T]):- %%%not(member(H,T)),
                      \+(member(H,T)),
                      alldifferent(T).

imprime_lista([]):- write('\n FIM \n').
imprime_lista([H|T]):- write('\n.............\n'),
                       write(H),
                       imprime_lista(T).
