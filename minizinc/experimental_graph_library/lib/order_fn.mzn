include "vertex_set_fn.mzn";

/**
  Returns the number of vertexes of the graph
*/

function int: order(array[int,int] of int: graph) =
  card(vertex_set(graph));
