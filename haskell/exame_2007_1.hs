-- EXAME LPG 3 2007/01

-- Questão 1 - MDC

mdc a 0   = a
mdc a b   = (mdc b (mod a b))


-- Questão 2 - Aplicação do MDc em uma lista

mdc_lista [a] = a
mdc_lista (a:b:c) = mdc_lista ((mdc a b):c)

-- Questão 3 - funções generalizadoras

reduzir :: (a -> a -> a) -> [a] -> a
reduzir f [a] = a
reduzir f (a:b:x) = f a (reduzir f (b:x))

mapear :: (a -> b) -> [a] -> [b]
mapear f [] = []
mapear f (a:x) = (f a) : (mapear f x)


filtrar::(a -> Bool) -> [a] -> [a] 
filtrar f [] = []
filtrar f (a:x)
	|(f a)==True = a : filtrar f x
	|otherwise = filtrar f x


f_x n = (n*n) - 100

-- map f_x (a:b)

-- filter (> 50) (a:b)

div_2 n | mod n 2 == 0 = True
	| otherwise = False


-- map (+) (filter (div_2) (a:b))

-- questão 4 - diferença simétrica


existe :: Int -> [Int] -> Bool
existe _ [] = False
existe a (b:c)
       | a == b = True
       | otherwise = existe a c


intersec (a:b) [] = []
intersec (a:b) (c:d) | existe c (a:b) == True = c: intersec (a:b) d
		     | otherwise = intersec  (a:b) d


remove :: [Int] -> [Int] -> [Int]
remove (c:d) [] = []
remove (c:d) (a:b)
       | existe a (c:d) = remove (c:d) b
       | otherwise = a : remove (c:d) b

uniao [] [] = []
uniao [] (c:d) = (c:d)
uniao (a:b) [] = (a:b)
uniao (a:b) (c:d) | a == c = a : uniao b d
		  | otherwise = a: c: uniao b d

dif_sim (a:b) (c:d) = remove  (intersec (a:b) (c:d))  (uniao (a:b) (c:d))
 



-- Questão 5 - posições de um char

posicoes2:: Char -> [Char] -> Int -> [Int]
posicoes2 x [] n = []
posicoes2 x (a:b) n | x == a = n : posicoes2 x b (n+1) 
		    | otherwise = posicoes2 x b (n+1)

posicoes:: Char -> [Char] -> [Int]
posicoes x (a:b) = posicoes2 x (a:b) 




-- Questão 7

substring2:: [Char] -> [Char] -> Bool
substring2 [] [] = True
substring2 [] (c:d) = True
substring2 (a:b) [] = False
substring2 (a:b) (c:d) | a == c = substring2 b d
		      | otherwise = False


substring:: [Char] -> [Char] -> Bool
substring (a:b) [] = False
substring (a:b) (c:d) | substring2 (a:b) (c:d) == True = True
		      | otherwise = substring (a:b) d