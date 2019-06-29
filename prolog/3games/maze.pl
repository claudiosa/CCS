%% $ swipl -t main -q -f xxxxx

% :-use_module(library(matrix)).
% :- use_module(library(matrix)).
:- dynamic w/2.
%%assertaasserta(+Term)(+Term)
%%:/usr/lib/swi-prolog/library this dir
:- use_module(library(lists), [reverse/2]).

main :- go.

go :-
    get_Maze(Maze, Lines, Cols),
	print_Map(Maze),
	num_Lines(Maze, Lines),
	num_Cols(Maze, Cols),
        format("\n SIZE: ~d: ~d", [Lines, Cols]),
	grid_Atom_Lists(Maze, Lines, L),
	nl,
	write(L),nl,
	print_Map(L),
	reverse(L,Lr),
	nl,
	writef("\n REVERSE\n"),
	write(Lr).


%% Matrix

%%free_spaces(M, L, R) :-

/*
free_spaces(_, _, -1) :- 
free_spaces(M, Lines, Cols) :-
   by_lines(M, Lines, Cols),
   Cols_New is Cols -1,
   free_spaces(M, Lines, Cols_News).
  
  by_lines(_, -1, _).
  by_lines(M, I, J) :-
    %% for all blanck space ==> w(I,J) ... this point
    %% is possible a connection
    ( M[I][J] == ' ',
     assert(w(I,J))
    );
    true,
    I_new is  (I - 1),
    g1(M, I_new, J).   
    
  

    %% for all blanck space ==> w(I,J) ... this point
    %% is possible a connection
    ( (M[I][J] == ' '; M[I][J] == 'y'; M[I][J] == 'e')
     assert(w(I,J)
    );
    true
    
   
   % assert(edge(I.J)


%%%% GREAT IDEA 
d(X0,Y0,X,Y) :- next_w(X0,Y0,X,Y), w(X,Y).
%%% ONLY ALLOWED MOVEMENTS
next_w(X0,Y0,X0,Y) :- Y is Y0+1. %%% RIGHT 
next_w(X0,Y0,X,Y0) :- X is X0+1. %%% DOWN
next_w(X0,Y0,X0,Y) :- Y is Y0-1. %%% LEFT
next_w(X0,Y0,X,Y0) :- X is X0-1. %%% UP
%%% PERFORMANCE


game :-
  % print board -- initial/end positions in the file
  % Run BFS ... get the best option
  %
  % you and AI
  % you move ... by arrows
  % read keyboad
  % valide ... 4 options -- arrows
  % validation in board
  % count steps
  % update board
  % print board 
  % do it while escape or end arrival point
  % score: BFS x you

*/




%%% a list of atom
get_Maze(Maze, Lines, Cols) :-
    File ="inp1.txt",
    open(File , read, Str),
    read_file(Str , Maze),
    close(Str),
	%%% print_Map(Maze),
	num_Lines(Maze, Lines),
	num_Cols(Maze, Cols).
    %format("\n SIZE: ~d: ~d", [Lines, Cols]),
	%nl.

read_file(Stream,[]) :-
    at_end_of_stream(Stream),!.

%%% comes a list of atoms ... avoiding EOF
read_file(Stream, [C|L]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, X),
    atom_codes(C, X),
	format("\n Line: ~w", [C]),
    read_file(Stream , L).

print_Map([]).
print_Map([C | L ]) :-
    % atom_length( C , Leng),
	% format("\n Line: ~w ~d", [C, Leng]),
    format("\n  ~w ", [C]),
    print_Map(L).

%% OK
num_Lines([],0).
num_Lines( [ _ | L ] , N) :-
        num_Lines( L , N1 ),
	N is N1 + 1.

%% OK
num_Cols( [H|_] , X ) :-
    atom_length( H , X ).

%%% transform a atom sequence in a List ..
%% here Grid in list of list
grid_Atom_Lists(_, 0, []).
grid_Atom_Lists([M1|Maze], Lines, [H|L]) :-
    atom_chars(M1, H), %% an atom sequence in a list
    L_new is Lines -1,
    grid_Atom_Lists(Maze, L_new, L).


/*

size_of_Map([H|L], X, Y) :-
     atom_length(H, X ),
	 atom_length([H|L], All),
	 Y is All / X ,
	 format("\n SIZE: ~d: ~d: ~d", [X,Y,All]).
*/













