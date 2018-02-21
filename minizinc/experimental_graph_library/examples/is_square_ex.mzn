include "../lib/graphs.mzn";
%% by CCS -- self-explicative

int : N;
array[1..N, 1..N] of int: adj_mat;
var bool : x;


constraint 
    x =  is_adj_matrix_square_FUNCTION(adj_mat) ;


solve satisfy;

%show(x)
output[  " About this entry"  ++ "\t"  ]
 ++
   [ 
     if (fix(x) == true)
   then 
    " SQUARED"
  else
    " NOT SQUARED"
  endif
  ];
  

