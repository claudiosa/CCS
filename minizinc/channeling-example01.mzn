include "globals.mzn"; 

int: m = 10;
var 1..pow(10,m)-1: n;

array[1..m] of var 0..9: x;


% n = to_num_base(a, base)
function var int: to_num_base(array[int] of var int: a, int: base) =
          let { int: len = card(index_set(a));
                var int: n = sum(i in index_set(a)) (
                   pow(base, len-i) * a[i] 
                 );
         } in n
;

% base 10
function var int: to_num(array[int] of var int: a) = to_num_base(a, 10);


solve satisfy;
% solve :: int_search(x, first_fail, indomain_min, complete) satisfy;

constraint
   n = to_num(x)
;

output [
  "x: ", show(x), "\n",
  "n: ", show(n), "\n"
];