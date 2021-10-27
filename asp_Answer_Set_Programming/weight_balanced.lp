%%% INPUT DATA
weights(5 ;3 ;4 ;6 ;8 ;-9999 ;9 ; 9; 9; 9 ). 


% creating sets 01 and 02
{ set_01(X) : weights(X) }   :-  weights(W).
{ set_02(X) : weights(X) }   :-  weights(W).




%% counting elements of sets 01 and 02
n_1(X) :- X = #count{W: set_01(W)}.
n_2(X):- X =  #count{W: set_02(W)}.
size(N) :-  N = #count{W: weights(W)}.

%% union of two sets
:- {set_01(E1) : E1 , set_02(E2) : E2 } != {weights(W):W}. 



%% summing all elements of sets 01 and 02
sum_1(X) :- X = #sum{W: set_01(W)}.
sum_2(X) :- X = #sum{W: set_02(W)}.




%% an interval
allowed(-1; 0; 1).
% allowed(0).
% 
% constraint 1
:- n_1(X), n_2(Y) , size(N) , (X+Y) != N.


%:- n_1(X), n_2(Y) , X - Y = Z  ; Z > 1; Z < -1. --- TO STUDY it
% constraint 2
:- n_1(X), n_2(Y) , X - Y > 1 .  % not allowed  IF |X|  > |Y|  
:- n_1(X), n_2(Y) , Y - X > 1.   % not allowed  IF |Y|  > |X|

% constraint 2
%:- s_1(X), s_2(Y) , allowed(Z),  (X - Y) != Z . 
%:- s_1(X), s_2(Y) ,  (X - Y) > 1 . 

%% optimization function
%dif(Z) :- sum_1(X), sum_2(Y), X >= Y,  Z = X-Y. %% OR
%dif(Z) :- sum_1(X), sum_2(Y), X  < Y,  Z = Y-X.

%% the abs works fine
dif(Z) :- sum_1(X), sum_2(Y),   Z = |Y - X|. %% #abs(Y-X).



%% A minimizations on this set difference
#minimize{ Z : dif(Z) }.

% Display
%#show weights/1.

#show n_1/1. 
#show n_2/1.
#show size/1.

%% sets obtained
#show set_01/1. 
#show set_02/1.

#show sum_1/1.
#show sum_2/1.
%##############################################################
