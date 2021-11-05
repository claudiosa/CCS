%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% instance
%w(11, 9).
%w(12, 9).
%w(13, 9).
%% OR
w(11 .. 13 , 9).

% getting some sets from w
1 { some_W(Index,P) } 3 :- w(Index, P).
% sum the SECOND argument of  some_W(I,W)
total(S) :- S = #sum{ W,I : some_W(I,W) }.
%total(S) :- S = #sum{ I,W : some_W(I,W) }.  %%%% FULLY DIFFERENT
%%% a constraint
:- total(S), S <= 0.
% a maxmization
#maximize{S : total(S) , S > 0}.
#show total/1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
