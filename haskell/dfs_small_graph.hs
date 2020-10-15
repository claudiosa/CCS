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

      putStr "\tDepth First Search or DFS for a Graph"; 
      putStr "\n";
      putStr "\n"; 
      putStr "\n";
--    MAP OPEN_NODES CLOSED_NODES     
      print (reverse ( dfs_search [1] [] ))
     }
-- 

start_node :: Int
start_node = 1
end_node :: Int
end_node = 3
-- connectivity map
the_map = [(1,2),(1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7)]


-- check if x is  final node
check_final x 
   | x == end_node = True
   | otherwise = False

-- If any  more nodes  to be check finding the end node

dfs_search :: [Int] -> [Int] -> [Int]
dfs_search [] _ = error "NO SOLUTION"
-- busca com lopen(lista corrente de nós abertos) e lclosed(nós já verificados e não finais)
dfs_search (x:xs) l_closed
  -- if the next_node is final ... stop
  | check_final (next_node x) == True = [next_node x] ++ (x:xs) -- final node was reached
  -- if next_node is already in (x:xs) && next_node is not final && it is not in L_closed
  | elem (next_node x) (x:xs) && not(check_final (next_node x)) && not(elem (next_node x) l_closed)  =  dfs_search (x:xs)  [next_node x] ++ l_closed
  -- here, the next_node is cool .. new node
  | not(elem (next_node x) (x:xs)) && not(elem (next_node x) l_closed) = dfs_search ((next_node x) : x : xs)  l_closed
  | otherwise = error " NO IDEA "

{-
-- | otherwise = dfs_search (next_node x : x : xs)  l_closed
-- DFS_SMALL> (4:3:[3,6])
-- [4,3,3,6]
-}

next_node :: Int -> Int
next_node x = get_next x the_map

--get_next :: Eq t => t -> [(t, t)] -> t
get_next :: Int -> [(Int, Int)] -> Int
get_next _ [] = error " x is not in the map " 
get_next x ((a,b) : xs) 
   | (x == a) = b
   | (x == b) = a
   | (x /= a) && (x /= b) = get_next x xs
   | otherwise = error "SOMETHING STRANGE IN THE MAP or x searched"                    
