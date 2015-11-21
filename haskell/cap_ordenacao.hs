--Ordenação por Seleção

ordsel :: (Ord a) => [a] -> [a]
ordsel [] = []
ordsel x  = m : ordsel (remove m x)
              where
                m = minimo x

remove :: Ord a => a -> [a] -> [a]
remove m [] = []
remove m (x:xs)
                |x == m    = xs
                |otherwise = x : (remove m xs)

minimo :: Ord a => [a] -> a
minimo [xs] = xs
minimo (x:xs) = if  x < (minimo xs) then x else minimo xs

--

ordsel_2 :: (Ord a) => [a] -> [a]
ordsel_2 []     = []
ordsel_2 (x:xs) = m : (ordsel_2 resto)
              where
                (m,resto) = selec x xs

selec :: (Ord a) => a -> [a] -> (a,[a])
selec x []     = (x, [])
selec x (y:ys) = (sel , m:resto)
             where
               m = max x y
               (sel, resto) = selec (min x y) ys
	       
--

ordsel_3 :: (Ord a) => [a] -> [a]
ordsel_3 []     = []
ordsel_3 (x:xs) = menor_primeiro xs x []

menor_primeiro :: (Ord a) => [a] -> a -> [a] -> [a]
menor_primeiro [] m r    = m : (ordsel_3 r)
menor_primeiro(x:xs) m r = if x < m
                           then menor_primeiro xs x (m:r)
                           else menor_primeiro xs m (x:r)
			   
--Ordenação por Inserção
ordins :: (Ord a) => [a] -> [a]
ordins []     = []
ordins (a:xs) = inserir a (ordins xs)

inserir :: (Ord a) => a -> [a] -> [a]
inserir x xs = takeWhile ((>=) x) xs ++ [x] ++
               dropWhile ((>=) x) xs
	       
--

ordins_2 :: (Ord a) => [a] -> [a]
ordins_2 x = foldr inserir [] x

--

inserir_2 :: (Ord a) => a -> [a] -> [a]
inserir_2 chave []     = [chave]
inserir_2 chave (x:xs) | chave <= x = chave:x:xs
                       | otherwise  = x:(inserir_2 chave xs)
		       
ordins_3 :: (Ord a) => [a] -> [a]
ordins_3 []     = []
ordins_3 (a:xs) = inserir_2 a (ordins xs)

--MergeSort

mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs |tamanho >= 1  = merge (mergeSort comeco) (mergeSort fim)
               where
                       tamanho  = length xs `div` 2
                       comeco   = take tamanho xs
                       fim      = drop tamanho xs

merge xs []     = xs
merge [] ys     = ys
merge (x : xs) (y : ys)
    | x <= y    = x : merge xs (y : ys)
    | x > y     = y : merge (x : xs) ys
    
--Quicksort

qsort []     = []
qsort (x:xs) = qsort elts_esquerdo_x ++ [x] ++ qsort elts_direito_x
         where
           elts_esquerdo_x   = [y | y <- xs, y < x]
           elts_direito_x    = [y | y <- xs, y >= x]