module CONNECTED where
import Data.Maybe
go :: IO ()
go = do{
      putStr "Graph\n";
      print the_Graph;
      putStr "Is it connected? \n";
      print (connected the_Graph);
      --print (is_connected the_Graph [1..8])
     }

the_Graph :: [(Int, Int)]
the_Graph = [(6,8),(1,2),(1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7)]
--the_Graph = [(1,2),(2,3),(2,4),(6,7)]--not connected

connected g = is_connected g (nodes_list g)

is_connected [] [] = True
is_connected [] _ = False
is_connected _ [] = error "==INVALID INPUT=="
is_connected g n = length(dfs_search (head n) g)==length n

--function that returns the list of visited nodes, using a DFS, starting from a node sn
dfs_search :: Int -> [(Int,Int)]-> [Int]
dfs_search sn graph = dfs_search_aux sn graph [sn] [sn]

dfs_search_aux :: Int -> [(Int,Int)] -> [Int] -> [Int] -> [Int]
dfs_search_aux sn graph visited path
  |not (isNothing neighbour)     = dfs_search_aux x graph (x:visited) (x:path)
  |new_path == []                = visited
  |otherwise                     = dfs_search_aux (head new_path) graph visited new_path
     where neighbour=not_visited_neighbour sn visited graph
           x = fromJust neighbour
           new_path= tail path
   
not_visited_neighbour :: Int -> [Int] -> [(Int,Int)] -> Maybe Int
not_visited_neighbour _ _ [] = Nothing
not_visited_neighbour x visited ((a,b):xs) 
    | (x == a) && not (elem b visited) = Just b
    | (x == b) && not (elem a visited) = Just a
    | otherwise = not_visited_neighbour x visited xs

nodes_list :: [(Int,Int)]->[Int]
nodes_list g = nodes_list_aux g []

nodes_list_aux [] nodes = nodes
nodes_list_aux ((a,b):gs) nodes
  |na && nb  = nodes_list_aux gs (a:b:nodes)
  |na        = nodes_list_aux gs (a:nodes)
  |nb        = nodes_list_aux gs (b:nodes)
  |otherwise = nodes_list_aux gs nodes
  where
    na=not (elem a nodes)
    nb=not (elem b nodes)
