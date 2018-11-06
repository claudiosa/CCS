% TURISTAS NA COPA
% TRABALHO EM GRUPO
% RENATO DOUGLAS ZEMBRANI
% RODRIGO SOTELI


main :- 
  %% Tempo inicial
  statistics(cputime,Time_stamp_1),
   turistas([T1, T2, T3, T4, T5]),
   nl,
	 write('TURISTA 1: ') , writeln(T1),
	 write('TURISTA  2: ') ,writeln(T2),
   write('TURISTA 3: ') ,writeln(T3),
	 write('TURISTA 4: ') , writeln(T4),
   write('TURISTA 5: ') , writeln(T5),
 
  %% Tempo final
    statistics(cputime ,Time_stamp_2),
    Tempo_BUSCA is Time_stamp_2 - Time_stamp_1,
     format('\n T1: ~f \t T2: ~f  msec', [Time_stamp_1, Time_stamp_2]),
     format('\n Tempo total: ~10f  msec', Tempo_BUSCA), 
      fail.

main :- write(' UMA RESPOSTA ').

turistas(
          [(Camisa_1, Nacionalidade_1, Bebida_1, Dias_1, Idade_1, Companhia_1),
             (Camisa_2, Nacionalidade_2, Bebida_2, Dias_2, Idade_2, Companhia_2),
             (Camisa_3, Nacionalidade_3, Bebida_3, Dias_3, Idade_3, Companhia_3),
             (Camisa_4, Nacionalidade_4, Bebida_4, Dias_4, Idade_4, Companhia_4),
             (Camisa_5, Nacionalidade_5, Bebida_5, Dias_5, Idade_5, Companhia_5)
          ]):-

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Camisa_

camisa(Camisa_1), camisa( Camisa_2 ), camisa(Camisa_3), camisa(Camisa_4), camisa(Camisa_5),
alldifferent([Camisa_1, Camisa_2, Camisa_3, Camisa_4, Camisa_5]),



% 19. Os turistas das Camisas amarela e vermelha estão lado a lado.

(
(Camisa_1==amarela, Camisa_2==vermelha);
(Camisa_2==amarela, Camisa_3==vermelha);
(Camisa_3==amarela, Camisa_4==vermelha);
(Camisa_4==amarela, Camisa_5==vermelha);
(Camisa_2==amarela, Camisa_1==vermelha);
(Camisa_3==amarela, Camisa_2==vermelha);
(Camisa_4==amarela, Camisa_3==vermelha);
(Camisa_5==amarela, Camisa_4==vermelha)
),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nacionalidade_

nacionalidade(Nacionalidade_1),nacionalidade(Nacionalidade_2),nacionalidade(Nacionalidade_3),nacionalidade(Nacionalidade_4),nacionalidade(Nacionalidade_5),


% 10. O Italiano está na terceira posição.

Nacionalidade_3==italiano,


alldifferent([Nacionalidade_1,Nacionalidade_2,Nacionalidade_3,Nacionalidade_4,Nacionalidade_5]),



% 13. O turista de Verde está em algum lugar entre o Espanhol e o turista de Branco, nessa ordem.

(
((Camisa_2==verde), Nacionalidade_1==espanhol, Camisa_3==branca);
((Camisa_2==verde), Nacionalidade_1==espanhol, Camisa_4==branca);
((Camisa_2==verde), Nacionalidade_1==espanhol, Camisa_5==branca);
((Camisa_3==verde), Nacionalidade_2==espanhol, Camisa_4==branca);
((Camisa_3==verde), Nacionalidade_2==espanhol, Camisa_5==branca);
((Camisa_4==verde), Nacionalidade_3==espanhol, Camisa_5==branca)
),

% 6. O Alemão está exatamente à esquerda do turista de Vermelho.

(
(Nacionalidade_1==alemao, Camisa_2==vermelha);
(Nacionalidade_2==alemao, Camisa_3==vermelha);
(Nacionalidade_3==alemao, Camisa_4==vermelha);
(Nacionalidade_4==alemao, Camisa_5==vermelha)
),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Bebida_

bebida(Bebida_1), bebida(Bebida_2), bebida(Bebida_3), bebida(Bebida_4), bebida(Bebida_5),

% 17. O turista que gosta de Café está na quinta posição.

Bebida_5==cafe,

alldifferent([Bebida_1, Bebida_2, Bebida_3, Bebida_4, Bebida_5]),

% 2. O turista da Camisa_ Verde está em algum lugar entre quem gosta de Água e o Croata, nessa ordem.

(
((Camisa_2==verde),Bebida_1==agua,Nacionalidade_3==croata);
((Camisa_2==verde),Bebida_1==agua,Nacionalidade_4==croata);
((Camisa_2==verde),Bebida_1==agua,Nacionalidade_5==croata);
((Camisa_3==verde),Bebida_2==agua,Nacionalidade_4==croata);
((Camisa_3==verde),Bebida_2==agua,Nacionalidade_5==croata);
((Camisa_4==verde),Bebida_3==agua,Nacionalidade_5==croata)
),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Dias_

dias(Dias_1),dias(Dias_2),dias(Dias_3),dias(Dias_4),dias(Dias_5),

% 1. Na primeira posição está quem ficará 15 Dias_ no Brasil.

Dias_1==15,

alldifferent([Dias_1,Dias_2,Dias_3,Dias_4,Dias_5]),

% 11. O Alemão está ao lado do turista que passará 20 Dias_ no Brasil.

