% TURISTAS NA COPA
% TRABALHO EM GRUPO
% RENATO DOUGLAS ZEMBRANI
% RODRIGO SOTELI


main :- 
%% Tempo inicial
    statistics(cputime,T1),


aluno([A1, A2, A3, A4, A5]),
  	 writeln("\n aluno 1: ":A1),
  	 writeln("\n aluno 2: ":A2),
     writeln("\n aluno 3: ":A3),
  	 writeln("\n aluno 4: ":A4),
     writeln("\n aluno 5: ":A5),
      %% Tempo final
      statistics(cputime ,T2),
      Tempo_BUSCA is T2 - T1,
      format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
      format('\n Tempo total: ~10f  msec', Tempo_BUSCA), 
      fail.

main :- write(' UMA RESPOSTA ').


aluno([(Nome_1, Suco_1, Mochila_1, Mes_1, Jogo_1, Materia_1),
             (Nome_2, Suco_2, Mochila_2, Mes_2, Jogo_2, Materia_2),
             (Nome_3, Suco_3, Mochila_3, Mes_3, Jogo_3, Materia_3),
             (Nome_4, Suco_4, Mochila_4, Mes_4, Jogo_4, Materia_4),
             (Nome_5, Suco_5, Mochila_5, Mes_5, Jogo_5, Materia_5)]):-


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nome_

nome(Nome_1),
nome(Nome_2),
nome(Nome_3),
nome(Nome_4),
nome(Nome_5),



% 21. Lenin está na quinta posição.

Nome_5 == lenin ,


% 22. otavio está em uma das pontas.

Nome_1 == otavio ,


alldifferent([Nome_1,Nome_2,Nome_3,Nome_4,Nome_5]),



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Suco_


suco(Suco_1),
suco(Suco_2),
suco(Suco_3),
suco(Suco_4),
suco(Suco_5),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 19. Na primeira posição está quem gosta de Suco_ de limao.

Suco_1 == limao ,


% 6. Na terceira posição está quem gosta de Suco_ de Morango.

Suco_3 == morango ,


alldifferent([Suco_1,Suco_2,Suco_3,Suco_4,Suco_5]),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Mochila_


mochila(Mochila_1),
mochila(Mochila_2),
mochila(Mochila_3),
mochila(Mochila_4),
mochila(Mochila_5),


alldifferent([Mochila_1, Mochila_2, Mochila_3, Mochila_4, Mochila_5]),



% 5. O garoto da Mochila_ Branca está exatamente à esquerda de Will.

(
( Mochila_5 == branca , Nome_4 == will ) ;
( Mochila_4 == branca , Nome_3 == will ) ;
( Mochila_3 == branca , Nome_2 == will ) 
%( Mochila_2 == branca , Nome_1 == will )
) ,


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Mes_


mes(Mes_1), 
mes(Mes_2), 
mes(Mes_3), 
mes(Mes_4), 
mes(Mes_5), 


alldifferent([Mes_1, Mes_2, Mes_3, Mes_4, Mes_5]),


% 1. Quem nasceu em Setembro está ao lado de quem gosta de Suco_ de Laranja

(
( Mes_1 == setembro , Suco_2 == laranja ) ;
%( Mes_2 == setembro , Suco_1 == laranja ) ;
%( Mes_2 == setembro , Suco_3 == laranja ) ;
( Mes_3 == setembro , Suco_2 == laranja ) ;
( Mes_3 == setembro , Suco_4 == laranja ) ;
%( Mes_4 == setembro , Suco_3 == laranja ) ;
( Mes_4 == setembro , Suco_5 == laranja ) ;
( Mes_5 == setembro , Suco_4 == laranja )
),


% 9. O menino que gosta de Suco_ de Uva está em algum lugar à direita do garoto da Mochila_ Azul.

(
%( Suco_1 == uva , Mochila_2 == azul ) ;
%( Suco_1 == uva , Mochila_3 == azul ) ;
%( Suco_1 == uva , Mochila_4 == azul ) ;
%( Suco_1 == uva , Mochila_5 == azul ) ;
%( Suco_2 == uva , Mochila_3 == azul ) ;
%( Suco_2 == uva , Mochila_4 == azul ) ;
%( Suco_2 == uva , Mochila_5 == azul ) ;
%%( Suco_3 == uva , ( Mochila_2 == azul ; Mochila_1 == azul ; Mochila_3 == azul)) ;
( Suco_4 == uva , ( Mochila_2 == azul ; Mochila_1 == azul ; Mochila_3 == azul) ) ;
( Suco_5 == uva , ( Mochila_2 == azul ; Mochila_1 == azul ; Mochila_3 == azul; Mochila_4 == azul ) ) 
%( Suco_3 == uva , Mochila_4 == azul ) ;
%( Suco_3 == uva , Mochila_5 == azul ) ;
%( Suco_4 == uva , Mochila_5 == azul )
) ,


