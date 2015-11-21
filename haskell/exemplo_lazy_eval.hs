
dobro, triplo :: Int -> Int
menor, f :: Int -> Int -> Int

menor x y
   | x < y = x
   | otherwise = y
   
dobro x = x + x
triplo x = 3*x
f a b  =  (dobro (triplo (menor a  b) ) ) 
