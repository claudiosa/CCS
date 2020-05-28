%%% the greatesth
maior( [] ,0) :- !.
maior( [M] , M ) :- !.
maior( [M , K], M ) :- M >= K , !.
maior( [M|R] ,N ) :- maior( R , K ) ,
                      maior( [K , M] , N).

/*   UNION ...  L1, L2, Lretorno --- append */ 
uniao([],X,X) :- !.
uniao(X,[],X) :- !.
uniao([X|L1],L2,[X|L3]) :- uniao( L1, L2, L3).


comp([], 0) :- !.
comp([_ | L], N) :- 
                    comp(L, N1),
                    N is (N1+1).


/*  marka( In, Elem, X, Out) iff input list In will change to output list Out
    marked with an X after Elem.
    Fails if In does not contain Elem.
*/
marka( [Elem|T], Elem, X, [Elem,X|T] ).
marka( [H|T], Elem, X, [H|T1] ) :-
    marka( T, Elem, X, T1 ).


/*  normal( In, Out) iff Out is the flattened version of In: i.e.
    [ [a], [b,c], [[d],e] ] => [a,b,c,d,e] .
    In must be instantiated.
*/
normal( In, Out ) :-
    normal( In, [], Out ).
normal( [], L, L ).
normal( A, L, [A|L] ) :-
    var( A ), !.

normal( A, L, [A|L] ) :-
   not( islist(A) ), !.

normal( [H|T], Sofar, Result ) :-
    normal( T, Sofar, Sofar1 ),
    normal( H, Sofar1, Result ), !.


/*  doubl( In, Out) iff Out is the same as In after replacing two adjacent
    occurrences
    of any element by one occurrence of that element.
*/
doubl( [], [])  :- !.

doubl( [ Elem, Elem| X], [ Elem| Y]) :-
   doubl( X, Y).

doubl( [ X| R1], [ X| R2]) :-
   doubl( R1, R2).


/*  Aux. predicates taken from NBS/ICST Prolog Utility Library vers 11.25.86
    member_rest( Elem, List, Rest) iff Elem is a member
    of List and Rest is the rest of the list following Elem.
*/
member_rest( Elem, [ Elem| Rest], Rest)  :- !.

member_rest( Elem, [ _| Rest], Rest_rest) :-
   member_rest( Elem, Rest, Rest_rest).


/*  sublist(List, Start, End, Sublist) iff Sublist is a contiguous
    sub-list within List, starting at position Start, and ending at
    position End.
    [] is a valid sublist of any list.
    At least one of List and Sublist must be instantiated.          
*/
sublist(List, 1, End, Sublist) :-
  prefix(Sublist, List),
  length(Sublist, End).

sublist([_ | Rest], Start, End, Sublist) :-
  sublist(Rest, Startx, Endx, Sublist),
  Start is Startx + 1,
  End is Endx + 1.


/*  prefix( Part, Whole ) iff Part is a leading sub-list of Whole.
    If Part is uninstantiated and Whole instantiated, 'prefix' generates
    a new prefix into Part on each resatisfaction, starting with [].
    At least one of Part and Whole must be instantiated.
*/
prefix([], _)  :- !.

prefix([Elem|Reso],[Elem|Resto]) :-
   prefix(Reso,Resto).


/*  position(List, Elem, Number) iff Elem is in position Number
    in the List.  List must be instantiated, as must at least one of
    Elem and Number.
*/

position([ Elem | _ ], Elem, 1 ) :- !.
position([ _ | Rest ], Elem, Number ) :-
    var(Number),
    !,
    position(Rest, Elem, N_minus),
    Number is N_minus + 1.

position([ _ | Rest ], Elem, Number ) :-
    N_minus is Number - 1,
    position(Rest, Elem, N_minus).

%%% value_from_index(i,i,?)
value_from_index(Number , _ , _ ) :-
    Number =< 0 ,
    format("\n Negative INDEX"), !.

value_from_index( 1, [ Elem | _ ], Elem ) :- !.

