
int: n=10;
int: m=5;

var set of 1 .. n : var_SET ;

constraint
 % forall(i in 1 .. m)
%  (
   var_SET > 5;

solve satisfy;

output[show(card(var_SET))];



