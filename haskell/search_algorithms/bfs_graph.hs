{- Start point code: Gabriela Thumé (30/04/2011)
   Resume in October/2020
   
BFS - Breadth First Search or DFS for a Graph

 Usage: $ ghci

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
module BFS_SEARCH where
--import Data.Maybe

-- import System.IO

go :: IO ()
go = do{
      putStr "\t Depth First Search or DFS for a Graph\t"; 

      putStr "\n\t The path are: \n";
--  print (dfs_search start_node final_node the_Graph )
      mapM_ print [ bfs_search start_node finals the_Graph | finals <- [1 .. max_L_Duple the_Graph ] ]
     }

{- OBS: 
  the Graph, start node and final/end nodes
  are given in the code, look below
  ....
  these data are given embeded in this code
-}
-- EXAMPLE -- data
-- Initial data for init and final nodes
start_node :: Int
start_node = 1
--final_node :: Int
--final_node = 5

-- connectivity of this graph (node,node) -- bidirectional
-- no costs here
type Graph = [(Int, Int)]
the_Graph :: Graph
-- Examples: one connected and another not connected
the_Graph = [(6,8),(1,2),(1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7)] -- connected - the figure
-- the_Graph = [(1,2),(5,4),(4,1),(2,3)]
--the_Graph = [(5,2),(5,4),(4,1)]
--the_Graph = [(1,2),(1,4),(2,5),(2,3),(3,4),(4,7),(6,8),(8,9)] -- not connected

{-------------- END OF DATA -----------------------}

{- the code -}
-- The idea of this BFS is classic ...
-- A current list, registering the nodes that are candidates for a path
-- and a list with closed nodes (this list is boolean), to mark all the nodes
-- without result
--function that returns a path starting from s_n and arriving to f_n, using DFS
bfs_search :: Int -> Int -> Graph -> [Int]
bfs_search sn fn graph = bfs_search_aux sn fn graph [sn] [sn]
-- sn: start node
-- fn: final node
-- if the next_node is final ... stop
-- final node was reached -- halt condition

bfs_search_aux :: Int -> Int ->  Graph -> [Int] -> [Int] -> [Int]
-- different of ... 
-- current path ... closed or visited nodes
bfs_search_aux sn fn graph path visited 
  | (sn == fn) = path -- if the current node sn == final ... stop and back the current paht
  -- x not visited and not in the current path     
  | not(elem x visited) = bfs_search_aux x fn graph ( path ++ imed_successors ) (sn : visited) 
  | (length path == 1)       = error " == NO SOLUTION == "
  -- the previous node is explored ....
  | otherwise   = bfs_search_aux (last new_path) fn graph new_path  visited
    where
    -- a new_node is NEW
    imed_successors = get_new_neighbours sn visited  graph
    x = one_node sn imed_successors -- get the first node not visited and new in that path 
    new_path = init path -- take the path without the last as a queue ... previous state

-- get one node from the current stack which
-- it is not in closed/visited either in current path
one_node :: Int -> [Int] -> Int  
one_node current neighbours =
    if neighbours == [] 
        then current 
        else (last neighbours) -- as a LIFO
{-
   -- | length l > 0 = head l
   -- | otherwise = min_L_Duple graph --- just to avoid a fail ... no news nodes
-}

{- 
Prelude> init [3,4,5]
[3,4]
Prelude> last [3,4,5]
5
Prelude> 
Prelude> head [3,4,5]
3
-}

-- (x:xs) current list or open nodes and  lclosed -- nodes already checked
-- get all neighbour of a node x in the graph
-- look ... the map is a tuple list ... why is the reason

-- A list of next_nodes is  not in L_closed either in (x:xs)
get_new_neighbours :: Int -> [Int] -> Graph -> [Int]
get_new_neighbours _ _ [] = [] 
-- node current , l_visited and the graph
get_new_neighbours x visited ((a,b):xs) 
    | (x == a) && not (elem b visited) = b : get_new_neighbours x visited xs
    | (x == b) && not (elem a visited) = a : get_new_neighbours x visited xs
    | otherwise = get_new_neighbours x visited xs


{- ************ STUDY Functions of this DFS ************** -}
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

min_L_Duple :: Ord a => [(a, a)] -> a
-- the MOST of list with tuple-2
min_L_Duple [] = error "Empty List of Duples"
min_L_Duple ((a,b):[]) = min a b
min_L_Duple ((a,b):xs) 
   | c < (min_L_Duple xs) = c
   | otherwise = min_L_Duple xs
   where
      c = min a b
-- 

-- get all neighbour of a node x in the graph
-- look ... the map is a tuple list ... why is the reason
-- my initial function
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


