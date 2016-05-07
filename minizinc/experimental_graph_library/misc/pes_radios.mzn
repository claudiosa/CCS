var 0..24: A;
var 0..16: B;

constraint A + 2*B <= 40;

solve maximize 30*A + 40*B;

output[show(A) ++ " " ++ show(B)];