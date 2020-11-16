node(1..4).

% instance
color(red).
color(green).
color(yellow).

%%%%#teste = {a,b,c}.

% OK -- coloring(N,X) :- color(X), node(N).
% encoding
1{ coloring(X, green) ; coloring(X, red) ; coloring(X, yellow) } 3 :- node(X).
%%%1{ coloring(X1, green) ; coloring(X2, red) ; coloring(X3, yellow) } 3 :- 
 %%%   (X1 != X2) ,   (X1 != X3)  .
coloring(N,X) :- color(X), node(N).

% {coloring(X, green), coloring(X, red), coloring(X, yellow)} :- node(X).
% l {a 1 , . . . , a m } u :- a m+1 , . . . , a n , not a n+1 , . . . , not a k .
% forcing the subset size to be within the lower bound l and upper bound u.1