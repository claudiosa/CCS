include "vertex_set_fn.mzn";
/*
Original coded by Marcos -- 2015
Modified and revised by Claudio - Oct. 21 / 2016

*/

/**
  Returns the number of vertexes of the graph
  Order means the cardinality
*/

function int: order(array[int,int] of int: graph) =
  card( vertex_set( graph ));
