%%% $ swipl -t main -q -f flights_DFS.pl

%% DATABASE -- graph encode

flight( fresno, seattle).
flight( fresno, albany).
flight( fresno, boston).

flight( seattle, omaha).
flight( seattle, dallas).

flight( omaha, albany).
flight( omaha, atlanta).

flight( albany, dallas).
flight( albany, seattle ).

flight( dallas, albany ).
flight( dallas, seattle ).

flight( atlanta, boston ).
flight( atlanta, albany ).
flight( atlanta, dallas ).

%departure(fresno).
departure(boston).

route(A, B ) :- flight( A, B).
route(A, B ) :- flight( A , C), route(C, B ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
move(X,Y) :-  flight(X,Y).    
%%%$ swipl -q -f pgm.pl -t main
/*  *****************************************   */
main  :- 
      % go_01
      % go_02
      departure(X),       
      %search_DFS( [X] , L ),
      %reverse(L,Lsol),
      %format('\n L: ~w	',	[Lsol]),      nl,
      %write(L)
      findall(L,search_DFS( [X] , L ),L_ALL),
      L_ALL \== [],
      write_L(L_ALL), 
      !
      .
main  :- format('\n NO SOLUTION \n ').

go_01 :- route(fresno, atlanta), 
         write('  YES '), !.
go_01 :- 
         write(' NO ').

go_02 :- route(fresno, X), 
         write(' Fresno to  ==> '), write(X),
         false.
go_02 :- true.

/* inicio do pgm :: cond. inicial e parada ... definidas */

 /* HERE the DFS - ground part */
search_DFS( [X|L] , [X|L] ) :-  
    
    departure(Y),
		X \== Y %%%  all cities different of the departure are take into account
    %% specific cities could be considered here
    .
    %nl,
    %write(' ........... ONE SOLUTION WAS FOUND ........').

 /* compara... hah casamento entre o   estado corrente e final ? */

/* HERE the DFS - recursive part */
  search_DFS( [Current_State | VisitedPath], Solution  ) :-
  
  /*   Find a move or a flight -- from database */
        move( Current_State, Nextstate ),     
    
/* check if the next city is already visited */
	   not( is_it_a_member(Nextstate,VisitedPath) ),  
        
/* Recursively a new state is explored */
	search_DFS( [Nextstate, Current_State | VisitedPath], Solution ).
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 qt_move([],0) .
 qt_move([_|L],N) :- qt_move(L,N1), N is N1 + 1.

  is_it_a_member(X, [X|_]):- !.
  is_it_a_member(X, [_|L]):- is_it_a_member(X,L).

%%% print a list of list
  write_L( [] ).
  write_L( [X|T] ) :-
        reverse(X,X_inverted), 
        format('\n Route: ~w',	[ X_inverted ]), 
        write_L( T ).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
