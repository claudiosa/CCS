%%clingo 04_lesson.lp -c n=2 0
%%% n=2 .
{ p(1 .. n) }.

%%% print this contents -- true
%#show aux/0.
#show p/1.
