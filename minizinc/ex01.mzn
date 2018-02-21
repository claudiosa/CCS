var -5..15 : x;

constraint x > 10;

%constraint x < 5;

solve satisfy;

output ["VAR_x = ", show(x) ];
