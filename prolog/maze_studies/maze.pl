% $ swipl -t main -q -f xxxxx
% $  swipl -t main -q -f maze.pl %%% to run directly in console
% the maze MUST have a exit (e) and (y)
% :- use_module(library(matrix)).
% :- use_module(library(ffimatrix)).
%% use_module(library(list_util)).
:- dynamic w/2.
:- dynamic start_point/2, end_point/2.
%  /usr/lib/swi-prolog/library this dir
:- use_module(library(lists), [reverse/2,flatten/2,nth0/3  ]).


clear_all :-
    retractall(w(_,_)),
	retractall(end_point(_,_)),
	retractall(start_point(_,_)),
	format("\n Data Base CLEANED ...\n").
    

main :- go.

go :-
    clear_all ,
    get_Maze(Maze, Rows, Cols),
	format("\n From INPUT file ...\n"),
	print_Map(Maze),
	num_Rows(Maze, Rows),
	num_Cols(Maze, Cols),
    format("\n SIZE: ~d: ~d", [Rows, Cols]),
	grid_Atom_Lists(Maze, Rows, L),
	nl,
	
	format("\n Work this INPUT file as a Matrix \n"),
	print_Map(L),
	%%%write(L),nl,
	do_edges(L, Rows),
	%findall( (X,Y), w(X,Y), L_arcs),
	%format("\n ARCS: ~w \n", [L_arcs]),
    bfs_sol(Solution),
	print_Sol_Maze(Solution, L)
	.
	
	%%%%%%%%%TESTS
    %%% Maze of atoms in List or true Matrix
	%%%grid_Atom_Lists( Maze, Rows, M_Maze ),
	%get_value_XY_M( 3, 18, M_Maze, Value ),
	%notrace ,
	%format("\n Value: ~w", [Value]),
	%put_value_XY_M( 2, 3, M_Maze, '*', M_output ),
	%print_Map(M_output)
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Matrix
%%% take a Value from a Matrix M (a list of lists) in X,Y
%%% 0 <=  X, Y < L1,C1  
% something like matrix_get(+M1,+Position,-Element)
get_value_XY_M( X, Y, M, Value ):-
     % num_Rows(M, L1),
	 num_Cols(M, C1),
	 flatten(M, List),
	 Index is C1*X + Y,
	 nth0(Index, List, Value).

%%% take a Value from a Matrix M (a list of lists) in X,Y
%%% 0 <=  X, Y < L1,C1  
% something like matrix_put(+M1,+Position,-Element)
put_value_XY_M( X, Y, M, Value, M_out ):-
     num_Rows(M, R1), %% original size of a LINE 
	 num_Cols(M, C1),
	 flatten(M, List),
	 Index is C1*X + Y,
	 replace_N_X(List, Index, Value, L_out),
	 %format("\n L_out: ~w", [L_out]),
	 do_matrix_from_list(L_out, R1 , M_out).
	 % format("\n M_out: ~w", [M_out]).

%%% MAZE like a matrix
print_Sol_Maze(Solution, Maze):-
  aux_print(Solution, Maze).
  
aux_print( [], M_out) :- 
     format("\n THE PATH in a Matrix: \n"),
	 print_Map(M_out),
	 format("\n THE PATH ... * sequence : \n"),
     print_Map_02(M_out),	 
	 format("\n THE END \n").
        
aux_print( [(X,Y)| L], M) :-
     put_value_XY_M( X, Y, M , '.', M_out ),
     aux_print( L , M_out). 	 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
%%% BUILD the CONNECTION of GRAPH from the MAZE

do_edges(L,N) :- build_edges( L, N, 0).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% H = [ of a line ]
build_edges( _ , N, N) :-!.
build_edges([] , N, N) :-!.
build_edges([H|L], N, Count) :-
   eval_line(H, Count, 0),
   New is (Count + 1),
   build_edges(L, N, New).

eval_line( [] , _, _) :-!.
eval_line([H|L], I, J) :-   
  (
   (
    (H == ' ', asserta(w(I,J)));
	(H == 'y', asserta(w(I,J)), asserta(start_point(I,J))) ; 
	(H == 'e', asserta(w(I,J)), asserta(end_point(I,J)))
	)
   ;
    true
   ),
   New is (J + 1),
   eval_line(L, I, New).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% GREAT IDEA 
d(X0,Y0,X,Y) :- next_w(X0,Y0,X,Y), w(X,Y).
%%% ONLY ALLOWED MOVEMENTS
next_w(X0,Y0,X0,Y) :- Y is Y0+1. %%% RIGHT 
next_w(X0,Y0,X,Y0) :- X is X0+1. %%% DOWN
next_w(X0,Y0,X0,Y) :- Y is Y0-1. %%% LEFT
next_w(X0,Y0,X,Y0) :- X is X0-1. %%% UP
%%% PERFORMANCE

bfs_sol(Solution) :-
          start_point(X0,Y0),
          %%%  NODE  OPEN CLOSE, SOL
          search_BREADTH_FS( [[ (X0,Y0) ]],  Path),
          %%% LIST OF LIST ... many possible paths will be explored
          reverse(Path, Solution),
          print(Solution),
          format("\n ==========================================================\n").

%%% KERNEL of SEARCH
search_BREADTH_FS([ [(X,Y)| BEST_Path] | _ ] , [(X,Y) | BEST_Path ] ):-
        end_point(X,Y),
        format("\n FOUND THE BEST SOLUTION\n"), 
        !. %% 

