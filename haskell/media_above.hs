
soma_3 :: Float -> Float -> Float -> Float

soma_3  x  y  z =  x + y + z
-- media_3 :: Fractional a => a -> a -> a -> a
media_3 :: Float -> Float -> Float -> Float
media_3 x y z = (soma_3 x y z) / 3


-- how_many :: (Num t, Ord a, Fractional a) => a -> a -> a -> t
how_many :: Float -> Float -> Float -> Int
how_many x y z | (x > med) && (y > med) = 2
               | (x > med) && (z > med) = 2
	       | (y > med) && (z > med) = 2
	       | (x >= med) && (y >= med) && (z >= med) = 0
	       | otherwise = 1	
       where
             med = media_3 x y z
