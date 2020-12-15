p(1..4).
q(1..4).

1{ q(X) : X=1..2} :- p(Y).
1{ p(X) : X=3..4} :- q(Y).

%2{p(X) : X = 1..2 } :- p(Y).

%1{p(X) : X=1..2}  :- p(Y).

%2{ q(X) : X=10..11} :- p(Y).
%% 1{ q(X) : X=10..11} :- p(Y). %%% not upper limit
%1{ q(X) : X=10..11} 1:- p(Y). %% limited 1 and 1 for q(X)
%%% this number ... means how many are allowed in this set 
