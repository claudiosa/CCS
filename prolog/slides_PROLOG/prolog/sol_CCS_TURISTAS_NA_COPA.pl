% TURISTAS NA COPA
% HENRIQUE
%% Refeito por CCS em dez/2015



main :- 
      %% Tempo inicial
      statistics(cputime,T1),

       meninos([M1, M2, M3, M4,M5]),
  	   writeln("\n TURISTA 1: ":M1),
  	   writeln("\n TURISTA 2: ":M2),
       writeln("\n TURISTA 3: ":M3),
  	   writeln("\n TURISTA 4: ":M4),
       writeln("\n TURISTA 5: ":M5),
       %% Tempo final
      statistics(cputime ,T2),
      Tempo_BUSCA is T2 - T1,
      format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
      format('\n Tempo total: ~10f  msec', Tempo_BUSCA), 
      fail.

main :-  nl, 
         write(' .......... NAO HAH MAIS RESPOSTAS .......').

meninos([
        (Camisa_1, NacionalIdade__1, Bebida_1, Dias_1, Idade_1, Companhia_1),
        (Camisa_2, NacionalIdade__2, Bebida_2, Dias_2, Idade_2, Companhia_2),
        (Camisa_3, NacionalIdade__3, Bebida_3, Dias_3, Idade_3, Companhia_3),
        (Camisa_4, NacionalIdade__4, Bebida_4, Dias_4, Idade_4, Companhia_4),
        (Camisa_5, NacionalIdade__5, Bebida_5, Dias_5, Idade_5, Companhia_5)
        ]) :-

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Camisa_
camisa(Camisa_1),
camisa(Camisa_2),
camisa(Camisa_3),
camisa(Camisa_4),
camisa(Camisa_5),
alldifferent([Camisa_1, Camisa_2, Camisa_3, Camisa_4, Camisa_5]),


%19 Os turistas das Camisa_s amarela e vermelha estão lado a lado.
(
(Camisa_1==vermelhito,Camisa_2==amarelito);
(Camisa_2==vermelhito,(Camisa_1==amarelito;Camisa_3==amarelito));
(Camisa_3==vermelhito,(Camisa_2==amarelito;Camisa_4==amarelito));
(Camisa_4==vermelhito,(Camisa_3==amarelito;Camisa_5==amarelito));
(Camisa_5==vermelhito,Camisa_4==amarelito)
),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NacionalIdade__
nacionalIdade(NacionalIdade__1),
nacionalIdade(NacionalIdade__2),
nacionalIdade(NacionalIdade__3),
nacionalIdade(NacionalIdade__4),
nacionalIdade(NacionalIdade__5),
alldifferent([NacionalIdade__1, NacionalIdade__2, NacionalIdade__3, NacionalIdade__4, NacionalIdade__5]),

%13 O turista de Verde está em algum lugar entre o Espanhol e o turista de Branco, nessa ordem.
(
(NacionalIdade__1==espanhol,Camisa_3==branquito,(Camisa_2==verdito));
(NacionalIdade__1==espanhol,Camisa_4==branquito,(Camisa_2==verdito;Camisa_3==verdito));
(NacionalIdade__1==espanhol,Camisa_5==branquito,(Camisa_2==verdito;Camisa_3==verdito;Camisa_4==verdito));
(NacionalIdade__2==espanhol,Camisa_4==branquito,(Camisa_3==verdito));
(NacionalIdade__2==espanhol,Camisa_5==branquito,(Camisa_3==verdito;Camisa_4==verdito));
(NacionalIdade__3==espanhol,Camisa_5==branquito,(Camisa_4==verdito))
),


%6 O Alemão está exatamente à esquerda do turista de Vermelho.
(
(NacionalIdade__1==alemao,Camisa_2==vermelhito);
(NacionalIdade__2==alemao,Camisa_3==vermelhito);
(NacionalIdade__3==alemao,Camisa_4==vermelhito);
(NacionalIdade__4==alemao,Camisa_5==vermelhito)
),


%10 O Italiano está na terceira posição.
NacionalIdade__3==italiano,



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Bebida_
bebida(Bebida_1),
bebida(Bebida_2),
bebida(Bebida_3),
bebida(Bebida_4),
bebida(Bebida_5),
alldifferent([Bebida_1, Bebida_2, Bebida_3, Bebida_4, Bebida_5]),

% 2 O turista da Camisa_ Verde está em algum lugar entre quem gosta de Água e o Croata, nessa ordem.
(
(Bebida_1==agua,NacionalIdade__3==croata,(Camisa_2==verdito));
(Bebida_1==agua,NacionalIdade__4==croata,(Camisa_2==verdito;Camisa_3==verdito));
(Bebida_1==agua,NacionalIdade__5==croata,(Camisa_2==verdito;Camisa_3==verdito;Camisa_4==verdito));
(Bebida_2==agua,NacionalIdade__4==croata,(Camisa_3==verdito));
(Bebida_2==agua,NacionalIdade__5==croata,(Camisa_3==verdito;Camisa_4==verdito));
(Bebida_3==agua,NacionalIdade__5==croata,(Camisa_4==verdito))
),



%17 O turista que gosta de Café está na quinta posição.
Bebida_5==cafe,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Dias_
dias(Dias_1),
dias(Dias_2),
dias(Dias_3),
dias(Dias_4),
dias(Dias_5),
alldifferent([Dias_1, Dias_2, Dias_3, Dias_4, Dias_5]),

%11 O Alemão está ao lado do turista que passará 20 Dias_ no Brasil.
(
(Dias_1==20,NacionalIdade__1==alemao);
(Dias_2==20,(NacionalIdade__1==alemao;NacionalIdade__3==alemao));
(Dias_3==20,(NacionalIdade__2==alemao;NacionalIdade__4==alemao));
(Dias_4==20,(NacionalIdade__3==alemao;NacionalIdade__5==alemao));
(Dias_5==20,NacionalIdade__4==alemao)
),

