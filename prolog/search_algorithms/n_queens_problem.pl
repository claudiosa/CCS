/*
 *------------------------------------------------------------------------
 *			    	N-queen problem
 *
 * The problem is to position n queens on a n-by-n chessboard such
 * that no queen beats the others
 *
 * Obviously there can be no more than one queen on any row of the board.
 * If we have n queens and a n-by-n chessboard, each row of the board
 * will have exactly one queen. Therefore, we can describe a board position
 * by listing only column positions of the corresponding queens. For example,
 * a list [c1 c2 c3 c4 c5 ... cn] of n numbers tells that
 * the first queen is on row 1 and column c1, the second queen stands
 * at the intersection of the 2nd row and the c2-th column, etc.
 *
 * Since no two queens can safely stand on the same column, all numbers
 * in the list [c1 ... cn] are different. Thus we can re-formulate the
 * problem as finding such a permutation from a list [1 2 3 ... n] which
 * describes a safe position of n queens.
 *
 * The present program is a prolog interpretation of the corresponding
 * E-lisp program, see "~/langs/lisp/QueensProblem.el"
 *
 *------------------------------------------------------------------------
 */


/*
 *------------------------------------------------------------------------
 * The following predicate checks to see if a position is safe.
 * The position is safe if the first queen does not beat the others,
 * and the position of the other queens is also safe.
 * As the representation of board positions guarantees that no
 * two queens share the same row or column, we only need to check
 * diagonals to make sure a position is safe.
 * Queen (i,ci) can beat queen (j,cj)
 * only if i-j = ci-cj, or i-j = cj-ci (assuming that i>j).
 * In other words, if the row distance between the queens is d,
 * they peacefully coexist if neither cj-ci = d, nor ci-cj = d.
 */
				% Check to see if a queen located
				% on column col and 'row-dist' rows 
				% above the first queen in the list
				% L beats someone in the list
queen_doesnt_hit(_,_,[]) :- !.
queen_doesnt_hit(Col,Row_dist,[A_queen_col|Other_queens]) :- !,
		Diag_hit_col1 is Col + Row_dist, A_queen_col =\= Diag_hit_col1,
		Diag_hit_col2 is Col - Row_dist, A_queen_col =\= Diag_hit_col2,
		Row_dist1 is Row_dist + 1,
		queen_doesnt_hit(Col,Row_dist1,Other_queens).
	

safe_position([_]) :- !.	% A single queen position is always safe
safe_position([A_queen|Other_queens]) :- !,
	queen_doesnt_hit(A_queen,1,Other_queens),
	safe_position(Other_queens).

% Check the safe_position predicate...
?-safe_position([1, 2]).
?-safe_position([1, 3, 5]).
?-safe_position([2, 4, 1, 3]).

/*
 *------------------------------------------------------------------------
 * The following function searches for a safe layout. 
 * It produces a permutation of a given list and checks to see if it
 * corresponds to a safe position.
 *
 */

do_insert(X,Y,[X|Y]).
do_insert(X,[Y1|Y2],[Y1|Z]) :- do_insert(X,Y2,Z).

permute([X],[X]).
permute([X|Y],Z) :- permute(Y,Z1), do_insert(X,Z1,Z).


safe_layout(Layout,Layout1) :-
	permute(Layout,Layout1), safe_position(Layout1).

safe_layout_all(Layout) :- 
 nl,nl,print('Solving an n-queen problem with n='),
 length(Layout,N), print(N), nl,
	safe_layout(Layout,Layout1),
	print(Layout1),nl,
	fail.
safe_layout_all(_).

% A 2-queen problem has no solutions
?-safe_layout_all([1,2]).

% A 3-queen problem has no solutions
?-safe_layout_all([1,2,3]).

% A 4-queen problem has two solutions: [3,1,4,2] and [2,4,1,3]
?-safe_layout_all([1,2,3,4]).

% A 5-queen problem has ten solutions; the following
% predicates tells them all
?-safe_layout_all([1,2,3,4,5]).

?-safe_layout_all([1,2,3,4,5,6]).

?-safe_layout_all([1,2,3,4,5,6,7]).

?-safe_layout_all([1,2,3,4,5,6,7,8]).
