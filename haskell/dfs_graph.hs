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
End/Arrival node: 7

PS: No weight in this version -- easily extendeable

-}
module DFS_SEARCH where

--import System.IO
go :: IO ()
go = do{

      putStr "\t Depth First Search or DFS for a Graph\t"; 
--    putStr "\n";
      putStr "\n\t One path is: ";
      print (reverse ( dfs_search [start_node] [] ))
     }
{-
connected :: IO ()
connected =
    if  (is_a_list result) && (length result > 0)
        then
            print "connected"
        else
            print "unconnected"
    where
        result = dfs_search [start_node] []
-}
{- OBS: 
  the Graph, start node and final/end nodes
  are given in the code, look below
  ....
  these data are given embeded in this code
-}

connected :: Bool
connected 
    | result == [] = False
    | otherwise = True
    where
       result = dfs_search [start_node] [] 

-- Initial data for init and final nodes
start_node :: Int
start_node = 1
final_node :: Int
final_node = 8

-- connectivity of this graph (node,node) -- bidirectional
-- no costs here
type Graph = [(Int, Int)]
the_Graph :: Graph
-- Examples: one connected and another not connected
-- the_Graph = [(6,8),(1,2), (1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7)] -- connected
the_Graph = [(1,2),(1,4),(2,5),(2,3),(3,4),(4,7),(6,8),(8,9)] -- not connected

{-------------------------------------}

{- the code -}
-- If any  more nodes  to be check finding the end node
-- The idea of this DFS is classic ...
-- A current list, registering the nodes that are candidates for a path
-- and a list with closed nodes (this list is boolean), to mark all the nodes
-- without result
dfs_search :: [Int] -> [Int] -> [Int]
dfs_search [] _ = [] -- NO SOLUTION -- adapted for connected graph between 2 points
--  error "NO SOLUTION"
-- if the next_node is final ... stop
-- final node was reached -- halt condition
-- dfs_search (x:xs) l_closed  | (final_node == x) = diff_A_B (x:xs) l_closed
dfs_search (x:xs) _  | (final_node == x) = (x:xs)
-- [x]++l_closed
-- (x:xs) current list or open nodes and  lclosed -- nodes already checked
dfs_search (x:xs) l_closed
  -- the  backtracking is HERE .. no NEWs and from node x
  -- goes to dead end ... and back up to the previous valid node 
  -- BACTRACKING is happening HERE
  | elem x l_closed  =  dfs_search xs l_closed 
   -- A list of next_nodes is  not in L_closed either in (x:xs)
   -- expand for a new_node   in (x:xs) and L_closed
   -- && not(already_visited new_node l_closed)
  | otherwise = dfs_search update_Stack (x : l_closed)
   where
      -- a new_node is NEW
      new_nodes = next_nodes x l_closed
      -- improve HERE
      update_Stack = (diff_A_B new_nodes (x:xs)) ++ (x:xs)
      
-- obtain a next node valid considering the L_closed or visited nodes
next_nodes :: Int -> [Int] -> [Int]
next_nodes x l_closed
  -- get all the neighbour of x => bring a list of possible
  -- new nodes to visit, but someone already visited
  -- get_neighbour x the_Graph  -- results in a list
      =  diff_A_B l_neighbours l_closed
      where
     -- a list with all the neighbours from x
        l_neighbours = get_neighbour x the_Graph
      
-- to avoid repetion on nodes in current list ....
diff_A_B :: [Int] -> [Int] -> [Int]
diff_A_B [] _ = []         
diff_A_B (a:b) lst 
    | not(elem a lst) = a : diff_A_B  b  lst
    | otherwise =  diff_A_B b  lst 

{- ************ AUX Functions ************** -}
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

{- ******************************** -}
-- Check if it is a list
is_a_list :: [a] -> Bool
is_a_list [] = True
is_a_list (_:b) = is_a_list b