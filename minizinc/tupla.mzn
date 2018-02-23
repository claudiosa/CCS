
array[1..4,1..2] of int : A = array2d(1..4,
				      1..2,
				      [0,5,1,7,-3,5,-5,8]
                                      );

array[1..5,1..2] of int : B = array2d(1..5,
                                      1..2,
                                      [-1,0,0,-1,5,4,2,9,-7,-6]
                                      );
array[1..4,1..2] of var int: C;

constraint forall(i in 1..4)(C[i,1] = A[i,1] /\ C[i,2] = B[i,2]);

solve satisfy;

output[show(C)];
