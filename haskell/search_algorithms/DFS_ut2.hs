module DFS_SEARCH where
import Data.Maybe
go :: IO ()
go = do{
      putStr "\t Depth First Search or DFS for a Graph\t"; 
      putStr "\n\t One path is: ";
      print (dfs_search start_node final_node the_Graph)
     }
start_node :: Int
start_node = 1
final_node :: Int
final_node = 3

the_Graph :: [(Int, Int)]
the_Graph = [(6,8),(1,2),(1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7)]
--the_Graph = [(1,2),(2,3),(2,4)]

--function that returns a path starting from s_n and arriving to f_n, using DFS
dfs_search :: Int -> Int -> [(Int,Int)]-> [Int]
dfs_search sn fn graph = dfs_search_aux sn fn graph [sn] [sn]

dfs_search_aux :: Int -> Int -> [(Int,Int)] -> [Int] -> [Int] -> [Int]
dfs_search_aux sn fn graph visited path
  |sn==fn                        = path
  |not (isNothing neighbour)     = dfs_search_aux x fn graph (x:visited) (path++[x])
  |has_length_1 path             = error "NO SOLUTION"
  |otherwise                     = dfs_search_aux (last new_path) fn graph visited new_path
     where neighbour=not_visited_neighbour sn visited graph
           x = fromJust neighbour
           new_path= init path
   
not_visited_neighbour :: Int -> [Int] -> [(Int,Int)] -> Maybe Int
not_visited_neighbour _ _ [] = Nothing
not_visited_neighbour x visited ((a,b):xs) 
    | (x == a) && not (elem b visited) = Just b
    | (x == b) && not (elem a visited) = Just a
    | otherwise = not_visited_neighbour x visited xs

has_length_1 :: [Int]->Bool
has_length_1 [] = False
has_length_1 (x:xs) = xs==[]
