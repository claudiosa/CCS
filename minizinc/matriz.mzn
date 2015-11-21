int: w = 4;
int: h = 4;
array[0..w,0..h] of var float: t;
float: left = 0.0;
float: right = 0.0;
float: top = 100.0;
float: bottom = 0.0;

constraint forall(i in 1..w-1, j in 1..h-1)(4.0*t[i,j] = t[i-1,j] + t[i,j-1] + t[i+1,j] + t[i,j+1]);
constraint forall(i in 1..w-1)(t[i,0] = left);
constraint forall(i in 1..w-1)(t[i,h] = right);
constraint forall(j in 1..h-1)(t[0,j] = top);
constraint forall(j in 1..h-1)(t[w,j] = bottom);
constraint t[0,0] = 0.0;
constraint t[0,h] = 0.0;
constraint t[w,0] = 0.0;
constraint t[w,h] = 0.0;

solve satisfy;
output [ show_float(6, 2, t[i,j]) ++
        if j == h then "\n" else " " endif |
        i in 0..w, j in 0..h];