{- Start point code: Gabriela Thumé (30/04/2011)

DFS - Depth First Search or DFS for a Graph

 Usage: $ ghci
*DFS_SEARCH> :l dfs_graph.hs  
[1 of 1] Compiling DFS_SEARCH       ( dfs_graph.hs, interpreted )
Ok, one module loaded.
*DFS_SEARCH> go
	 Depth First Search or DFS for a Graph	
	 One path is: [1,4,7,6,8]
*DFS_SEARCH> 

An example of a Graph

             +-+             
    ---------|1|----------   
    |        +-+         |   
    |                    |    
    |                    |   
   +-+       +-+        +-+  
   |2|-------|3|--------|4|  
   +-+       +-+        +-+  
    |         |          |   
    |         |          |   
    |         |          |   
   +-+       +-+        +-+   
   |5|-------|6|--------|7|   
   +-+       +-+        +-+
              |
              |
             +-+             
             |8|   
             +-+         

Representation of this Graph:
Nodes and edges are represented by pairs ... directly
[(1,2),(1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7)]

Example:
Departure node: 1
End/Arrival node: 8

PS: No weight in this version -- easily extendeable

-}
module DFS_SEARCH where

--import System.IO
go :: IO ()
go = do{

      putStr "\t Depth First Search or DFS for a Graph\t"; 
--    putStr "\n";
--    MAP OPEN_NODES CLOSED_NODES
--    l_init_closed = build_L_closed; -- look this naive predicate     
      putStr "\n\t One path is: ";
      print (reverse ( dfs_search [start_node] build_L_closed ))
     }
-- Initial dataup
start_node :: Int
start_node = 1
final_node :: Int
final_node = 8

-- connectivity of this graph (node,node) -- bidirectional
-- no costs here
the_Graph :: [(Int, Int)]
the_Graph = [(1,2),(1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7),(6,8)]
-- the_Graph = [(1,2),(2,3),(2,4)]


-- If any  more nodes  to be check finding the end node
-- The idea of this DFS is classic ...
-- A current list, registering the nodes that are candidates for a path
-- and a list with closed nodes (this list is boolean), to mark all the nodes
-- without result
dfs_search :: [Int] -> [Bool] -> [Int]
dfs_search [] _ = error "NO SOLUTION"
-- if the next_node is final ... stop
-- final node was reached -- halt condition
dfs_search (x:xs) _  | (final_node == x) = (x:xs) 
-- (x:xs) current list or open nodes and  lclosed -- nodes already checked
dfs_search (x:xs) l_closed
   -- A next_node is  not in L_closed either in (x:xs)
   -- expand for a new_node   in (x:xs) and L_closed
  | not(elem new_node (x:xs)) =  dfs_search (new_node : x : xs) l_closed
  -- here, the next_node is a new node to be explore
  -- and the  backtracking is HERE .. no NEWs and the node x
  -- goes to dead end ... and back up to the previous valid node 
  -- BACTRACKING is happening HERE
  | otherwise = dfs_search xs (update_L_closed x l_closed)
   where
      -- a new_node is NEW
      new_node = next_node x l_closed

-- Attention: 
-- > (4:3:[3,6])
-- [4,3,3,6]

-- obtain a next node valid considering the L_closed or visited nodes
next_node :: Int -> [Bool] -> Int
next_node x l_closed
  -- get all the neighbour of x => bring a list of possible
  -- new nodes to visit, but someone already visited
  -- get_neighbour x the_Graph  -- results in a list
  -- elem False l_closed means ... there is nodes not visited yet
   | elem False l_closed = one_node l_neighbour l_closed
   | otherwise = error " NONE NODE IS FREE to be visited "
     where
        l_neighbour = get_neighbour x the_Graph 

-- Input: a list with all neighbour of x and l_closed current ... both are lists
-- at least one node to be visited    
one_node :: [Int] -> [Bool] -> Int
one_node [] _ = error "NONE NODE IS FREE to be explored"
one_node [a] _ = a        -- ONLY ONE NODE ==> to be fix in the future
one_node (a:xs) l_closed        
    | (already_visited a l_closed) = a
    | otherwise = one_node xs l_closed

{- ************ AUX Functions ************** -}
-- building initial list of nodes closed
-- closed = 0 not visited yet
-- closed = 1 visited 
build_L_closed :: [Bool]
build_L_closed = [False | i <- [1 .. max_L_Duple the_Graph]]
-- all nodes all initialized with 0 ... NOT VISITED yet
-- something like [False | x <- [1..10]]

-- inspired in CCS's book  this max ...
-- Given the Graph, following the representation above
-- [(e1,e2), .....(en,em)] any order or sequence
-- obtain the number of nodes or the node with the most value
max_L_Duple :: Ord a => [(a, a)] -> a
-- the MOST of list with tuple-2
max_L_Duple [] = error "Empty List of Duples"
max_L_Duple ((a,b):[]) = max a b
max_L_Duple ((a,b):xs) 
   | c > (max_L_Duple xs) = c
   | otherwise = max_L_Duple xs
   where
      c = max a b

-- update closed list with True in position p ....
-- position p is the node in the graph
update_L_closed :: Int -> [Bool] -> [Bool]
update_L_closed _ [] = error "L closed empty"
update_L_closed  1 (_:xs) = (True:xs)
update_L_closed  p (x:xs)
   | (p > 1)  && (p <= length (x:xs))   = x : update_L_closed (p-1) xs
   | otherwise = error "Size of L Closed -- problem"
--  

-- check if a node p was already visited --> return T or F
already_visited :: Int -> [Bool] -> Bool
already_visited _ [] = error "L closed empty"
already_visited  1 (True:_)  = True
already_visited  1 (False:_) = False
already_visited  p (x:xs)
   | (p > 1) && (p <= length (x:xs)) = already_visited (p-1) xs
   | otherwise = error "Size of L Closed -- problem"

-- 
-- get all neighbour of a node x in the graph
-- look ... the map is a tuple list ... why is the reason
--
get_neighbour :: Eq a => a -> [(a, a)] -> [a]
get_neighbour _ [] = [] 
get_neighbour x ((a,b):xs) 
    | (x == a) = b : get_neighbour x xs
    | (x == b) = a : get_neighbour x xs
    | otherwise = get_neighbour x xs 

{---------------  NOT USED NOW ---------}    
{---------------  DISCARD FROM HERE ---------}
-- if a  is in the list = elem
member :: Int -> [Int] -> Bool
member _ [] = False
member x (q:ws)
   | (x == q) = True
   | otherwise = member x ws

-- for the future
-- custo_total [] = 0
-- custo_total ((x,y):ws) = (custo(x,y) + custo_total ws)


-- check if x is  final node
check_final :: Int -> Bool 
check_final x 
   | x == final_node = True
   | otherwise = False