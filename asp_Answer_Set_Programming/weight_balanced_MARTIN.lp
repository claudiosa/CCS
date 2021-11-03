% Remap weight occurrences to consecutive indexes from 1

index(I,W,K) :- weights(I,W), K = #count{J : weights(J,W), J <= I}.
index(W,K)   :- index(I,W,K).

% Count the occurrences per weight and in total

count(W,K) :- index(W,K), not index(W,K+1).
count(N)   :- N = #sum+{K,W : count(W,K)}.

% Choose the heavier (greater sum of weights) partition

N/2 {heavy(W,K) : index(W,K)} (N+1)/2 :- count(N).
:- heavy(W,K), 1 < K, not heavy(W,K-1).

% Check that chosen weights form the greater or equal partition

:- 1 #sum{W,K : index(W,K), not heavy(W,K); -W,K : heavy(W,K)}.

% Minimize the sum of weights for the heavier partition

#minimize{W,K : heavy(W,K)}.

% Output partitions in terms of respective weight occurrences

#show.
#show sol(a,I,W) : index(I,W,K), heavy(W,K).
#show sol(b,I,W) : index(I,W,K), not heavy(W,K).