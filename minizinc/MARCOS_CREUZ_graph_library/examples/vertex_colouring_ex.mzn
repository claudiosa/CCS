include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of int: adj_mat;
array[1..N] of var 1..N: colours;
var 1..N: num_of_colours;

constraint colours = vertex_colouring(adj_mat, num_of_colours);

solve minimize num_of_colours;

output ["Minimum number of colors: " ++ show(num_of_colours) ++
      "\nResulting assignment: " ++ show(colours)
];