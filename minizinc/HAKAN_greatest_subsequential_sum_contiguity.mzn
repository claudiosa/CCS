% 
% Greatest subsequential sum (Rosetta Code) in MiniZinc.
% 
% http://rosettacode.org/wiki/Greatest_subsequential_sum
% """
% Given a sequence of integers, find a continuous subsequence which maximizes 
% the sum of its elements, that is, the elements of no other single subsequence 
% add up to a value larger than this one. An empty subsequence is considered to have 
% the sum 0; thus if all elements are negative, the result must be the empty sequence.
% """

%
% Note: This model is a variant of greatest_subsequential_sum.mzn
% but use the regular variant of the global constraint global contiguity.
%

% 
% This MiniZinc model was created by Hakan Kjellerstrand, hakank@gmail.com
% See also my MiniZinc page: http://www.hakank.org/minizinc/
%

include "globals.mzn"; 


%% the largest sum in a sub-sequence contiguous

int: n;
array[1..n] of int : vector;

% decision variables
% var 1..n : size_window; %%% a window with a max size
% var 1..n : Begin;
% var 1..n : End;

array[1..n] of var 0..1 : x;
var int: total_sum = sum( i in 1..n ) ( x[i]  *  vector[i] );

solve maximize total_sum;

predicate contiguity(array[int] of var int: a) =
  let {
        int: n_states = 3,
        int: input_max = 2,
        int: initial_state = 1,
        set of int: accepting_states = {1,2,3},
        % the transition matrix
        array[1..n_states, 1..input_max] of int: transition_fn =
    array2d(1..n_states, 1..input_max,
    [ 
      % note:all states are accepting states
      1,2, % state 1 (start): input 0 -> state 1, input 1 -> state 2 i.e. 0*
      3,2, % state 2: 1* 
      3,0, % state 3: 0* 
    ]),
      int: len = length(a),
      % note: regular cannot handle 0 values, it must be > 0
      array[1..len] of var 1..2: reg_input
  } in
   forall(i in 1..len) (
     reg_input[i] = a[i] + 1
   )
   /\
   regular(reg_input, n_states, input_max, transition_fn,
                    initial_state, accepting_states)
;


% this is the only constraint we need
constraint contiguity(x);

output [
  "Total_sum: " ++ show(total_sum) ++"\n"++
  "vector: " ++ show( vector ) ++ "\n" ++
  "x: " ++ show( x ) ++ "\n" ++ 
  "sequence: " ++ show([vector[i] | i in 1..n where fix(x[i]) =1 ]) ++ "\n"
]
;


%
% data
%

%% sum = 163, x = [1,1,1,1,1]
% n = 5;
% vector = [144,  5, -8,  7, 15];

%% sum = 144, x = [1,0,0,0,0]
% n = 5;
% vector = [144,  -145, -8,  7, 15];

%% sum = 22,  x = [0,0,0,1,1]
% n = 5;
% vector = [-144,  5, -8,  7, 15];

% some examples from http://rosettacode.org/wiki/Greatest_subsequential_sum

%% sum = 15, x: [0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0]
n = 11;
vector=[-1,-2,3,5,6,-2,-1,4,-4,2,-1];

%% sum = 3, x = [0,0,1]
% n = 3;
% vector = [-1,-2, 3];

%% sum = 19, x: [0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0]
% n = 15;
% vector = [7,-6,-8,5,-2,-6,7,4,8,-9,-3,2,6,-4,-6];

%% sum = 4, x = [1]
% n = 1;
% vector = [4];

