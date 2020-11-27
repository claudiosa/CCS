%%clingo 05_lesson.lp -c n=3 0

s(0,0).
s( N+1 , S + (N+1) ) :- s(N,S), N < n .

%% to think again
s2(0,0).
s2( N, S) :- s( (N-1) ,  (S - 1) ).

s2(S) :- s2(n,S).

s(S) :- s(n,S).
%%% print this contents -- true

%#show s/1.
#show S : n=3, s(n, S).
%#show s2/1.
