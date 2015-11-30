int: n =6;
int: m =6; 
array[1..n] of int : x;
array[1..m] of int : y;
array[1..n,1..2] of var int: usa;
x = [1, 2, 3, 4, 5, 6];
y = [1, 2, 3, 4, 5, 6];

predicate usa(int: y,int: x) = exists(i in 1..n)(usa[i,1]==y /\ usa[i,2] == x);

predicate tuplediff(array[1..n,1..2] of var int: c) = forall(i in 1..n)(forall(j in i+1..n)(c[i,1] != c[j,1] \/ c[i,2] != c[j,2]));

%predicate DuasPessoasPorPc(array[1..n,1..2] of var int: c) = forall(i in 1..n)();

constraint forall(i in 1..n)(usa[i,1] > 0 /\ usa[i,1] < 7 /\ usa[i,2] > 0 /\ usa[i,2] < 7);

constraint tuplediff(usa);

constraint 
 exists(i in 1..n)(
  forall  (j  in 1..m )( 
   (not usa(j,i))
   )
   );

solve satisfy;

output[show(usa)];