{-função para verificar se o número é primo-}
eh_primo :: Int -> Bool
eh_primo 0  =  False
eh_primo 1  =  True
eh_primo n
         |(n_divisiveis n n == 2)   = True
	 | otherwise         = False
			
{-função que encontra por quantos números o número passado como
parâmetro é divisível. -}
n_divisiveis :: Int-> Int-> Int
n_divisiveis a 1   = 1
n_divisiveis a b
         |(mod a b == 0) = 1 + n_divisiveis a (b-1)
	 |otherwise      = n_divisiveis a (b-1)
			
{-função que encontra o primeiro número primo na lista-}
primeiro_primo :: [Int] -> Int
primeiro_primo (x:xs) | eh_primo x = x
                      | otherwise = primeiro_primo xs
