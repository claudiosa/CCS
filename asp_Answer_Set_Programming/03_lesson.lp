%%clingo 03_lesson.lp 0

{p(1) ; p(2) ; p(3) ; p(4)}. %%% MESMO SET
3 {p(1 .. 4)} 3.

%% NAO PODE TER X MAIOR QUE 3
:- p(X), X > 3.
%%:-  p(X), X < 3.   ===> UNSATISFIABLE

%%% INCLUA p(2) nas respostas
%:- not p(2).

%%% print this contents -- true
%#show p/1.
