
import Char

dobro :: [Int] -> [Int]
dobro []    = []
dobro (a:b) = (2*a) : dobro   b

conv_maiusc :: String  -> String
conv_maiusc [ ] = [ ]
conv_maiusc (a:b) = toUpper  a : conv_maiusc b

retorna_nome :: [(Int,String)] -> [String]
retorna_nome []    = []
retorna_nome (a:b) = conv_maiusc (snd a) : retorna_nome b
--------------------------
par :: Int -> Bool
par a = a `mod`  2 == 0  -- ou mod a 2

somente_par :: [Int] -> [Int]
somente_par []   = []
somente_par (a:b)
            |par(a)    = a : (somente_par b)
            |otherwise = somente_par b

maior_15 :: [(String,Int)] -> [(String,Int)]
maior_15 [] = []
maior_15 (a:b)
       | (snd a) > 15  = a : (maior_15 b)
       | otherwise     = maior_15 b

------------------------
soma :: [Int] -> Int
soma [] = 0
soma (a:b) = a + (soma b)

gera_frase :: [String] -> String
gera_frase []    = ""
gera_frase (a:b) = a ++ (gera_frase b)
-----------------------------------------
vezes_2 :: [Int] -> [Int]
vezes_2 []    = []
vezes_2 (a:b) = (2*a) : vezes_2   b

vezes_3 :: [Int] -> [Int]
vezes_3 []    = []
vezes_3 (a:b) = (3*a) : vezes_3   b


vezes_4 :: [Int] -> [Int]
vezes_4 []    = []
vezes_4 (a:b) = (4*a) : vezes_4   b
------------------------------
mult_2, mult_3, mult_4 :: Int -> Int
mult_2 n = 2*n
mult_3 n = 3*n
mult_4 n = 4*n
-----------------------
mapear :: (a -> b) -> [a] -> [b]
mapear f [ ]  = [ ]
mapear f (a:b) = (f a) : (mapear f  b)

mapear_2  f  lista  = [ (f  a) | a <-  lista]

dobro_lst :: [Int] -> [Int]
dobro_lst  l = mapear  mult_2  l
triplo_lst :: [Int] -> [Int]
triplo_lst  l = mapear  mult_3  l
-------------------------------------------
-- FILTRAR

maior_1 :: [Int] -> [Int]
maior_1 [] = []
maior_1 (a:b)
       | a > 1    = a : (maior_1 b)
       |otherwise = maior_1   b


maior_2 :: [Int] -> [Int]
maior_2 [] = []
maior_2 (a:b)
       | a > 2    = a : (maior_1  b)
       |otherwise = maior_1   b


maior_3 :: [Int] -> [Int]
maior_3 [] = []
maior_3 (a:b)
       | a > 3    = a : (maior_1 b)
       |otherwise = maior_1   b


condicao_1, condicao_2, condicao_3 :: Int -> Bool
condicao_1 n = n > 1
condicao_2 n = n > 2
condicao_3 n = n > 3

maior_q_1 l = filtrar  condicao_1  l
maior_q_2 l = filtrar  condicao_2  l

filtrar :: (a -> Bool) -> [a] -> [a]
filtrar f []       = []
filtrar f (a:xs)
       | f   a  = a : filtrar f  xs     -- f a   é igual a: (f  a) == True
       | otherwise = filtrar f  xs


filtrar_2   f   lista = [ (f  a) | a <- lista]


mult_l :: [Int] -> Int
mult_l []   = 1
mult_l (a:b)= a * mult_l    b

soma_l :: [Int] -> Int
soma_l []   = 0
soma_l (a:b)= a + soma_l   b



concatena_L :: [String] -> String
concatena_L  []   = ""
concatena_L (a:b)= a ++ concatena_L  b


reduzir :: (a -> a -> a) -> [a] -> a
reduzir f [a]     = a
reduzir f (a:b) = f a (reduzir f  b)


mod_soma :: Num a => a -> a -> a
mod_soma a  b  = abs ( a + b)
---------------------------------
reduzird :: (a -> b -> b) -> b -> [a] -> b
reduzird f aux [ ]     = aux
reduzird f aux (a:b) = f a (reduzird  f  aux  b)

t1 = reduzird (\x y -> y+1) 0 [5,12,25,14]


reduzire :: (a -> b -> a) -> a -> [b] -> a
reduzire f  aux  [ ]    = aux
reduzire f  aux  (a:b) = reduzire f  (f  aux  a)  b


