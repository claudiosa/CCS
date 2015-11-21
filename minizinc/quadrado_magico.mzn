int: soma;

array[0..3,0..3] of var 1..16: mat;

constraint forall(i in 0..3)
	(mat[i,0] + mat[i,1] + mat[i,2] + mat[i,3] = soma);
constraint forall(j in 0..3)
	(mat[0,j] + mat[1,j] + mat[2,j] + mat[3,j] = soma);
constraint mat[0,0] + mat[1,1] + mat[2,2] + mat[3,3] = soma;
constraint mat[0,3] + mat[1,2] + mat[2,1] + mat[3,0] = soma;
constraint forall(i in 0..3, j in 0..3, k in i..3, l in j..3)
	(if (i!= k \/ j != l) then mat[i,j] != mat[k,l] else true endif);
constraint forall(i in 0..3, j in 0..3)(mat[i,j] <= 16);

solve satisfy;

output[show_int(2,mat[i,j]) ++
        if j==3 then "\n" else " " endif |
        i in 0..3, j in 0..3];
