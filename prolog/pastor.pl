\begin{verbatim}
/* Problema do pastor
 ===> quanto a correspondencia dos functores...

Repolho -------------------|
Ovelha ---------------|    |
Lobo   ----------|    |    |  
Pastor -----|    |    |    | 
            V    V    V    V
move(estado(esquerda,esquerda,esquerda,esquerda), estado(direita,direita,direita,direita) ).
      ^                           ^
      |                           |
      |                           |
    Corrente                     Novo
    

   goal interno ===> x.

*******************************************/

x  :- busca(estado(esquerda,esquerda,esquerda,esquerda), [] ).

/* melhora a busca ===> jah informa qual estado que
   os 04 objetos já se encontraram ... */
x  :- busca(estado(esquerda,esquerda,esquerda,esquerda)  , 
      [estado(esquerda,esquerda,esquerda,esquerda)]).
x.

/* inicio do pgm :: cond. inicial e parada ... definidas */

 /* condicao de parada no estado final  */
  busca( X , L) :-  
		X == estado(direita,direita,direita,direita),
		nl,
		write('=============================================='),
		qt_move(L,N),
		write('\n Uma solução com '), write(N),
		write(' movimentos é dada por:: \n'),
		write_path(L), 
		fail.

 /* compara... hah casamento entre o   estado corrente e final ? */

/* aqui é o cerne do processo de busca */
  busca(Startstate , VisitedPath):-
	/* ache um movimento:: Find a move */
        move(Startstate,Nextstate),     
      
       /* Verifique se é valido */
        not( inseguro(Nextstate) ),      
    
/* Verifique se já não esteve em uma tentativa anteriores */
	not( eh_menbro(Nextstate,VisitedPath) ),  
        
/* encontre recursivamente outro movimento */
	busca( Nextstate, [Nextstate|VisitedPath]).


  /* Definindo os movimentos possiveis */
  
  /* Move Pastor + Lobo */
  move(estado(X,X,O,R),estado(Y,Y,O,R)):-oposto(X,Y). 
  
  /*Move Pastor + Ovelha */
  move(estado(X,L,X,R),estado(Y,L,Y,R)):-oposto(X,Y).  
  
  /* Move Pastor + Repolho */
  move(estado(X,L,O,X),estado(Y,L,O,Y)):-oposto(X,Y).  
  
  /* Move Pastor sozinho */
  move(estado(X,L,O,R),estado(Y,L,O,R)):-oposto(X,Y).  

  oposto(esquerda,direita).
  oposto(direita,esquerda).

 /* O lobo come a ovelha */	
 inseguro( estado(P,X,X,_) ):- oposto(P,X),!.  
 /* A ovelha come o lobo */
 inseguro( estado(P,_,X,X) ):- oposto(P,X),!. 

 qt_move([],0).
 qt_move([_|L],N) :- qt_move(L,N1), N is N1 + 1.

  eh_menbro(X,[X|_]):-!.
  eh_menbro(X,[_|L]):-eh_menbro(X,L).

  write_path( [H1,H2|T] ) :-
        write_move(H1,H2),
        write_path([H2|T]).
  write_path( [] ).

/* as travessias */
  write_move( estado(X,W,G,C), estado(Y,W,G,C) ) :-!,
        write('The Pastor crosses the river from '), 
	write(X), write(' to '),write(Y), nl.
 
  write_move( estado(X,X,G,C), estado(Y,Y,G,C) ) :-!,
     write('The Pastor takes the Lobo from '),
     write(X),  write(' of the river to '), write(Y),nl.
 
  write_move( estado(X,W,X,C), estado(Y,W,Y,C) ) :-!,
         write('The Pastor takes the Ovelha from '),
	 write(X), write(' of the river to '), write(Y),nl.
 
  write_move( estado(X,W,G,X), estado(Y,W,G,Y) ) :-!,
        write('The Pastor takes the Repolho from '), 
	write(X), write(' of the river to '), write(Y), nl.


\end{verbatim}
