%
%Nadadores Olimpicos
%

go2 :- solucao(L), imprime_lista(L).

go1 :- solucao([R1, R2, R3, R4]),
	   writeln("\nRAIA 1":R1),
	   writeln("\nRAIA 2":R2),
           writeln("\nRAIA 3":R3),
           writeln("\nRAIA 4":R4).

%(TOUCA, PAIS, ESPECIALIDADE, MEDALHAS, SUCO, IDADE)
solucao([(T1, P1, E1, M1, S1, I1),
	 (T2, P2, E2, M2, S2, I2),
	 (T3, P3, E3, M3, S3, I3),
	 (T4, P4, E4, M4, S4, I4)]):-

  touca(T1), touca(T2), touca(T3), touca(T4),
  %Na ultima raia esta o nadador com a touca branca.
  T4==branca,
  alldifferent([T1, T2, T3, T4]),

  pais(P1), pais(P2), pais(P3), pais(P4),
  %O Brasileiro conquistou o maior numero de medalhas entre os 4 nadadores.
  P3==brasil,
  alldifferent([P1, P2, P3, P4]),

  especialidade(E1), especialidade(E2), especialidade(E3), especialidade(E4),
  %O especialista em nado Peito esta na raia numero 2.
  E2==peito,
  alldifferent([E1, E2, E3, E4]),

  medalhas(M1), medalhas(M2), medalhas(M3), medalhas(M4),
  %Quem ganhou 3 medalhas esta na segunda raia.
  M2==3,
  %O nadador mais velho do grupo conquistou o maior numero de medalhas.
  M3==8,
  alldifferent([M1, M2, M3, M4]),

  suco(S1), suco(S2), suco(S3), suco(S4),
  %Na segunda raia esta o nadador que bebe suco de Laranja.
  S2==laranja,
  alldifferent([S1, S2, S3, S4]),

  idade(I1), idade(I2), idade(I3), idade(I4),
  %O mais velho dos nadadores esta na raia numero 3.
  I3==24,
  
  %Quem usa a touca Azul esta em alguma raia a esquerda do nadador com 19 anos.
  (
  (I2==19, T1==azul);
  (I4==19,(T1==azul; T2==azul; T3==azul))
  ),

  %O nadador com 20 anos esta em uma das raias das pontas.
  (I1==20; I4==20),
   alldifferent([I1, I2, I3, I4]),

 
  %Quem gosta de beber limonada esta exatamente a esquerda de quem eh especialista em nado Crawl.
  (
    (E3==crawl, S2==limao);
    (E4==crawl, S3==limao)
  ),

  %O atleta que bebe suco de Maracuja esta em alguma raia a direita de quem usa a touca Azul.
  (
    (T1==azul, (S3==maracuja; S4==maracuja));
    (T2==azul, (S3==maracuja; S4==maracuja));
    (T3==azul, S4==maracuja)
  ),

  %Quem ganhou 5 medalhas esta posicionado exatamente a esquerda de quem gosta de suco de Laranja.
  S2==laranja, M1==5,

  %O especialista em nado Costas esta exatamente a direita de quem conquistou 3 medalhas.
  M2==3,
  E3==costas,

  %O nadador da China esta exatamente a esquerda do nadador do Brasil.
  P3==brasil,
  P2==china,

  %O nadador dos EUA conquistou 5 medalhas.
  (
   (P1==eua, M1==5);
   (P4==eua, M4==5)
  ),

  %O especialista em nado Borboleta esta ao lado de quem usa a touca Azul.
  (
    (E1==borboleta, T2==azul);
    (E3==borboleta, T2==azul);
    (E4==borboleta, T3==azul)
  ),

  %O nadador Estadunidense esta usando a touca verde.
  (
    (P1==eua, T1==verde);
    (P2==eua, T2==verde)
  ).

%-------------------------------------------

%Fatos
%Touca
 touca(amarela).
 touca(azul).
 touca(verde).
 touca(branca).

%Pais
 pais(brasil).
 pais(china).
 pais(eua).
 pais(russia).

%Especialidades
 especialidade(borboleta).
 especialidade(costas).
 especialidade(crawl).
 especialidade(peito).

%Medalhas
 medalhas(2).
 medalhas(3).
 medalhas(5).
 medalhas(8).

%Suco
 suco(abacaxi).
 suco(limao).
 suco(laranja).
 suco(maracuja).

%Idade
 idade(19).
 idade(20).
 idade(21).
 idade(24).

%-------------------------------------------

alldifferent([]).
alldifferent([H|T]):- not(member(H,T)),
                      alldifferent(T).

imprime_lista([]):- write('\n FIM \n').
imprime_lista([H|T]):- write('\n.............\n'),
                       write(H),
                       imprime_lista(T).


%-------------------------------------------










