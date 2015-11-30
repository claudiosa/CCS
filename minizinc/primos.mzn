include "alldifferent.mzn";
int: n;
array[1..n] of var int: primos; 
constraint alldifferent(primos);
constraint primos[1] = 2;
constraint forall(i in 2..n)
  (primos[i] > 1 /\
   primos[i] > primos[i-1] /\ 
  forall(j in 2..i-1)
    (primos[i] mod j != 0));

solve satisfy;

output[show(primos)];