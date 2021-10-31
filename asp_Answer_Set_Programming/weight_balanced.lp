% Problem:
% Input: a vector with many values, maybe, some them are repeated. Ex: {5 ;3 ;4 ;6 ;8 ;-9999 ;9 ; 9; 9; 9 }
% Description: how to divide this vector in two others, with the following constraints
%  a) |Size_Vector_1 - Size_Vector_2| =< 1 ... 
%  b) |Size_Vector_1 | +  |Size_Vector_2| = |Size_of_Input|
%  c) Minimization of the sum difference  between both vectors.
%      MIN ( |sum of elements of V1 - sum of elements of V2| )
%  a "swing" or "balance" problem
% From ACM contest programming

%%% INPUT DATA
weights(1,99 ; 2,3 ; 3,4 ; 4,99
        ; 5,8 ; 6,8 ; 7,-9999 
        ;8,9 ; 9,9 ; 10,9; 11,9 ). 

#const n=11.

% creating sets 01 and 02
 { set_01(I,W) : weights(I,W) }  :-  weights(I,W).
 { set_02(I,W) : weights(I,W) }  :-  weights(I,W).

%%% the sets are disjunctives
:- set_01(I,_), I = 1..n, set_02(J,_), J = 1..n, I == J.
%% any set has the same element referenced by an index

%% counting elements of sets 01 and 02 by index
n_1(N) :- N = #count{I: set_01(I,W) }.
n_2(N) :- N = #count{I: set_02(I,W) }.
size(N) :- N = #count{I: weights(I,W)}.

%% summing all elements of sets 01 and 02
sum_1(X) :- X = #sum{W: set_01(I,W)}.
sum_2(X) :- X = #sum{W: set_02(I,W)}.

% 
% constraint 1 ... sum of size sets are the same
:- n_1(X), n_2(Y) , size(N) , (X+Y) != N.

%:- n_1(X), n_2(Y) , X - Y = Z  ; Z > 1; Z < -1. --- TO STUDY it
% constraint 2 ... set 1 and 2 .. are almost the same size
:- n_1(X), n_2(Y) , X - Y > 1 .  % not allowed  IF |X|  > |Y|  
:- n_1(X), n_2(Y) , Y - X > 1.   % not allowed  IF |Y|  > |X|


%% an interval
allowed(-1; 0; 1).
%allowed(Z) :- n_1(X), n_2(Y) ,  Z == |Y - X| .
%% does not works 
% constraint 
%:- n_1(X), n_2(Y) , allowed(Z),  (X - Y) != Z . 

%% optimization function
%% the abs works fine
dif(Z) :- sum_1(X), sum_2(Y),   Z = |Y - X|. %% #abs(Y-X).

%% A minimizations on this set difference
#minimize{ Z : dif(Z) }.

% Display - OUTPUTS ....
#show weights/2.
#show n_1/1. 
#show n_2/1.
#show size/1.

%% sets obtained
#show set_01/2. 
#show set_02/2.

%% sum of each side 
#show sum_1/1.
#show sum_2/1.
%##############################################################
