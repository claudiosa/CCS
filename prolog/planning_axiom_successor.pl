

/*initial conditions */
ethan_loc(0,0).
members_loc([[1,1],[1,2]]).
submarine(0,2).
capacity(1).


% https://faculty.nps.edu/ncrowe/book/chap10.html


/*preconditions for primitive actions */
%%% successor state axiom
%%% THE MAP -- GRID
w(0,0).  w(0,1).  w(0,2).  w(0,3). 
w(1,0).  w(1,1).  w(1,2).  w(1,3).
w(2,0).  w(2,1).  w(2,2).  w(2,3).
w(3,0).  w(3,1).  w(3,2).  w(3,3).


%%%% GREAT IDEA 
%%% there is conection if ... next_w ... and new w(X,Y) must be true or valid.
%%% failure in the rule .. not by tail.
/*** inverted ***/
d2(X,Y, X1,Y1, Direction) :- 
  next_w(X1,Y1,X,Y, Direction), 
  w(X,Y).

/*** normal ****/
d(X0,Y0,X,Y, Direction) :- 
  next_w(X0,Y0,X,Y, Direction), 
  w(X,Y).
%%% ONLY ALLOWED MOVEMENTS
next_w(X0,Y0,X0,Y, right) :- Y is Y0+1. %%% RIGHT 
next_w(X0,Y0,X,Y0, down) :- X is X0+1. %%% DOWN
next_w(X0,Y0,X0,Y, left) :- Y is Y0-1. %%% LEFT
next_w(X0,Y0,X,Y0, up) :- X is X0-1. %%% UP
%%% PERFORMANCE

%% goal(S) :- ......... .

/*legal axioms*/
legal(s0).
legal( result(A,S) ):- 
  legal(S) , 
  ethan(A,S).
  %action(A,S).

/*preconditions for primitive actions */
/*
action(up , S) :- 
   ethan((X,Y) , result(up,S)),
   %%% conditions for this movement
   d(X,Y,X1,Y1, up ).

action(down , S) :- 
    ethan((X,Y) , result(down,S)),
    %%% conditions for this movement
    d(X,Y,X1,Y1, down ).

action(right , S) :- 
    ethan((X,Y), result(right,S)),
    %%% conditions for this movement
    d(X,Y,X1,Y1, right ).
 
action(left , S) :- 
     ethan((X,Y), result(left,S)),
     %%% conditions for this movement
     d(X,Y,X1,Y1, left ).
*/
/* successor state axioms for primitive fluents */
ethan( (2,2), s0) :- !.

ethan( (0,0), s0) :- !.
    
%%% result = do
ethan( (X1,Y1),  result(Action, State) ) :-
    %Start = s0,
    %Ran is random(4), %% 0 up to 3 -> 4 values
    d2(X,Y,X1,Y1, Action ),
    %Action \== Ran ,
    Action = up,
    ethan((X,Y), State).
    
  ethan( (X1,Y1),  result(Action, State) ) :-
    %Start = s0,
    d2(X,Y,X1,Y1, Action ),
    %Action \== Ran ,
    Action = down,
    ethan((X,Y), State).
/*
    ethan((X,Y), State),
    d(X,Y,X1,Y1,  down ),
    Action = down, !.
 */

 ethan( (X1,Y1),  result(Action, State) ) :-
  %Start = s0,
  d2(X,Y,X1,Y1, Action ),
  %Action \== Ran ,
  Action = left,
  ethan((X,Y), State).
/*  
  ethan((X,Y), State),
  d(X,Y,X1,Y1,  left ),
  Action = left, !.
*/

ethan( (X1,Y1),  result(Action, State) ) :-
  %Start = s0,
  d2(X,Y,X1,Y1, Action ),
  %Action \== Ran ,
  Action = right,
  ethan((X,Y), State).
/*  
  ethan((X,Y), State),
  d(X,Y,X1,Y1, right ),
  Action = right, !.
*/