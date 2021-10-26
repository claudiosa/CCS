weights(5;3;4;6;5). 


size(N) :-  N = #count{W: weights(W)}.
 
% Display
%#show weights/1.
#show size/1.
