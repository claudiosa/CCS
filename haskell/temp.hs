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

-- 4a. questao ... Marlos

--eh_asterisco :: Char -> Bool
eh_asterisco (c:[])
   | c == '*' = True
   | otherwise = False
 
map_pos :: (Num a, Num b) => (c -> Bool) -> [c] -> [(a,b)]  
map_pos f l = aux f l 0 0 

aux :: (Num a, Num b) => (c -> Bool) -> [c] -> a -> b -> [(a,b)]
aux f []  _ _ = []
---aux f ([]:x) _ coluna = aux f x 0 (coluna+1) -- mudança de linha....
aux f (a:b:c) linha coluna 
        | f a == True = (linha,coluna) : aux f (b:c) (linha + 1) coluna   
        | otherwise = aux  f (b:c) linha (coluna+1)

posicoes_ast = map_pos (eh_asterisco) imagem

imagem = ["........*........",
                    ".......***......",
                    ".........*........",
                    "...................."]

-- questão 6
{- ITEM E::
Um parentese no lugar errado, o correto é:
(filtrar p . mapear f) lista = (mapear f . filtrar (p . f))  lista
-}

x5 =  (filtrar (> 9) . mapear (+ 1)) [3 .. 17] 

y5 = (mapear  (+ 1) . filtrar  ((> 9) . (+ 1)))   [3 .. 17]
{-
Main> y5
[10,11,12,13,14,15,16,17,18]
Main> x5
[10,11,12,13,14,15,16,17,18]
Main> 
-}
--x51 =  observe "filtrar" ( filtrar (> 9) . (mapear (+ 1)) [3 .. 17])

y51 = (mapear  (+ 1) . filtrar  ((> 9) . (+ 1)))   [3 .. 17]
