module MAYBE_Study where

{--
Maybe monad represents computations which might
"go wrong" by not returning a value.
For reference, here are the definitions of return and (>>=) for Maybe 
--}

go = is_inside 3 [3,4,3]


is_inside :: Eq a => a -> [a] -> Maybe a
is_inside a (x:xs) 
   | only_one a (x:xs)  = Just a
   | not ( elem a (x:xs) ) = Nothing
--  | otherwise = is_inside a (a:[])
   | otherwise = error "xxxxxxxxxxxx"
-- | otherwise = Just  (aux_one a (x:xs))  
{-
   | otherwise = Just res

    where
     res = aux_one a (x:xs)   
-}

only_one :: Eq t => t -> [t] -> Bool
only_one a (x:xs) 
   | aux_one a (x:xs)  == 1 = True
   | otherwise = False

aux_one ::  Eq t => t -> [t] -> Int
aux_one a [] = 0
aux_one a (x:xs)
   | (a == x )  = 1 + aux_one a xs
   | otherwise =  aux_one a xs
       



