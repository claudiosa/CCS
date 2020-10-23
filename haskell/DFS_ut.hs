module DFS_SEARCH where
go :: IO ()
go = do{
      putStr "\t Depth First Search or DFS for a Graph\t"; 
      putStr "\n\t One path is: ";
      print (dfs_search start_node final_node the_Graph)
     }
start_node :: Int
start_node = 1
final_node :: Int
final_node = 7

the_Graph :: [(Int, Int)]
the_Graph = [(6,8),(1,2),(1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7)]
--the_Graph = [(1,2),(2,3),(2,4)]

--function that returns a path starting from s_n and arriving to f_n, using BFS
dfs_search :: Int -> Int -> [(Int,Int)]-> [Int]
dfs_search sn fn graph = dfs_search_aux sn fn graph 0 [sn] [sn] []

-- auxiliary function for DFS
-- arguments are:
-- Int starting node
-- Int final node
-- [(Int,Int)] the graph
-- Int a level of the current node (it is the length of the current path -1, you could remove it as argument and replace with length path -1 in the code
-- [Int] list of visited nodes
-- [Int] the path I'm building
-- [(Int,Int)] it simulates a stack of nodes that will be visited in the future if final node is not found before. First elemnt of each couple is the node, second is its "level" when it was inserted in the stack (notice that a node may be inserted more than once in the stack at different levels, but will be visited only once)
-- [Int] is the returned path
dfs_search_aux :: Int -> Int -> [(Int,Int)] -> Int -> [Int] -> [Int] -> [(Int,Int)] -> [Int]
-- case of empty stack (it could happen to discover that there is no solution)
dfs_search_aux sn fn graph level visited path []
  |sn==fn      = path
  |nvn_sn==[] = error "NO SOLUTION"
  |otherwise   = dfs_search_aux next_node fn graph (level+1) (next_node:visited) (path++[next_node]) (add_level (tail nvn_sn) (level+1))
     where nvn_sn=not_visited_neighbours sn visited graph
           next_node=head nvn_sn

-- case of non-empty stack
dfs_search_aux sn fn graph level visited path ((x,lx):xs)
  |sn==fn                = path
  |nvn_sn == []          = dfs_search_aux x fn graph lx (x:visited) ((take lx path)++[x]) xs
  |not (elem x visited)  = dfs_search_aux next_node fn graph (level+1) (next_node:visited) (path++[next_node]) ((add_level (tail nvn_sn) (level+1))++(x,lx):xs)
  |otherwise             = dfs_search_aux sn fn graph level visited path xs
     where nvn_sn=not_visited_neighbours sn visited graph
           next_node=head nvn_sn
   
add_level :: [Int]->Int->[(Int,Int)]
add_level [] _ = []
add_level (x:xs) l = (x,l) : add_level xs l 

not_visited_neighbours :: Int -> [Int] -> [(Int,Int)] -> [Int]
not_visited_neighbours _ _ [] = []
not_visited_neighbours x visited ((a,b):xs) 
    | (x == a) && not (elem b visited) = b : not_visited_neighbours x visited xs
    | (x == b) && not (elem a visited) = a : not_visited_neighbours x visited xs
    | otherwise = not_visited_neighbours x visited xs 
