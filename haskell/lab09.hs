
import Char
------------------------------
{- Ver o conceito de currificacao -}


mult_2, mult_3, mult_4 :: Int -> Int
mult_2 n = 2*n
mult_3 n = 3*n
mult_4 n = 4*n

mult_g m n = (*) m n

-----------------------
dobro_lst :: [Int] -> [Int]
dobro_lst  l = mapear  mult_2  l
triplo_lst :: [Int] -> [Int]
triplo_lst  l = mapear  mult_3  l
-------------------------------
m_MULT m l = mapear ( mult_g m ) l
-- veja que aparentemente NAO hah o 2o. parametro em mult_g
-- isto serah avaliado preguicosamente :: depois
-------------------------------

mapear :: (a -> b) -> [a] -> [b]
mapear f [ ]  = [ ]
mapear f (a:b) = (f a) : (mapear f  b)

mapear_2  f  lista  = [ (f  a) | a <-  lista]


-------------------------------------------
{--
*Main> dobro_lst [3 .. 10]        
[6,8,10,12,14,16,18,20]
*Main> triplo_lst [3 .. 10]
[9,12,15,18,21,24,27,30]
*Main> mapear (mult_g 3) [3 .. 10]
[9,12,15,18,21,24,27,30]
*Main> m_MULT  3 [3 .. 10]        
[9,12,15,18,21,24,27,30]
--}

{--
*Main> (\x->(\y -> (x+y))) 3 4
7
*Main> (\x->(\y -> ((+) x y))) 3 4 
7
*Main> (\x->((\y -> ((+) x y))) 3) 4 
7
*Main> (\x->(((\y -> ((+) x y))) 3) 4)
7
*Main> ((\x->((\y -> ((+) x y))) 3) 4)
7
--}
