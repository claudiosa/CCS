/* problema das rainhas */
  nqueens(N):-
	makelist(N,L),
	Diagonal is N*2-1,
	makelist(Diagonal,LL),
	placeN(N,board([],L,L,LL,LL),Final),
	write(Final).

  placeN(_,board(D,[],[],D1,D2),board(D,[],[],D1,D2)):-!.
  placeN(N,Board1,Result):-
	place_a_queen(N,Board1,Board2),
	placeN(N,Board2,Result).

  place_a_queen(N,
	board(Queens,Rows,Columns,Diag1,Diag2),
	board([q(R,C)|Queens],NewR,NewC,NewD1,NewD2)):-
		
	nextrow(R,Rows,NewR),
	findandremove(C,Columns,NewC),
	D1 is N+C-R,findandremove(D1,Diag1,NewD1),
	D2 is R+C-1,findandremove(D2,Diag2,NewD2).

  findandremove(X,[X|Rest],Rest).
  findandremove(X,[Y|Rest],[Y|Tail]):-
	findandremove(X,Rest,Tail).

  makelist(1,[1]).
  makelist(N,[N|Rest]) :-
	N1 is N-1,
	makelist(N1,Rest).

  nextrow(Row,[Row|Rest],Rest).

:- X = 8 , nqueens(X),nl.