(
(Nacionalidade_1==alemao, Dias_2==20);
(Nacionalidade_2==alemao, Dias_3==20);
(Nacionalidade_3==alemao, Dias_4==20);
(Nacionalidade_4==alemao, Dias_5==20);
(Nacionalidade_5==alemao, Dias_4==20);
(Nacionalidade_4==alemao, Dias_3==20);
(Nacionalidade_3==alemao, Dias_2==20);
(Nacionalidade_2==alemao, Dias_1==20)
),

%9. O turista de Azul está ao lado do turista que ficará 10 Dias no Brasil.

(
(Camisa_1==azul, Dias_2==10);
(Camisa_2==azul, Dias_3==10);
(Camisa_3==azul, Dias_4==10);
(Camisa_4==azul, Dias_5==10);
(Camisa_5==azul, Dias_4==10);
(Camisa_4==azul, Dias_3==10);
(Camisa_3==azul, Dias_2==10);
(Camisa_2==azul, Dias_1==10)
),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Idade_

idade(Idade_1),idade(Idade_2),idade(Idade_3),idade(Idade_4),idade(Idade_5),
alldifferent([Idade_1,Idade_2,Idade_3,Idade_4,Idade_5]),


% 5. O turista de 45 anos está exatamente à direita do turista de 31 anos.

(
(Idade_1==31, Idade_2==45);
(Idade_2==31, Idade_3==45);
(Idade_3==31, Idade_4==45);
(Idade_4==31, Idade_5==45)
),

% 7. O turista de 36 anos está exatamente à esquerda do turista que gosta de Leite.

(
(Idade_1==36, Bebida_2==leite);
(Idade_2==36, Bebida_3==leite);
(Idade_3==36, Bebida_4==leite);
(Idade_4==36, Bebida_5==leite)
),

% 4. O Espanhol é o turista mais velho.

(
(Nacionalidade_1==espanhol, Idade_1==57);
(Nacionalidade_2==espanhol, Idade_2==57);
(Nacionalidade_3==espanhol, Idade_3==57);
(Nacionalidade_4==espanhol, Idade_4==57);
(Nacionalidade_5==espanhol, Idade_5==57)
),

% o turista de 25 anos esta exatamente a direita do de 28..

(
(Dias_1==25, Idade_2==28);
(Dias_2==25, Idade_3==28);
(Dias_3==25, Idade_4==28);
(Dias_4==25, Idade_5==28)
),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Companhia_

companhia(Companhia_1),companhia(Companhia_2),companhia(Companhia_3),companhia(Companhia_4),companhia(Companhia_5),

% 8. O turista do meio está acompanhado do Amigo.

Companhia_3==amigo,

% 15. Na quinta posição está o turista que veio com a Namorada.

Companhia_5==namorada,

alldifferent([Companhia_1,Companhia_2,Companhia_3,Companhia_4,Companhia_5]),


% 14. Quem gosta de Chá está exatamente à esquerda de quem veio acompanhado do Amigo.

(
(Bebida_1==cha, Companhia_2==amigo);
(Bebida_2==cha, Companhia_3==amigo);
(Bebida_3==cha, Companhia_4==amigo);
(Bebida_4==cha, Companhia_5==amigo)
),

% 3. O Alemão está acompanhado do Filho.

(
(Nacionalidade_1==alemao, Companhia_1==filho);
(Nacionalidade_2==alemao, Companhia_2==filho);
(Nacionalidade_3==alemao, Companhia_3==filho);
(Nacionalidade_4==alemao, Companhia_4==filho);
(Nacionalidade_5==alemao, Companhia_5==filho)
),



% 16. Quem está acompanhado da Esposa está ao lado de quem ficará 20 Dias_ no Brasil.

(
(Companhia_1==esposa, Dias_2==20);
(Companhia_2==esposa, Dias_3==20);
(Companhia_2==esposa, Dias_1==20);
(Companhia_4==esposa, Dias_3==20);
(Companhia_4==esposa, Dias_5==20)
),

% 18. O turista que veio com a Esposa está exatamente à esquerda de quem gosta de Leite.

(
(Companhia_1==esposa, Bebida_2==leite);
(Companhia_2==esposa, Bebida_3==leite);
(Companhia_4==esposa, Bebida_5==leite)
),

  
% 20. O turista de 31 anos veio com o Amigo.

(
(Idade_1==31, Companhia_1==amigo);
(Idade_2==31, Companhia_2==amigo);
(Idade_3==31, Companhia_3==amigo);
(Idade_4==31, Companhia_4==amigo);
(Idade_5==31, Companhia_5==amigo)
),

    
   
nl,
write('...... UFA cheguei aqui no final do modelo .....'),
nl.

%%%% other else de tudo acima
%turistas(_) :- write('...... nao hah mais respostas .....').






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%BIBLIOTECA

camisa(amarela).
camisa(azul).
camisa(branca).
camisa(verde).
camisa(vermelha).

nacionalidade(alemao).
nacionalidade(croata).
nacionalidade(espanhol).
nacionalidade(frances).
nacionalidade(italiano).

bebida(agua).
bebida(cafe).
bebida(cerveja).
bebida(cha).
bebida(leite).

dias(10).
dias(15).
dias(20).
dias(25).
dias(30).

idade(28).
idade(36).
idade(31).
idade(45).
idade(57).

companhia(amigo).
companhia(filho).
companhia(irma).
companhia(esposa).
companhia(namorada).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% DEFINICAO DE ALLDIFERENT
alldifferent([]).
alldifferent([H|T]):- not(member(H,T)),
                      alldifferent(T).

imprime_lista([]):- write('\n FIM \n').
imprime_lista([H|T]):- write('\n.............\n'),
                       write(H),
                       imprime_lista(T).
