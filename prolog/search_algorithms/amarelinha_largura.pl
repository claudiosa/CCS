/* BUSCA em LARGURA */

/*
   X2    X5
X1    X4    X7
   X3    X6
*/
   

move((X1,X2,X3,X4,X5,X6,X7), (X1,X4,X3,X2,X5,X6,X7)) :-  X2 == '_';  X4 == '_'. 
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X4,X3,X5,X6,X7)) :-  X3 == '_';  X4 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X2,X1,X3,X4,X5,X6,X7)) :-  X1 == '_';  X2 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X3,X2,X1,X4,X5,X6,X7)) :-  X1 == '_';  X3 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X6,X5,X4,X7)) :-  X4 == '_';  X6 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X5,X4,X6,X7)) :-  X4 == '_';  X5 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X4,X7,X6,X5)) :-  X5 == '_';  X7 == '_'.
move((X1,X2,X3,X4,X5,X6,X7), (X1,X2,X3,X4,X5,X7,X6)) :-  X6 == '_';  X7 == '_'.


inicio :-  
    statistics(cputime,T1),
    pt_origem(X),
    busca([[X]], Solucao), 
    /* X  é o nó inicial, logo entra na lista inicial */
    reverse(Solucao, Sol_invertida),
    write_L(Sol_invertida),
    length(Sol_invertida, Total),
    pt_destino(Y),
    format('\n Onde a posicao inicial era: ~w ', X),
    format('\n A posicao final era: ~w', Y),
    format('\n Total de estados: ~d', Total), 
    Aux is (Total -1),
    format('\n Total de movimentos: ~w', Aux), 
    statistics(cputime ,T2),
    Temp is T2 - T1, 
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Tempo total: ~10f  msec', Temp), !.


inicio:- nl, write('Sem solução ... caminho não encontrado!').


/* pontos iniciais e finais do problema */
pt_origem(  ('b', 'a', 'c','_','_','_','_') ).
pt_destino( ('_', '_', '_','_','c','a','b') ).

/*************************************************************/
%% cond. de parada.... o nó corrente é o desejado
busca( [ [No_final|Caminho] |_] , [No_final | Caminho ] ):-
        pt_destino(No_final) , !. %% termina a busca...

/* parte recursiva geral */
busca([Nodo|Caminho],Solucao):-
          expandir(Nodo, Novos_caminhos),
          append(Caminho, Novos_caminhos, Novo_caminho),
          busca(Novo_caminho, Solucao).

expandir([Nodo|Caminho],Novos_caminhos) :-
           findall([Novo_nodo, Nodo|Caminho],
           (move(Nodo, Novo_nodo),
           not(member(Novo_nodo,[Nodo|Caminho]))),
           Novos_caminhos), !. /* ultima linha do findall */
expandir(_,[]).

/*************************************************************/
/*
   X2    X5
X1    X4    X7
   X3    X6
*/

w_amarelinha((X1,X2,X3,X4,X5,X6,X7)) :-
       write('  '), write(X2), write('  '), write(X5), nl,
       write(X1), write('  '), write(X4), write('  '), write(X7), nl, 
       write('  '), write(X3), write('  '), write(X6).
       
 
 write_L([]).
 write_L([X|L]):-  w_amarelinha(X), nl, nl, write_L(L).
/************************************************************/

/*
?- ['amarelinha_largura.pl'].
% amarelinha_largura.pl compiled 0.00 sec, 12 bytes
true.

?- inicio.
  a  _
b  _  _
  c  _

  _  _
b  a  _
  c  _

  b  _
_  a  _
  c  _

  b  _
_  _  _
  c  a

  _  _
_  b  _
  c  a

  _  b
_  _  _
  c  a

  _  b
_  c  _
  _  a

  _  _
_  c  b
  _  a

  _  c
_  _  b
  _  a


 Onde a posicao inicial era: b, a, c, _, _, _, _ 
 A posicao final era: _, _, _, _, c, a, b
 Total de estados: 9
 Total de movimentos: 8
 T1: 0.290000 	 T2: 34.260000  msec
 Tempo total: 33.9700000000  msec
true.

*/


