-- GABARITO SEGUNDA PROVA LPG3 2007/02

import Char (toUpper)
import Char (toLower,isDigit,ord,chr)
import Observe


reduzir :: (a -> a -> a) -> [a] -> a
reduzir f [a] = a
reduzir f (a:b:x) = f a (reduzir f (b:x))

mapear :: (a -> b) -> [a] -> [b]
mapear f [] = []
mapear f (a:x) = (f a) : (mapear f x)


filtrar :: (a -> Bool) -> [a] -> [a]
filtrar f [] = []
filtrar f (a:x)
	|(f a)==True = a : filtrar f x
	|otherwise = filtrar f x

-- questão 1a

soma :: [String] -> Int
soma (a:b) = length (reduzir (++) (a:b))

-- implementação alternativa
soma_comp:: [String] -> Int
soma_comp (a:b) = reduzir (+) (mapear length (a:b))

-- questão 1b

inicia_letra:: Char -> String -> Bool
inicia_letra a (h:t)
	| a == h = True
	| otherwise = False

filtra_palavra x (a:b) = filtrar (inicia_letra x) (a:b)


-- questão 1c


inverte_str :: [Char] -> [Char] 
inverte_str [] = []
inverte_str (letra:resto)
	|(letra == (toUpper letra)) = toLower letra : inverte_str resto
	|otherwise = toUpper letra : inverte_str resto

inverte :: [[Char]] -> [[Char]] 
inverte (a:b) = map inverte_str (a:b)

-- questão 2

conta_moed:: Int -> [Int] -> Int
conta_moed x [] = 0
conta_moed x (a:b) 
		| x == a = 1 + conta_moed x b
		| otherwise = conta_moed x b


ret_num_moeda:: [Int] -> [(Int, Int)]
ret_num_moeda [] = []
ret_num_moeda (a:b) 
		| a == 5 || a == 10 || a == 25 || a == 50 =  (a , conta_moed a (a:b)): ret_num_moeda (filter (/= a) (a:b))
		| otherwise = error "moeda invalida!"


-- questão 3 - implementação em alta ordem

separe :: String -> (String,String)
separe a = ((filter verifica_letra a) , (filter verifica_num a ))


verifica_letra:: Char -> Bool
verifica_letra a | isDigit a == True = False
		 | otherwise = True

verifica_num :: Char -> Bool
verifica_num x = isDigit x

-- questão 3 - implementação geral

separe2 :: String -> (String,String)
separe2 a = ( (retorna_str a), (retorna_num a) )

retorna_num :: String -> String
retorna_num [] = []
retorna_num (a:resto)
	|(verifica_num2 a) == True = a : retorna_num resto
	|otherwise = retorna_num resto

retorna_str :: String -> String
retorna_str [] = []
retorna_str (a:resto)
	|(verifica_num2 a) == False = a : retorna_str resto
	|otherwise = retorna_str resto

{-- Versão  alternativa
verifica_num :: Char -> Bool
verifica_num a = if (a =='0' || a=='1' ||a=='2' ||a=='3' ||a=='4' ||a=='5' ||a=='6' ||a=='7' ||a=='8' ||a=='9')
		then True else False
--}

verifica_num2 :: Char -> Bool
verifica_num2 x = isDigit x

-- questão 4

imagem :: [[Char]] -> [(Int, Int)]
imagem (a:b) = imagem_aux (a:b) 1

imagem_aux :: [[Char]] -> Int -> [(Int, Int)]
imagem_aux [] _ = []
imagem_aux (a:b) x =  (retorna_asteristicos a x 1) ++ (imagem_aux b (x+1))

retorna_asteristicos :: [Char] -> Int -> Int -> [(Int, Int)]
retorna_asteristicos [] _ _ = []
retorna_asteristicos (a:b) x y
   | a == '*' = (x,y) : retorna_asteristicos b x (y+1)
   | otherwise = retorna_asteristicos b x (y+1)

-- questão 5


concatena [] a = a
concatena (x:y) a = x: concatena y a


inverte_pal [] = []
inverte_pal (a:b) = concatena (inverte_pal b) [a]

invert_all (a:b) = inverte_pal (mapear inverte_pal (a:b))

-- questão 6
{- ITEM E::
(filtrar p . mapear f) lista = (mapear f . filtrar (p . f)  lista))
-}

x5 = filtrar (> 7) . mapear (+1) [3 .. 7]