% 13. O menino que nasceu em Janeiro está ao lado de quem nasceu em Setembro.

(
( Mes_1 == janeiro , Mes_2 == setembro ) ;
( Mes_2 == janeiro , Mes_1 == setembro ) ;
( Mes_2 == janeiro , Mes_3 == setembro ) ;
( Mes_3 == janeiro , Mes_2 == setembro ) ;
( Mes_3 == janeiro , Mes_4 == setembro ) ;
( Mes_4 == janeiro , Mes_3 == setembro ) ;
( Mes_4 == janeiro , Mes_5 == setembro ) ;
( Mes_5 == janeiro , Mes_4 == setembro )
) ,


% 3. O garoto da Mochila_ Azul está em algum lugar à esquerda de quem nasceu em Maio.

(
( Mochila_2 == azul , Mes_1 == maio ) ;
( Mochila_3 == azul , Mes_1 == maio ) ;
( Mochila_3 == azul , Mes_2 == maio ) ;
( Mochila_4 == azul , Mes_3 == maio ) ;
( Mochila_4 == azul , Mes_2 == maio ) ;
( Mochila_4 == azul , Mes_1 == maio ) ;
( Mochila_5 == azul , Mes_4 == maio ) ;
( Mochila_5 == azul , Mes_3 == maio ) ;
( Mochila_5 == azul , Mes_2 == maio ) ;
( Mochila_5 == azul , Mes_1 == maio )
) ,


% 17. O dono da Mochila_ Azul nasceu em Janeiro.

(
( Mochila_1 == azul , Mes_1 == janeiro ) ;
( Mochila_2 == azul , Mes_2 == janeiro ) ;
( Mochila_3 == azul , Mes_3 == janeiro ) ;
( Mochila_4 == azul , Mes_4 == janeiro ) ;
( Mochila_5 == azul , Mes_5 == janeiro )
) ,




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Jogo_

jogo(Jogo_1),
jogo(Jogo_2),
jogo(Jogo_3),
jogo(Jogo_4),
jogo(Jogo_5),




% 23. Na terceira posição está o menino que gosta do Jogo_ da Forca.

Jogo_3 == forca,



alldifferent([Jogo_1,Jogo_2,Jogo_3,Jogo_4,Jogo_5]),




% 10. Em uma das pontas está o menino que adora jogar Cubo Vermelho.

(
( Jogo_1 == cubo ) ;
( Jogo_5 == cubo )
) ,



% 4. Will está ao lado do menino que gosta de Problemas de logica.

(
%( Nome_1 == will , Jogo_2 == logica ) ;
( Nome_2 == will , Jogo_1 == logica ) ;
%( Nome_2 == will , Jogo_3 == logica ) ;
( Nome_3 == will , Jogo_2 == logica ) ;
( Nome_3 == will , Jogo_4 == logica ) ;
%( Nome_4 == will , Jogo_3 == logica ) ; 
( Nome_4 == will , Jogo_5 == logica ) 
%( Nome_5 == will , Jogo_4 == logica )
) ,


% 7. Quem gosta de Suco_ de Uva gosta de Problemas de logica.

(
%( Suco_1 ==uva , Jogo_1 == logica ) ;
( Suco_2 ==uva , Jogo_2 == logica ) ;
%( Suco_3 ==uva , Jogo_3 == logica ) ;
( Suco_4 ==uva , Jogo_4 == logica ) ;
( Suco_5 ==uva , Jogo_5 == logica )
) ,


% 11. Quem gosta do Jogo_ da Forca está ao lado do dono da Mochila_ Vermelha.

(
%( Jogo_1 == forca , Mochila_2 == vermelha ) ;
%( Jogo_2 == forca , Mochila_1 == vermelha ) ;
%( Jogo_2 == forca , Mochila_3 == vermelha ) ;
( Jogo_3 == forca , Mochila_2 == vermelha ) ;
( Jogo_3 == forca , Mochila_4 == vermelha ) 
%( Jogo_4 == forca , Mochila_3 == vermelha ) ;
%( Jogo_4 == forca , Mochila_5 == vermelha ) ;
%( Jogo_5 == forca , Mochila_4 == vermelha )
) ,


% 16. Quem curte Problemas de logica está ao lado do menino da Mochila_ Amarela.
(
( Jogo_1 == logica , Mochila_2 == amarela ) ;
( Jogo_2 == logica , Mochila_1 == amarela ) ;
( Jogo_2 == logica , Mochila_3 == amarela ) ;
%( Jogo_3 == logica , Mochila_2 == amarela ) ;
%( Jogo_3 == logica , Mochila_4 == amarela ) ;
( Jogo_4 == logica , Mochila_3 == amarela ) ;
( Jogo_4 == logica , Mochila_5 == amarela ) ;
( Jogo_5 == logica , Mochila_4 == amarela )
) ,


