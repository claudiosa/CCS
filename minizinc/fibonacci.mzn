int: n;
array[1..n] of var int: fib;

constraint forall(i in 1..n)(
(fib[i]=fib[i-1]+fib[i-2] /\ i >= 2) \/
(i==1 /\ fib[i]=1)\/
(i==2 /\ fib[i]=1) 
);

solve satisfy;

output[show(fib)];