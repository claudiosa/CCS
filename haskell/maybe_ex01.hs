module MAYBE_Study where

{--
Maybe monad represents computations which might
"go wrong" by not returning a value.
For reference, here are the definitions of return and (>>=) for Maybe 
--}

go = 
    do
      {
      print "Many go 's .... see the examples: ";
      print (is_inside 3 [4, 4, 4, 4, 3, 4, 3]);
      print (is_inside 5 [4, 4, 4, 4, 3, 4, 3]);
      print (is_inside 999 [4, 4, 4, 4, 3, 4, 999]);
      print "THE END"
      }

--is_inside :: Eq a => a -> [a] -> Maybe a
--is_inside :: Eq a => a -> [a] -> Maybe [a]

-- You should define what are you as return....
is_inside :: Int -> [Int] -> Maybe [Int]
is_inside a (x:xs) 
   | only_one a (x:xs)  = Just [a]
   | not ( elem a (x:xs) ) = Nothing
   | otherwise =  Just res
     where
--       res =  (x:xs)   
     how_many_a = aux_one a (x:xs)   
     res =  [ how_many_a ]  
  -- | otherwise = error "xxxxxxxxxxxx"



only_one :: Eq t => t -> [t] -> Bool
only_one a (x:xs) 
   | aux_one a (x:xs)  == 1 = True
   | otherwise = False

aux_one ::  Eq t => t -> [t] -> Int
aux_one a [] = 0
aux_one a (x:xs)
   | (a == x )  = 1 + aux_one a xs
   | otherwise =  aux_one a xs
       



