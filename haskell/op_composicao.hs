
suc x = x + 1
aux =  suc

g :: Float -> Int
g x = round x          -- função de arredondamento

f :: Int -> Bool
f x =  even (fromIntegral x)    --  verifica se é par

k :: Bool -> IO ()
k  x 
      | x == True = putStr    " É um número PAR"
      | otherwise   =  putStr   " É IMPAR"
      
      
h_1       =  f . g
h_2   x   =  f (g  x)
h_3   x    =  (f  (g   x))
h_4   f  g =  f . g
h_5   f  g  =  f  g 
h_6   f  g  x = f (g  x)
h_7   f  g  x = (f . g)  x
h_8   k f  g  = k . f . g 
h_9   x  = (k . f .  g ) x
h_10   x  = ( k . ( f .  g))  x
h_11   x  = ((k .  f)  .  g)   x
h_12       =   k .  f  .  g   

{-
Main> :t h_1           -- idem para h_2 e h_3
h_1 :: Float -> Bool
Main> :t h_4
h_4 :: (a -> b) -> (c -> a) -> c -> b
Main> :t h_5
h_5 :: (a -> b) -> a -> b
Main> :t h_6
h_6 :: (a -> b) -> (c -> a) -> c -> b
Main> :t h_7
h_7 :: (a -> b) -> (c -> a) -> c -> b
Main>       

Main> :type h_8
h_8 :: (a -> b) -> (c -> a) -> (d -> c) -> d -> b

Main> :t h_9                            -- idem a h_10 e h_12
h_9 :: Float -> IO ()
Main> :t h_11
h_11 :: Float -> IO ()
-}
{-

Main>  h_2   5.678
True
Main>  h_3   5.678
True
Main>  h_1   5.678
True
Main>  h_1   5.678
True
Main>  h_1  5.4321
False
Main>  h_2  5.4321
False
Main>  h_3  5.4321
False
Main> h_4 f g 5.678 
True
Main> h_4 f g 5.4321
False
Main> h_5   5.4321
ERROR - Cannot infer instance
*** Instance   : Fractional (a -> b)
*** Expression : h_5 5.4321

Main> h_5 f (g 5.4321)
False
Main> h_5 f (g 5.678)
True
Main> 
ain> h_6 f g   5.678
True
Main> h_6 f g  5.4321
False
Main> h_7 f g  5.4321
False
Main> h_7 f g   5.678
True


Main> h_8  f  g  k  5.34
 É IMPAR
Main> h_8  f  g  k  5.84
 É um número PAR
Main> 
Main>  h_8  f  g  k  5.4321
 É IMPAR
Main>  h_8  f  g  k  5.678
 É um número PAR
Main>  h_9   5.678
 É um número PAR
Main>  h_9  5.4321
 É IMPAR
Main>  h_10  5.4321
 É IMPAR
Main>  h_11  5.4321
 É IMPAR
Main>  h_10   5.678
 É um número PAR
Main>  h_11   5.678
 É um número PAR
Main> 
Main>  h_12   5.678
 É um número PAR

-}

