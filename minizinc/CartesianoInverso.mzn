include "alldifferent.mzn";
int: n=4;
int: m=5;
int: o= 20;
var int: count = 1;
array[1..n] of var int: a;
array[1..m] of var int: b;
array[1..o,1..2] of var int: c;
a = [-5,-3,2,5];%
b = [0,-5,10,8,3];% 

predicate tuplediff(array[1..o,1..2] of var int: c) = forall(i in 1..o)(forall(j in i+1..o)(c[i,1] != c[j,1] \/ c[i,2] != c[j,2]));

predicate cartesian(array[1..4] of var int: a,array[1..5] of var int: b,array[1..25,1..2] of var int: c,int: sizea,int: sizeb,int: sizec) = forall(i in 1..sizec)(exists(j in 1..sizea)(c[i,2]=a[j]) /\ exists(k in 1..sizeb)(c[i,1]=b[k]));

constraint tuplediff(c);
constraint forall(i in 1..o)(c[i,1] > -6 /\ c[i,1] < 11 /\ c[i,2] > -6 /\ c[i,2] < 11);
constraint cartesian(a,b,c,n,m,o);

solve satisfy;

output[show(c)];



