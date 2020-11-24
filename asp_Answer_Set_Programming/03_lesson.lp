%%clingo 03_lesson.lp 0

%%%%2 {p(1 .. 4)} 3. ==> try it
%%%%4 {p(1 .. 4)} 3. ==>  try it

3 {p(1 .. 4)} 3.

aux:- p(X), X < 3.
%:-  p(X), X < 3.

%%% the constraint
%:- not p(2).

%%% print this contents -- true
%#show aux/0.
%#show p/1.
