include "../lib/graphs.mzn";

array[1..4, 1..4] of int: graph = [| 1, 0, 0, 0
                                   | 0, 1, 1, 1
                                   | 0, 1, 1, 1
                                   | 0, 1, 1, 1|];
var set of 1..4: r = reachables(graph, 4);

solve satisfy;

output[show(r)];