include "../lib/graphs.mzn";

int: N;
array[1..N, 1..N] of 0..50: adj_mat;
array[1..N] of var int: hamiltonian_cycle;

constraint hamiltonian_cycle = hamiltonian_cycle(adj_mat);

solve satisfy;

output[show(hamiltonian_cycle)];

N=5;
adj_mat = [|
0 , 5 , 10, 0 , 1,|
5 , 0 , 0 , 10, 1,|
10, 0 , 0 , 2 , 1,|
0 , 10, 2 , 0 , 1,|
1 , 1 , 1 , 1 , 0 |];