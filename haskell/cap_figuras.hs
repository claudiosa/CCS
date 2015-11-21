
losango = ["....#....",
           "...###...",
           "..#####..",
           "...###...",
           "....#...."]
	   
concatena :: [a] -> [a] -> [a]
concatena [] lista_2  =  lista_2
concatena (a:b) lista_2 = a : concatena b lista_2 


inverte_1 :: [a] -> [a]
inverte_1 []     =  []
inverte_1 (x:xs) =  concatena ( inverte_1 xs ) [x]

type Figura = [[Char]]   -- [String]

cavalo :: Figura
cavalo = [
          ".......##..." ,
         ".....##..#.." ,
         "...##.....#." ,
         "..#.......#." ,
         "..#...#...#." ,
         "..#...###.#." ,
         ".#....#..##." ,
         "..#...#....." ,
         "...#...#...." ,
         "....#..#...." ,
         ".....#.#...." ,
         "......##...." ]
	 
imp_cavalo :: [[Char]] -> IO ()
imp_cavalo [] = putStr  "................."
imp_cavalo (c:resto) = do {
                               putStr c;
                               putStr "\n";
                               imp_cavalo resto
                           }	 
	 
imp_cavalo2 :: [[Char]] -> IO ()
imp_cavalo2 x= putStr(reduzir (\x y-> x ++ "\n" ++ y )  x)

-- auxiliar
reduzir :: (a -> a -> a) -> [a] -> a
reduzir f [a]     = a
reduzir f (a:b) = f a (reduzir f  b)

mapear :: (a -> b) -> [a] -> [b]
mapear f [ ]  = [ ]
mapear f (a:b) = (f a) : (mapear f  b)
-------------------------------------------------------------

inverte_vertical :: Figura -> Figura
inverte_vertical = mapear inverte_1
inv_vert_2  :: Figura -> Figura
inv_vert_2  x  = mapear inverte_1 x

inverte_horizontal :: Figura -> Figura
inverte_horizontal = inverte_1


translada_1 :: Figura -> Figura
translada_1 = inverte_vertical . inverte_horizontal


translada_2, translada_3 :: Figura -> Figura
translada_2 x = inverte_horizontal  (inverte_vertical x)
translada_3 x = inverte_horizontal  (inverte_vertical  x)

inverte_cor :: Figura -> Figura
inverte_cor = map (map troca_cor)

troca_cor :: Char -> Char
troca_cor ch = if ch == '.' then '#' else '.'

zoom :: Figura -> Figura
zoom [] = []
zoom (a:b) = duplica a : duplica a : zoom b

duplica :: String -> String
duplica [] = []
duplica (a:b) = a : a : duplica b

acima, acima_2 :: Figura -> Figura -> Figura
acima = concatena   
acima_2 x y = concatena x y
--------------
zipa_lista :: (a -> b -> c) -> [a] -> [b] -> [c]
zipa_lista f [a]  [c] = f a c : []
--zipa_lista f (a:b)  (c:[]) = f a c : []
zipa_lista f (a:b) (c:d) = f a c :  (zipa_lista f  b d)

lado_a_lado :: Figura -> Figura -> Figura
lado_a_lado =  zipa_lista concatena

-----
sobreposicao :: Figura -> Figura -> Figura
sobreposicao = zipa_lista (zipa_lista  sobrepoe_letra)

sobrepoe_letra :: Char -> Char -> Char
sobrepoe_letra c d = if c=='#' then '#' else d
