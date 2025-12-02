% ---------------------------------------------
% factorial.pl — Simple factorial definition
% ---------------------------------------------

% Base case
fact(0, 1) :- !.

% Recursive case
fact(N, R) :-
    N > 0,
    N1 is N - 1,
    fact(N1, R1),
    R is N * R1.

% A simple entry point: prints "Result = VALUE"
run_fact(N) :-
    fact(N, R),
    write(R).  %%%% print something...
    %format("Result=~w~n", [R]).