%%% CURR_NODE --- a sequence of nodes ... by level
%%% [ CURR_NODE  | L_CLOSED ] = [ [ path1 ],[ path2 ],[ ],[ ],[path-n ]]
search_BREADTH_FS( [ CURR_NODE  | L_CLOSED ], SOL ) :-
    
    expand_current_node(  CURR_NODE , Expanded_NODE ),
	%%% A queue here appended ... LISTS of LISTS ... many paths   
    append( L_CLOSED, Expanded_NODE, L_OPEN_NEW ),
	%% NEIGHBOURG NEW
	% format("\n CURR_NODE_L: ~w\t OPEN_NEW: \t ~w CLOSED: ~w \n", [ CURR_NODE , L_OPEN_NEW, L_CLOSED ]),
	% format("\n LISTS_of_LISTS_OPEN_NEW: ~w ", [ L_OPEN_NEW ]),
    search_BREADTH_FS( L_OPEN_NEW , SOL).
 %%% a list of list with all possible paths in this transversal tree by level


expand_current_node( [ (X0,Y0) | L_CLOSE ], L_Expanded) :-
  findall(
       [(X1,Y1), (X0,Y0) | L_CLOSE ],
     ( 
       d(X0,Y0, X1,Y1) , %%% conection or next movement
       not( member( (X1,Y1) , [ (X0,Y0) | L_CLOSE ]) )
      ),
      L_Expanded
    )
%    , 
%    %%%% ultima linha do findall 
%     format("\n [Xc,Yc]: [~w,~w]", [X0,Y0]),
%     format("==> Expanded :: ~w", [L_Expanded ] )
     , 
    
     !. 
     
%%% expande e adiciona TODOS NAO VISITADOS AINDA
expand_current_node(_,[]):- !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
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

%%%% READING FROM A FILE ... convert in line ... atoms etc
%%% a list of atom
get_Maze(Maze, Rows, Cols) :-
    File ="inp2.txt", %% change HERE 
    open(File , read, Str),
    read_file(Str , Maze),
    close(Str),
	%%% print_Map(Maze),
	num_Rows(Maze, Rows),
	num_Cols(Maze, Cols).
    %format("\n SIZE: ~d: ~d", [Rows, Cols]),
	%nl.

read_file(Stream,[]) :-
    at_end_of_stream(Stream),!.

%%% comes a list of atoms ... avoiding EOF
read_file(Stream, [C|L]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, X),
    atom_codes(C, X),
	format("\n read it: ~w", [C]),
    read_file(Stream , L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% It comes as List of lists
print_Map([]).
print_Map([C | L ]) :-
    % atom_length( C , Leng),
	% format("\n Line: ~w ~d", [C, Leng]),
    format("\n  ~w ", [C]),
    print_Map(L).

print_Map_02([]).
print_Map_02([H | L ]) :-
    atom_chars( Atom , H), %%% list to ATOM
    format("\n  ~w ", Atom),
    print_Map_02(L).
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% OK
%%% the count start in 1
num_Rows([], 0).
num_Rows( [ _ | L ] , N) :-
    num_Rows( L , N1 ),
	N is N1 + 1.

%% OK
%%% the count start in 1
num_Cols( [H|_] , X ) :-
    atom_length( H , X ).

%%% transform a atom sequence in a List o lists each 
%%% each small list is row of Matrix
%%% matrix in each line ... line by line size of Row
%% here Grid in list of list
grid_Atom_Lists(_, 0, []).
grid_Atom_Lists([M1|Maze], Rows, [H|L]) :-
    atom_chars(M1, H), %% an atom sequence in a list
    L_new is Rows - 1,
    grid_Atom_Lists(Maze, L_new, L). %% next line
%%% the inverse predicate ... see below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% build a matrix from a big list L
%%%% DO THE MATRIX from an unique list L
%%% do  N lists in L2
%% or each list in L2 is a row in the matrix M
do_matrix_from_list(L, N , M) :-
  	length(L , S),
  	Cols is floor(S/N), %%% think better for discard
	%%% the missing terms
    build_matrix_LISTS( L, S, Cols, M ).    
	
%?- do_matrix_from_list([+,-,+,-,-,-,+,-,-,-,a], 3, X).
%X = [[+, -, +], [-, -, -], [+, -, -], [-, a]].
	
%%%%%%%%%%%%%%% build a MATRIX from a big List....
build_matrix_LISTS( [], 0, _, []):- !.		
build_matrix_LISTS( [], _, _, []):- !.		
build_matrix_LISTS(L1, S, Cols, [L_H | L]) :-
    build_a_list_fixed(L1, Cols, L_H),
	delete_L(L1, Cols, L2),
	Snew is (S - Cols),
	build_matrix_LISTS(L2, Snew, Cols, L).


%%%%%%% a row of matrix
build_a_list_fixed( _ ,  0, [])  :- !.		
build_a_list_fixed( [] , _ , [])  :- !.		
build_a_list_fixed( [H|L1] ,  Cols, [H|L2]) :-	
    C_new is (Cols - 1),
	build_a_list_fixed(L1, C_new, L2).
%?- build_a_list_fixed([a,b,c,1,2,3], 3, X).
%X = [a, b, c].

%%%% remove N elements of L original ... result in L2
delete_L([] , _ , [])  :- !.		
delete_L(L, 0, L) :- !.	
delete_L([_|L1], N, L2) :-
    Rnew is (N - 1),
	delete_L(L1, Rnew, L2).
% ?- delete_L([-,-,-,1,2,3], 3, X).
% X = [1, 2, 3].


%% LIST PREDICATES
%%%% replace by X in the N_th position
replace_N_X([_|T], 0, X, [X|T]).
replace_N_X([H|T], I, X, [H|R]):- 
      I > -1, 
	  NI is I-1, 
	  replace_N_X(T, NI, X, R), !.
replace_N_X(L, _, _, L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
















