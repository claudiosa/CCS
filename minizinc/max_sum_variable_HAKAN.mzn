
% 
%  2. I skipped var_reify and replaced it with % 
%       (Begin <= j /\ End >= j) <-> x[j]  = 1
%
%  3. The if then else should be used only when dealing with
%     parameter (i.e. not decision variables).
%     The if/then/else are replaced with
%       -> 
%     and
%       <-> (equivalence)
%
%  4. I skipped the last constraint since it forced the 
%     subsequence to of length 2 or longer.
% 
%  5. Also, rearranged the model a little and added 
%     some problem instances from
%     http://rosettacode.org/wiki/Greatest_subsequential_sum
%


%% the largest sum in a sub-sequence contiguous
int: n;
% n = 5;

var 1..n : size_window; %%% a window with a max size
var 1..n :  Begin;
var 1..n :  End;
% var bool : var_reify; % hakank: skipped

array[1..n] of var 0..1 : x_decision;
array[1..n] of int : vector;

var int: total_SUM = sum( i in 1..n ) ( x_decision[i]  *  vector[i] );

%
% exacly one  SUM has fixed size then ...
%
constraint 
   sum(j in 1..n) (x_decision[j]) = size_window
;

constraint
   (End >= Begin ) /\
   (End - Begin = size_window -  1)
;


% hakank: skipped since var_reify is not needed
% constraint
%    forall(j  in 1..n ) (
%      if (Begin <= j /\ End >= j) then var_reify = 1 else var_reify = 0
%      endif
%    )
% ;

% hakak: rewritten using <-> instead
% constraint
%    forall  (j  in 1..n ) (
%       if var_reify
%          %% OR (Begin <= j /\ End >= j)
%        then
%         x_decision[j]  = 1
%         else
%       x_decision[j]  = 0
%        endif
%    )      
% ;
constraint
   forall(j  in 1..n ) (
      (Begin <= j /\ End >= j) <-> x_decision[j]  = 1
   )      
;

% hakank: Skipped since it forces the sequence to be at least two numbers.
% constraint
%    forall(j in 1..n) (
%       (x_decision[j]  == 1 )
%       ->
%       ( x_decision[j+1] == 1 \/ x_decision[j-1] ==1 )
%    )
% ;


% minimize total_cost
solve maximize total_SUM;

output [
  "Total_SUM: " ++ show(total_SUM) ++"\n"++
  "Size_window : " ++ show(size_window ) ++"\n"++
  "vector: " ++ show( vector ) ++ "\n" ++
  "x_decision: " ++ show( x_decision ) ++ "\n" ++ 
  "Begin: " ++ show(Begin) ++ "\n" ++
  "End: " ++ show(End) ++ "\n" ++
  "sequence: " ++ show([vector[i] | i in 1..n where fix(x_decision[i]) =1 ]) ++ "\n"
]
;


%
% data
%

%% sum = 163, x_decision = [1,1,1,1,1]
% n = 5;
% vector = [144,  5, -8,  7, 15];

%% sum=144, x_decision = [1,0,0,0,0]
%n = 5;
%vector = [144,  -145, -8,  7, 15];

%% sum = 22,  x_decision = [0,0,0,1,1]
% n = 5;
% vector = [-144,  5, -8,  7, 15];

% some examples from http://rosettacode.org/wiki/Greatest_subsequential_sum

%% sum = 15, x_decision: [0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0]
% n = 11;
% vector=[-1,-2,3,5,6,-2,-1,4,-4,2,-1];

%% sum = 3, x_decision = [0,0,1]
% n = 3;
% vector = [-1,-2, 3];

%% sum = 19, x_decision: [0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0]
% n = 15;
% vector = [7,-6,-8,5,-2,-6,7,4,8,-9,-3,2,6,-4,-6];

%% sum = 4, x_decision = [1]
% n = 1;
% vector = [4];
