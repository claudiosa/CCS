import Observe


lista [] = True           -- função 1
lista (a:x)= lista x     -- função 2


primeiros  0  _      = []
primeiros  _  []     = []
primeiros  n  (a:x)  = a  :  primeiros (n-1)    x 

rem_ultimo  [ _ ]    =  []
rem_ultimo (a:corpo) = observe "a" a : observe "rem_ultimo" rem_ultimo corpo

constroi_lista = [ x*x | x <- [9 .. 39], par x]

par :: Int -> Bool
par x =  mod  x  2 == 0



l1 = [ a | a <-[9 .. 90],  a < 100]
l2 = ['a' .. 'g'] 


-- zipar :: [Char] -> [Int] -> [(Char, Int)]
zipar (a:b) (x:y) = (a,x) : zipar b y
zipar  _      _   = []


concatena :: [a] -> [a] -> [a]
concatena [ ]  ys     =  ys
concatena (x : xs) ys =  x : concatena  xs  ys

{-------------------------------------}

menor [a] = a
menor (a:c) | a < (menor c) = a
            | otherwise = menor c

remove_menor [a] = []
remove_menor (a:c)
             | a == (menor (a:c)) = c
             | otherwise = a : remove_menor c


ordena_lista [] = []
ordena_lista [a] = [a]
ordena_lista l   = (menor l) : (ordena_lista (remove_menor l))
{-------------------------------------------------------------}

menor_2 [a] = a
menor_2 [a,b]
        | a < b = a
	| otherwise = b
menor_2 (a:b:c) 
        | a < b = menor (a:c)
        | otherwise = menor (b:c)

remove_2 _ [] = []
remove_2 m [a] 
       | m == a = []
       | otherwise = error "O menor valor não está na lista ! " 
remove_2 m (b:c)
           | m == b = c
	   | otherwise = b : remove_2  m  c


ordena_2 [] = []
ordena_2 [a] = [a]
ordena_2  l   = (menor_2 l) : ordena_2 (remove_2 (menor_2 l) l )
