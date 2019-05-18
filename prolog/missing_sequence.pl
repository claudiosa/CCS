

main :- miss_TERMS([5,7,9,11,15],X), 
        format('\n Terms missing are: ~w ', [X]),
        miss_TERMS([1,4,7,13,16],Y), 
        format('\n Terms missing are: ~w ', [Y]),
        !.

%% or use it
w_lst([]).
w_lst([X|L]) :- nl, write(' ==> '), 
                write(X), 
                w_lst(L).

%%%
miss_TERMS(Linp,Diff_L) :-
   sort(Linp,[A|B]), %%% sort if not
   last([A|B],Last), %% get the last item
   length([A|B],Size), %% get the length
   R is ceiling(((Last - A)/Size)), %% get the reason
   
   generate(A, Last, R, True_List), %% generate a True List
   lists_diff(True_List, [A|B], Diff_L). %% R the differente
   %% |True_List| >= |[A|B]|
   

%% generate a list A to B with reason R
generate(X, X, _ , [X]). 
generate(X, Y, R , [X]) :-  (X+R) > Y.
generate(X, Last, R, [X|B]) :-
    A is X + R,
    generate(A , Last, R,B).


%% L1 - L2 
%%
%%lists_diff([a,b], [b], X). 
lists_diff([], _, []).
lists_diff([H|T], S, T_new) :- 
        member(H, S), 
        lists_diff(T, S, T_new).
lists_diff([H|T], S, [H|T_new]) :- 
        lists_diff(T, S, T_new).

/*
Running in swipl 
?- main.

 Terms missing are: [13] 
 Terms missing are: [10] 
true.

?- 
*/

