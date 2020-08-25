{-
FROM: https://dkalemis.wordpress.com/2014/01/23/trees-in-haskell/
data Tree a = Nil
            | Node a (Tree a) (Tree a)
-}

module TREE where

-- The word data is a reserved word and we are creating a new data type
-- So we have to use this word.
data MyTree a = MyEmptyNode
     | MyFilledNode a (MyTree a) (MyTree a)
      deriving (Eq,Ord,Show,Read)

-- data MyEmptyNode  :: MyTree 

main :: IO ()
main  =
   do
      putStrLn "Begin program"
 
      let aMyTree = MyFilledNode 5555 (MyFilledNode 33333 MyEmptyNode MyEmptyNode) (MyFilledNode 22222 MyEmptyNode MyEmptyNode)
      print aMyTree
      print (sumMyTree aMyTree)
 
      let bMyTree = MyFilledNode "read" (MyFilledNode "s" MyEmptyNode MyEmptyNode) (MyFilledNode "ammma" MyEmptyNode MyEmptyNode)
      print bMyTree
 
      putStrLn "End program"
 

sumMyTree                       :: Num a => MyTree a -> a
sumMyTree MyEmptyNode            = 0
sumMyTree (MyFilledNode n t1 t2) = n + sumMyTree t1 + sumMyTree t2