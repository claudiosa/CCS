array[1..3, 1..2] of int : A;
A = [| 4, 5   
     | 0, 9   
     | 5, 8 |];

array[1..2, 1..3] of int : B;
B = array2d(1..2, 1..3,
           [9,8,-3, 5,-5,7]);

array[1..2, 1..3, 1..2] of int : C;
C = array3d(1..2, 1..3, 1..2,
             [9, -5, 3,  5, 6, 8,
             19, 12, -13, 17, -15, 18]);

solve satisfy;

output[show2d(A),"\n",show2d(B),"\n",show3d(C)];
