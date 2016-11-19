include "vertex_set_fn.mzn";
include "is_adj_matrix_square.mzn";

/**
  Params:
  graph: an adjacency-matrix representing a graph

  This predicate simply assures that the given graph is complete
*/

predicate complete(array[int,int] of int: graph) =
let {
     set of int: V = vertex_set(graph);
    }
in  (
    is_adj_matrix_square(graph) /\
    forall(u, v in V, where u < v) (graph[u,v] != 0 /\ graph[v,u] != 0)
   );

%%% by CCS ... in function -- 
function var bool: complete_FUNCTION(array[int,int] of int: graph) 
   :: promise_total =
let {
     var bool : resp1 ;
     var bool : resp2 ;
     var bool : resp3 ;
      
     set of int: V = vertex_set(graph);
     
     constraint 
        resp1 = is_adj_matrix_square_FUNCTION(graph) ;
       
     constraint 
       resp2 = 
         (forall(u, v in V, where u < v) 
          (graph[u,v] != 0 /\ graph[v,u] != 0)
          );
       
      constraint 
         resp3 = (resp1 /\ resp2);
        
    }
  in resp3 ;
