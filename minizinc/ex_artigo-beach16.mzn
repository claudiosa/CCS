var -5 .. 15 : x;
constraint x > 10;
constraint x <= 15;
constraint x mod 3 == 0;

solve satisfy;

output ["VAR x = ", show(x) ];