value_from_index(Number, [ _ | Rest ], Elem ) :-
    N_minus is (Number - 1),
    value_from_index(N_minus, Rest, Elem).

/*
    Check if a list form a circuit - True or False
    delete([3,4,5],5,X)
    ?- circuit([3,1,2]).
    true.

    ?- circuit([4,1,2,3]).
    true.
 
*/
 %%% verifiy if the list is a circuit
circuit(X) :- 
    indexes_DIFF_values(X),
    is_a_circuit( X ,X ) .

%%% NONE VALUE can be pointing for itself
indexes_DIFF_values(L_X) :- 
    length(L_X , N), %% 
%   N > 1,
    reverse(L_X , L_Y),
    diff_value_index(N,L_Y).

%ndexes_DIFF_values(_) :- false.
%%
%% circuit([4,3,2,1]).
%% check if the indexes differs of its own value
diff_value_index(0,[]) :- !.
diff_value_index(1,[1]) :- !.    
diff_value_index(N, [ A | L ] ) :-
    N \== A, %%% none index can be point to itself
    N_minus is (N-1),
    diff_value_index( N_minus, L ).

%%% check if it is a circuit - true or false
is_a_circuit([1], _) :- !.
is_a_circuit([1|L], _) :- nonvar(L), !, false.
is_a_circuit([A|L1], Ancor) :-
    value_from_index(A, Ancor, B) ,
    delete(L1,B,L2) ,
    %(B \== 1 , L2 \==[] ), %% if B==1 ... it must be the last
    is_a_circuit([B|L2] , Ancor).

all_permutations(X, L) :- findall(Y, permutation(X,Y), L).
/*
?- findall(X, permutation([1,2,3],X)  , L).
L = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]].
*/
%%% generator of circuits with size N
gen_circuits(N, L):- 
    make_A_list(N, X),
    all_permutations(X, L_per),
    circuit_filter(L_per, L).
 /*
 ?- gen_circuits(3, L), write(L).
[[3,1,2],[2,3,1]]
L = [[3, 1, 2], [2, 3, 1]].
*/


%%%% filter from L ... only lists that are circuits
circuit_filter([], []) :- !.
circuit_filter([C |L1], [C|L2]) :-
    circuit(C),
    circuit_filter(L1,L2), 
    !.

%% C is not a circuit in L
circuit_filter([ _ |L1], L2) :-
      circuit_filter(L1,L2).

%%% simple list [N, ..., 1]
make_A_list(0,[]) :-!.
make_A_list(N, [N|L]):-
    N_minus is (N-1),
    make_A_list(N_minus, L).

/*
    islist(List) iff List is a List. (Really just checks for [] and
    that the main functor is '.')
*/
islist( [] ) :- !.
islist( [_|_] ).


/* Permutacao de elementos */

permutar([], []) :- !. /* Condicao de parada*/
permutar([X|L], Lpermutada):-
  	permutar(L, L1), 
	exclui_1a(X, Lpermutada, L1).


/* Exclui  X apenas em sua primeira ocorrencia */
exclui_1a(X, [X|L], L)  :- !.
exclui_1a(X, [Y|L], [Y|L1]):- exclui_1a(X, L, L1).

/* executando */
init :- permutar([5,7,9],X), nl , write(X), fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% all X in L
del_X_all( _ , [],[]) :- !.
del_X_all(X, [X|L], L1) :- del_X_all(X,L,L1).
del_X_all(X, [Y|L1], [Y|L2]) :- del_X_all(X,L1,L2).

%!  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AUX by CCS
my_sort_UP( [] , []) :- !.
my_sort_UP(L1, [ X | D]) :-
    max_list(L1 , X ),
    my_delete(L1 , X, L2),
    my_sort_UP(L2 , D ).


%  remove ONLY ONE X ... not all
my_delete( [A], A , [] ) :- !.
my_delete([A|B], A, B) :- !. %%% Return at the firs occurrence
my_delete([A|B], X, [A|C]) :-
    A \== X,
    my_delete(B, X, C).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