%9 O turista de Azul está ao lado do turista que ficará 10 Dias_ no Brasil.
(
(Camisa_1==azulzito,Dias_2==10);
(Camisa_2==azulzito,(Dias_1==10;Dias_3==10));
(Camisa_3==azulzito,(Dias_2==10;Dias_4==10));
(Camisa_4==azulzito,(Dias_3==10;Dias_5==10));
(Camisa_5==azulzito,Dias_4==10)
),
%1 Na primeira posição está quem ficará 15 Dias_ no Brasil.
Dias_1==15,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Idade_
idade(Idade_1),
idade(Idade_2),
idade(Idade_3),
idade(Idade_4),
idade(Idade_5),
alldifferent([Idade_1, Idade_2, Idade_3, Idade_4, Idade_5]),

%4 O Espanhol é o turista mais velho.
(
(Idade_1==57,NacionalIdade__1==espanhol);
(Idade_2==57,NacionalIdade__2==espanhol);
(Idade_3==57,NacionalIdade__3==espanhol);
(Idade_4==57,NacionalIdade__4==espanhol);
(Idade_5==57,NacionalIdade__5==espanhol)
),

%5 O turista de 45 anos está exatamente à direita do turista de 31 anos.
(
(Idade_1==31,Idade_2==45);
(Idade_2==31,Idade_3==45);
(Idade_3==31,Idade_4==45);
(Idade_4==31,Idade_5==45)
),

%7 O turista de 36 anos está exatamente à esquerda do turista que gosta de Leite.
(
(Idade_1==36,Bebida_2==leite);
(Idade_2==36,Bebida_3==leite);
(Idade_3==36,Bebida_4==leite);
(Idade_4==36,Bebida_5==leite)
),

%12 O turista de 28 anos está exatamente à direita do turista que ficará 25 Dias_ no Brasil.
(
(Idade_2==28,Dias_1==25);
(Idade_3==28,Dias_2==25);
(Idade_4==28,Dias_3==25);
(Idade_5==28,Dias_4==25)
),



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Companhia_
companhia(Companhia_1),
companhia(Companhia_2),
companhia(Companhia_3),
companhia(Companhia_4),
companhia(Companhia_5),
alldifferent([Companhia_1, Companhia_2, Companhia_3, Companhia_4, Companhia_5]),

%20 O turista de 31 anos veio com o Amigo.
(
(Idade_1==31,Companhia_1==amigo);
(Idade_2==31,Companhia_2==amigo);
(Idade_3==31,Companhia_3==amigo);
(Idade_4==31,Companhia_4==amigo);
(Idade_5==31,Companhia_5==amigo)
),

%14 Quem gosta de Chá está exatamente à esquerda de quem veio acompanhado do Amigo.
(
(Bebida_1==cha,Companhia_2==amigo);
(Bebida_2==cha,Companhia_3==amigo);
(Bebida_3==cha,Companhia_4==amigo);
(Bebida_4==cha,Companhia_5==amigo)
),

%3 O Alemão está acompanhado do Filho.
(
(NacionalIdade__1==alemao,Companhia_1==filho);
(NacionalIdade__2==alemao,Companhia_2==filho);
(NacionalIdade__3==alemao,Companhia_3==filho);
(NacionalIdade__4==alemao,Companhia_4==filho);
(NacionalIdade__5==alemao,Companhia_5==filho)
),

%8 O turista do meio está acompanhado do Amigo.
Companhia_3==amigo,

%15 Na quinta posição está o turista que veio com a Namorada.
Companhia_5==namorada,

%16 Quem está acompanhado da Esposa está ao lado de quem ficará 20 Dias_ no Brasil.
(
(Companhia_1==esposa,Dias_1==20);
(Companhia_2==esposa,(Dias_1==20;Dias_3==20));
(Companhia_3==esposa,(Dias_2==20;Dias_4==20));
(Companhia_4==esposa,(Dias_3==20;Dias_5==20));
(Companhia_5==esposa,Dias_4==20)
),

%18 O turista que veio com a Esposa está exatamente à esquerda de quem gosta de Leite.

(
(Companhia_1==esposa,Bebida_2==leite);
(Companhia_2==esposa,Bebida_3==leite);
(Companhia_3==esposa,Bebida_4==leite);
(Companhia_4==esposa,Bebida_5==leite)
),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% quase terminandos
  nl,
  write('\n passou pelo final da regra principal do modelo \n')
  .
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%meninos(_) :-  
%      nl, 
%      write(' ...retornar OK devido aos fail .......').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% biblioteca
camisa(amarelito).
camisa(azulzito).
camisa(branquito).
camisa(verdito).
camisa(vermelhito).

nacionalIdade(alemao).
nacionalIdade(croata).
nacionalIdade(espanhol).
nacionalIdade(frances).
nacionalIdade(italiano).

bebida(agua).
bebida(cafe).
bebida(cha).
bebida(cerveja).
bebida(leite).

dias(10).
dias(15).
dias(20).
dias(25).
dias(30).

idade(28).
idade(31).
idade(36).
idade(45).
idade(57).

companhia(amigo).
companhia(filho).
companhia(irma).
companhia(esposa).
companhia(namorada).





% DEFINICAO DE ALLDIFERENT
alldifferent([]).
alldifferent([H|T]):- not(member(H,T)),
                      alldifferent(T).

imprime_lista([]):- write('\n FIM \n').
imprime_lista([H|T]):- write('\n.............\n'),
                       write(H),
                       imprime_lista(T).
