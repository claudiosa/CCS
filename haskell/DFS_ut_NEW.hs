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
final_node = 8

the_Graph :: [(Int, Int)]
the_Graph = [(6,8),(1,2), (1,4),(2,5),(3,6),(2,3),(3,4),(4,7),(5,6),(6,7), (10,11),(11,12)] -- connected

connected :: [(Int, Int)] -> Int -> Int -> Bool
connected graph sn fn 
    | (length from_dfs) > 0 = True -- there is a path
    | otherwise = False
    where
        from_dfs = dfs_search sn fn graph
        
--function that returns a path starting from s_n and arriving to f_n, using BFS
dfs_search :: Int -> Int -> [(Int, Int)] -> [Int]
dfs_search sn fn graph
 |flag==False = [] -- error "NO SOLUTION" -- modified for connect or no
 |otherwise   = path
 where
   (path,flag,_)= dfs_search_aux sn fn graph 0 [sn] [sn] []

dfs_search_aux :: Int -> Int -> [(Int,Int)] -> Int -> [Int] -> [Int] -> [(Int,Int)] -> ([Int],Bool,[Int])
dfs_search_aux sn fn graph level visited path []
  |sn==fn      = (path,True,visited)
  |nvn_sn==[] = ([],False,[])
  |otherwise   = dfs_search_aux next_node fn graph (level+1) (next_node:visited) (path++[next_node]) (add_level (tail nvn_sn) 1)
     where nvn_sn = not_visited_neighbours sn visited graph
           next_node = head nvn_sn
dfs_search_aux sn fn graph level visited path ((x,lx):xs)
  |sn==fn                = (path,True,visited)
  |nvn_sn == []          = dfs_search_aux x fn graph lx (x:visited) ((take lx path)++[x]) xs
  |not (elem x visited)  = dfs_search_aux next_node fn graph (level+1) (next_node:visited) (path++[next_node]) ((add_level (tail nvn_sn) (level+1))++(x,lx):xs)
  |otherwise             = dfs_search_aux sn fn graph level visited path xs
     where nvn_sn=not_visited_neighbours sn visited graph
           next_node=head nvn_sn
   
add_level [] _ = []
add_level (x:xs) l = (x,l) : add_level xs l 

not_visited_neighbours _ _ [] = []
not_visited_neighbours x visited ((a,b):xs) 
    | (x == a) && not (elem b visited) = b : not_visited_neighbours x visited xs
    | (x == b) && not (elem a visited) = a : not_visited_neighbours x visited xs
    | otherwise = not_visited_neighbours x visited xs 
