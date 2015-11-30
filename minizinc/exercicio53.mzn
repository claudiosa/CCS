int: n;
array[1..6] of int: estudantes = [1,2,3,4,5,6];
array[1..2] of int: materiasy = [2,3];
array[1..2] of int: materiasz = [3,4];
array[1..n,1..2] of var int: reprovados;

predicate tuplediff(array[1..n,1..2] of var int: c) = forall(i in 1..n)(forall(j in i+1..n)(c[i,1] != c[j,1] \/ c[i,2] != c[j,2]));


predicate reprovou(var int: estudante, var int: materia) = exists(i in 1..n)(reprovados[i,2] == materia /\ reprovados[i,1]==estudante);

constraint tuplediff(reprovados);

constraint forall(i in 1..n)(reprovados[i,1] > 0 /\ reprovados[i,1] < 7 /\ reprovados[i,2] > 1 /\ reprovados[i,2] < 5);

constraint forall(i in 1..6)(forall(j in 1..2)(not reprovou(estudantes[i],materiasy[j])));

constraint exists(i in 1..6)(estudantes[i] >= 3 /\ exists(j in 1..2)(reprovou(estudantes[i],materiasz[j])));

solve satisfy;

output[show(reprovados)];