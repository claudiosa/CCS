{- Start point code: Gabriela Thumé (30/04/2011)

DFS - Depth First Search or DFS for a Graph

   Usage: $ ghci
	Prelude> :load ).hs
	*LABIRINTO> inicio

An Example of graph

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

Representation:

 [(1,2),(1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7)]

Departure node: 1
End/Arrival node: 6

PS: No weight in this version

-}
module DFS_SMALL where

import System.IO

-- if a tuple is in the list
member :: Int -> [Int] -> Bool
member _ [] = False
member x (q:ws)
   | (x == q) = True
   | otherwise = member x ws

-- for the future
-- custo_total [] = 0
-- custo_total ((x,y):ws) = (custo(x,y) + custo_total ws)

go :: IO ()
go = do{

      putStr "\tDepth First Search or DFS for a Graph\t"; 
--    putStr "\n";
--    putStr "\n"; 
--    MAP OPEN_NODES CLOSED_NODES     
      print (reverse ( dfs_search [start_node] [] ))
     }
-- 

start_node :: Int
start_node = 1
final_node :: Int
final_node = 3
-- connectivity map
the_map :: [(Int, Int)]
--the_map = [(1,2),(1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7)]
the_map = [(1,2),(1,3),(2,3)]

-- check if x is  final node
check_final :: Int -> Bool 
check_final x 
   | x == final_node = True
   | otherwise = False

-- If any  more nodes  to be check finding the end node

dfs_search :: [Int] -> [Int] -> [Int]
-- dfs_search [] _ = error "NO SOLUTION"
-- if the next_node is final ... stop

-- final node was reached -- halt condition
dfs_search (x:xs) _ 
   | (final_node == x) = (x:xs) 

-- (x:xs) current list or open nodes and  lclosed -- nodes already checked
dfs_search (x:xs) l_closed
   -- if next_node is already in (x:xs) && next_node is not final && it is not in L_closed
  | not(elem new_node (x:xs))  =  dfs_search (new_node : x:xs) l_closed
 --   not(elem new_node l_closed) 
  -- here, the next_node is a new node
  -- a backtracking is HERE .. no NEWs and the node x
  -- goes to dead end
  | otherwise = dfs_search   xs  [x]++l_closed
   where
     --new_node = next_node x (x:xs) -- OR
     new_node = next_node x l_closed
 --    l_NEW_closed = insert x l_closed
{-
-- 
  | otherwise = error " NO IDEA "

-- > (4:3:[3,6])
-- [4,3,3,6]
-}

-- next_node :: Int -> Int
next_node x a_list = get_next x the_map a_list
--get_next :: Eq t => t -> [(t, t)] -> t
-- get_next :: Int -> [(Int, Int)] -> Int
get_next _ [] _ = error " x is not in the map " 
get_next x ((a,b) : xs) a_list
   | (x == a) && not(elem b a_list) = b
   | (x == b) && not(elem a a_list) = a
   | (x /= a) && (x /= b) = get_next x xs a_list
   | otherwise = error "SOMETHING STRANGE IN THE MAP or x searched"                    

{- ************ AUX Functions ************** -}

-- build initial list of nodes closed
-- closed = 0 not visited yet
-- closed = 1 visited 
build_L_close :: [Int]
build_L_close = [i-i | i <- [1 .. max_L_Duple the_map]]
-- all nodes all initialized with 0 ... NOT VISITED yet


-- inspired in CCS's book  this max
max_L_Duple :: Ord a => [(a, a)] -> a
-- the MOST of list with tuple-2
max_L_Duple [] = error "Empty List of Duples"
max_L_Duple ((a,b):[]) = max a b
max_L_Duple ((a,b):xs) 
   | c > (max_L_Duple xs) = c
   | otherwise = max_L_Duple xs
   where
      c = max a b

    
