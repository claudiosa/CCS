
:- lib(ic).
:- lib(branch_and_bound).
%%%:- lib(lists).

model(SizeWindow, Vs, Xs, Total) :-
    length(Vs, N),
    dim(Xs, [N]),
    Xs :: 0..1,
    [Begin, End] :: 1..N,
    End - Begin #= SizeWindow-1,
    ( foreacharg(Xi, Xs, I), param(Begin, End) do
        Yes #= (I #>= Begin and I #=< End),
        #=(Xi, 1, Yes) 
    ),
    %% array_list(Xs, Xslist),
    flatten_array(Xs, Xslist),
    Total #= Vs * Xslist.

find(Xs, Total) :-
    Cost #= -Total,
    minimize(search(Xs, 0, first_fail, indomain, complete, []), Cost).

go :-
    Vs = [60, 60, 60, 25, 30, 47, 65, 55, 71, 95],
    model(5, Vs, Xs, Total),
    find(Xs, Total),
    writeln([Xs, Total]).
