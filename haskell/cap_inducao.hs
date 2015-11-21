soma a b = a + b


fib 0 = 0
fib 1 = 1
fib n = soma (fib (n-1))  (fib (n-2))    --  Equivalente a: fib (n-1) + fib (n-2) 

--seq = [x | x <- fib \y, \y < 10]

{- 
f x y z | (x > 7) = 789 
f x y z | (y < 7) = 789
f x y z | (z == 7) = 789
        | otherwise = 0 


g  x y z | (x > 7) || (y < 7) || (z == 7) = 789
         | otherwise = 0


h  x _ _ | (x > 7) = 789
h  _ y _ | (y < 7) = 789
h  _ _ z | (z == 7) = 789
         | otherwise = 0
	
	
 -}
f x y z | (x == 7) = 10
f x y z | (y == 8) = 20
f x y z | (z == 9) = 30
        | otherwise = 0 


g 7 y z  = 10
g x 8 z  = 20
g x y 9  = 30
g x y z  | (x /= 7) || (y /= 8) || (z /= 9)  = 0
	
	
h  7 _ _  = 10
h  _ 8 _  = 20
h  _ _ 9  = 30
h  _  _ _ = 0




	
{-   EXECUCAO

Main> f 7 8 9
10
Main> f 17 8 9
20
Main> f 17 18 9
30
Main> f 17 18 19
0
Main> g 7 8 9
10
Main> g 17 8 9
20
Main> g 17 18 9
30
Main> g 17 18 19
0
Main> h 7 8 9
10
Main> h 17 8 9
20
Main> h 17 18 9
30
Main> h 17 18 19
0
Main>            

-}
{- multi_7 x |(x>=1) && (x<=6) = 0
          |otherwise        = 1 + multi_7 (x-7)
-}


multi_7 x | (x<1) && (x>7) =  1 + multi_7 (x-7)
multi_7   7   =  1
multi_7 _ = 0

{- Avaliação preguiçosa ... pagina 48 -}
menor a b
   | a > b = b
   | otherwise = a



aux0 = (\d -> d+d) ((\t -> 3*t) (menor 8 9))
aux1 x y = (\d -> d+d) ((\t -> 3*t) (menor x y))
aux2 = (\d -> d+d) ( (\t -> 3 * t ) ( (\x -> \y ->  menor x y ) 8 9) )
aux3 =  ((\x -> \y -> menor x y) 8 9)
