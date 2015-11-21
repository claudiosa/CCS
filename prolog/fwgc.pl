                       
/* 04/06/99****************************************************
Problema do Pastor (Farmer),  Lobo (Wolf), ovelha (Goat),  
e o repollho (Cabbage).

Esse exemplo foi modificado e adaptado 
a partir do exemplo "fwgc.pro" do Visual Prolog

Descrevendo o problema:
The state of the system is indicated by stating where the
farmer, the goat the wolf and the cabbage (where) are located::
state( Farmer, Wolf, Goat, Cabbage) 

O Problema:
The problem is that a state must only be visited once, and
some states are illegal.

O cuidado:
 This is checked by 'unsafe' and 'eh_menbro'. 
 
 
O inicio:

A farmer with his goat, wolf and cabbage come to a river that they wish to
cross. There is a boat, but it only has room for two, and the farmer is the
only one that can row. 

If the goat and cabbage get in the boat at the same
time, the cabbage gets eaten. Similarly, if the wolf and goat are together
without the farmer, the goat is eaten. Devise a series of crossings of the
river so that all concerned make it across safely.

The state of the system is indicated by a structure STATE stating where the
farmer, the goat the wolf and the cabbage are located. The goal is then how
to transform the start state to the endstate through a series of valid
states.

The valid states are checked by the predicate 'unsafe'

The problem is that a state must only be visited once, this is handled by
collecing the visited stetes in a list, and checking that a new state isnot
already in the list.

The Predicate "go" can be called with a start state and a final state

 ===> quanto a correspondencia dos functores...

Repolho -------------------|
Ovelha ---------------|    |
Lobo   ----------|    |    |  
Pastor -----|    |    |    | 
            V    V    V    V
move(state(east,east,east,east), state(west,west,west,west) ).
      ^                           ^
      |                           |
      |                           |
    Corrente                     Novo
    

   goal interno ===> x.

*******************************************/


x  :- busque(state(east,east,east,east), [] ).

/* melhora a busca ===> jah informa qual estado que
   os 04 objetos já se encontraram ... */
x  :- busque(state(east,east,east,east), [state(east,east,east,east)]).
x.

/* inicio do pgm :: cond. inicial e parada ... definidas */

 /* condicao de parada no estado final:: The final state is reached */
  busque( X , L) :-  
		X == state(west,west,west,west),
		nl,
		write('=============================================='),
		nl,
		write('Uma nova solução é: \n'),
		write_path(L), 
		fail .

 /* compara... hah casamento entre o   estado corrente e final ? */

/* aqui é o cerne do processo de busca */
  busque(StartState , VisitedPath):-
	/* ache um movimento:: Find a move */
        move(StartState,NextState),     
      
       /* verifique se eh valido:: Check that it is not unsage*/
        not( unsafe(NextState) ),      
    
    	/* verifique se jah nao esteve em uma tentativa anterios
	 Check that we have not had this situation before
	 */
	not( eh_menbro(NextState,VisitedPath) ),  
        
	/* encontre recursivamente outro movimento */
	busque( NextState, [NextState|VisitedPath]).



  /* definindo os movimentos possiveis */
  
  /* Move FARMER + WOLF */
  move(state(X,X,G,C),state(Y,Y,G,C)):-opposite(X,Y). 
  
  /*Move FARMER + GOAT */
  move(state(X,W,X,C),state(Y,W,Y,C)):-opposite(X,Y).  
  
  /* Move FARMER + CABBAGE */
  move(state(X,W,G,X),state(Y,W,G,Y)):-opposite(X,Y).  
  
  /* Move ONLY FARMER */
  move(state(X,W,G,C),state(Y,W,G,C)):-opposite(X,Y).  

  opposite(east,west).
  opposite(west,east).

  unsafe( state(F,X,X,_) ):- opposite(F,X),!. /* The wolf eats the goat*/
  unsafe( state(F,_,X,X) ):- opposite(F,X),!. /* The goat eats the cabbage*/

  eh_menbro(X,[X|_]):-!.
  eh_menbro(X,[_|L]):-eh_menbro(X,L).

  write_path( [H1,H2|T] ) :-
        write_move(H1,H2),
        write_path([H2|T]).
  write_path( [] ).

/* as travessias */
  write_move( state(X,W,G,C), state(Y,W,G,C) ) :-!,
        write('The Farmer crosses the river from '), 
	write(X), write(' to '),write(Y), nl.
 
  write_move( state(X,X,G,C), state(Y,Y,G,C) ) :-!,
     write('The Farmer takes the Wolf from '),
     write(X),  write(' of the river to '), write(Y),nl.
 
  write_move( state(X,W,X,C), state(Y,W,Y,C) ) :-!,
         write('The Farmer takes the Goat from '),
	 write(X), write(' of the river to '), write(Y),nl.
 
  write_move( state(X,W,G,X), state(Y,W,G,Y) ) :-!,
        write('The Farmer takes the Cabbage from '), 
	write(X), write(' of the river to '), write(Y), nl.


/*******************************************/
   