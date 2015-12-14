/**
  Test if the graph's adjacency matrix is square
*/

test is_adj_matrix_square(array[int,int] of int: graph) =
  assert(index_set_1of2(graph) = index_set_2of2(graph), "The adjacency matrix is not square", true);