% 8. O garoto que gosta do Jogo_ da Forca está ao lado do que gosta do tres_ou_mais.

(
%( Jogo_1 == forca , Jogo_2 == tres_ou_mais ) ;
%( Jogo_2 == forca , Jogo_1 == tres_ou_mais ) ;
%( Jogo_2 == forca , Jogo_3 == tres_ou_mais ) ;
( Jogo_3 == forca , Jogo_2 == tres_ou_mais ) ;
( Jogo_3 == forca , Jogo_4 == tres_ou_mais ) 
%( Jogo_4 == forca , Jogo_3 == tres_ou_mais ) ;
%( Jogo_4 == forca , Jogo_5 == tres_ou_mais ) ;
%( Jogo_5 == forca , Jogo_4 == tres_ou_mais )
) ,


% 18. O garoto que nasceu em Setembro está ao lado de quem gosta de jogar Cubo Vermelho.

(
( Mes_1 == setembro , Jogo_2 == cubo) ;
( Mes_2 == setembro , Jogo_1 == cubo) ;
%( Mes_2 == setembro , Jogo_3 == cubo) ;
( Mes_3 == setembro , Jogo_2 == cubo) ;
( Mes_3 == setembro , Jogo_4 == cubo) ;
%( Mes_4 == setembro , Jogo_3 == cubo) ;
( Mes_4 == setembro , Jogo_5 == cubo) ;
( Mes_5 == setembro , Jogo_4 == cubo)
) ,



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Materia_


materia(Materia_1),
materia(Materia_2),
materia(Materia_3),
materia(Materia_4),
materia(Materia_5),


alldifferent([Materia_1,Materia_2,Materia_3,Materia_4,Materia_5]),


% 2. joao gosta de historia.

(
%( Nome_1 == joao , Materia_1 == historia ) ;
( Nome_2 == joao , Materia_2 == historia ) ;
( Nome_3 == joao , Materia_3 == historia ) ;
( Nome_4 == joao , Materia_4 == historia ) 
%( Nome_5 == joao , Materia_5 == historia )
) ,



% 12. O garoto que gosta de Biologia gosta de Suco_ de Morango.

(
%( Materia_1 == biologia , Suco_1 == morango ) ;
%( Materia_2 == biologia , Suco_2 == morango ) ;
( Materia_3 == biologia , Suco_3 == morango ) 
%( Materia_4 == biologia , Suco_4 == morango ) ;
%( Materia_5 == biologia , Suco_5 == morango )
) ,


% 14. Quem gosta de Suco_ de Uva está exatamente à esquerda de quem gosta de portugues.

(
%( Suco_1 == uva , Materia_2 == portugues ) ;
( Suco_2 == uva , Materia_3 == portugues ) ;
%( Suco_3 == uva , Materia_4 == portugues ) 
( Suco_4 == uva , Materia_5 == portugues )
) ,


% 20. Quem gosta de matematica gosta também de Suco_ de maracuja..

(
%( Materia_1 == matematica , Suco_1 == maracuja ) ;
( Materia_2 == matematica , Suco_2 == maracuja ) ;
%( Materia_3 == matematica , Suco_3 == maracuja ) ;
( Materia_4 == matematica , Suco_4 == maracuja ) ;
( Materia_5 == matematica , Suco_5 == maracuja )
) ,


% 15. O menino que gosta de matematica nasceu em Dezembro.

(
( Materia_1 == matematica , Mes_2 == dezembro ) ;
( Materia_2 == matematica , Mes_2 == dezembro ) ;
( Materia_3 == matematica , Mes_3 == dezembro ) ;
( Materia_4 == matematica , Mes_4 == dezembro ) ;
( Materia_5 == matematica , Mes_5 == dezembro )
),
 nl,
 write(' AQUI PASSA TODA VEZ QUE AS VARIAVEIS FOREM INSTANCIADAS'),
 write('........FINAL DO MODELO ..........')
.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%BIBLIOTECA

nome(denis).
nome(joao).
nome(lenin).
nome(otavio).
nome(will).


suco(laranja).
suco(limao).
suco(maracuja).
suco(uva).
suco(morango).


mochila(amarela).
mochila(azul).
mochila(branca).
mochila(verde). 
mochila(vermelha).


mes(janeiro).
mes(maio).
mes(agosto).
mes(setembro) .
mes(dezembro).

jogo(tres_ou_mais).
jogo(palavras).
jogo(cubo).
jogo(forca).
jogo(logica).

materia(biologia).
materia(geografia).
materia(historia).
materia(matematica).
materia(portugues).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% DEFINICAO DE ALLDIFERENT
alldifferent([]).
alldifferent([H|T]):- not(member(H,T)),
                      alldifferent(T).

imprime_lista([]):- write('\n FIM \n').
imprime_lista([H|T]):- write('\n.............\n'),
                       write(H),
                       imprime_lista(T).