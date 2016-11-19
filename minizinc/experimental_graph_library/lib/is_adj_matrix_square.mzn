/**
  Test if the graph's adjacency matrix is square
*/

test is_adj_matrix_square(array[int,int] of int: graph) =
  assert(index_set_1of2(graph) = index_set_2of2(graph), "The adjacency matrix is not square", true);
 
%% added by CCS -- OK  -- legibility
function var bool : is_adj_matrix_square_FUNCTION( array[int,int] of int: graph ) 
   :: promise_total =
    if  ( index_set_1of2(graph) == index_set_2of2(graph) )
    then
		true
    else 
		false
    endif;
%% Declare function as total, i.e. it does not put any constraints on its arguments.
