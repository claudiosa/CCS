import Data.Graph
import Data.Array

graph_1 = buildG (1, 5) [(1,2), (1,3), (2,3), (2,4), (3,5)]
graph_2 = buildG (1, 5) [(1,2), (1,3), (2,1), (2,3), (2,4), (3,1), (3,2), (3,5), (4,2), (5,3)]
graph_3 = buildG (1,8) [(1,2), (1,4), (2,1), (2,3), (2,5), (3,2), (3,4), (3,6), 
                       (4,3), (4,7), (5,2), (5,6), (6, 5), (6,7), (6,8), (7,6), (8,8)] 

graph_4 = buildG (1,8) [(1,2),(1,4),(2,5),(3,6),(2,3),(3,4),(4,5),(6,7),(6,8)]

{-
mydfs graph visited [] = reverse visited
mydfs graph visited (x:xs) | elem x visited = mydfs graph visited xs
                           | otherwise = mydfs graph (x:visited) ((graph !! x) ++ xs)
-}




depthfs g i = dfs' g [] i 

dfs' g visited i = i:visit g (i:visited) (g!i)
        
visit _ _ [] = []
visit g vs (x:xs) =  if not (elem x vs) 
    then vs' ++ visit g (vs'++vs) xs 
    else visit g vs xs  
  where 
    vs' = dfs' g vs x