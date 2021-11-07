%sum(0,0).
%sum(N+1, S):- sum(N,S).

w(1, 7).
w(2, 7).
w(3, 7).
c(N) :- N = #count{I,W :  w(I,W)}.
s(S) :- c(N), S = #sum{W : I = 1..N, w(I,W)}.

%t(S) :- S= #sum{X+X : X = 0..4}.
#show s/1.
#show c/1.