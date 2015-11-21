%%%3D MATCHING
%% SEE https://en.wikipedia.org/wiki/3-dimensional_matching
%% SEE the link
%% made by CCS

include "globals.mzn"; 

/*
USING ARRAYS
int: n = 5;
array[1..n, 1..n] of int: matrix = 
   array2d(1..n, 1..n,
    [
    2, 13, 16, 11, 23,
   15,  1,  9,  7, 10,
   14, 12, 21, 24,  8,
    3, 25, 22, 18,  4,
   20, 19,  6,  5, 17,
   ]);
*/

int : num_lines = 5;
int : n = 3; %% allways tuples in 3 elements

array[1 .. num_lines ,1..n] of var  int : my_set; 
%% THE RELATIONS on
%%          X Y Z    sets
%The set X is marked with red dots, Y is marked with blue dots, and Z is marked with green dots. 
my_set = [| 
            3, 5, 7      |
            9, 7, 9      | 
            3, 5, 77     | 
            3, 7, 9      |
            2, 9,  8     |];
%%% VERTICAL SETS and THEIR RELATIONS
int: K=2; %% K=2 or 3 ... K do 3D

%array[1..K , 1 .. n] of var int : x;
array[1..K , 1 .. n] of var int : Tuple_n;
 
%% NOT USED
var int : total;
constraint
  total = length(my_set);


%See the signatures it https://www.minizinc.org/downloads/doc-latest/mzn-globals.html
%   member(array[int] of var set of int: x, var set of int: y)

constraint
 forall(k_aux in 1..K , j in 1..n) (
   exists(i in 1..num_lines) (
     %   exists(j in 1 .. n) (
     %   member(my_set[i,K], Tuple_n[i,j] ) %/\
     %   Tuple_n[i,j] = array1d(x[i]);
     %   Tuple_n =  row( my_set , i)
     Tuple_n[k_aux,j] ==  my_set[i,j]
  )
 );


constraint
%%%alldifferent(array[int] of var set of int: x)
% forall(i in 1 .. (K-2) ) OR
if (K == 3) then
    forall(j in 1..n) (
     %% The constraints for 3D MATCHING
       (Tuple_n[1,j] !=  Tuple_n[2,j]) 
       /\
       (Tuple_n[1,j] !=  Tuple_n[3,j])
       /\
       (Tuple_n[2,j] !=  Tuple_n[3,j])
     )
 else  %%% OR
     forall(j in 1..n) (
     %% The constraints for 3D MATCHING
       (Tuple_n[1,j] !=  Tuple_n[2,j]) 
     ) 
  endif
;



/*
See the signatures it https://www.minizinc.org/downloads/doc-latest/mzn-globals.html
*/
%solve maximize total_sum;
solve satisfy;

output
[
  %"SET_TERMs: " ++ show(my_set) ++"\n" ++ show(total) ++"\n"
%  "\n Sequence1: " ++ show([Tuple_n[i] | i in 1..n ]) 
%  "\n Sequence2: " ++ show([Tuple_n[i,j] | i in 1..K, j in 1..n ]) 
%  "\n Sequence3: " ++ show([x[i] | i in 1..3 ])
] ++
[
  if j = 1 then "\n" else " " endif ++
    show_int(2, Tuple_n[i,j])
  | i in 1..K , j in 1..n
]

;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
K=2
 2  5  9
 3  7 77
----------

 9  5  9
 3  7 77
----------

 2  5  9
 9  7 77
----------

 3  5  9
 9  7 77
----------
*/