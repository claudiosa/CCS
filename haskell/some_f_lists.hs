n_esimo  _ [] = error "EMPTY LIST"
n_esimo n _ | n <= 0 = error "negative number or invalid index"
n_esimo 1 (a:_) = a
n_esimo n (a:b) = n_esimo (n-1) b


{-fun��o para verificar se o n�mero � primo-}
eh_primo :: Int -> Bool
eh_primo 0  =  False
eh_primo 1  =  True
eh_primo n
        |(n_divisiveis n n == 2)   = True
        | otherwise         = False

{-fun��o que encontra por quantos n�meros o n�mero passado como
par�metro � divis�vel. -}
n_divisiveis :: Int-> Int-> Int
n_divisiveis a 1   = 1
n_divisiveis a b
        |(mod a b == 0) = 1 + n_divisiveis a (b-1)
        |otherwise      = n_divisiveis a (b-1)

{-fun��o que encontra o primeiro n�mero primo na lista-}
primeiro_primo :: [Int] -> Int
primeiro_primo (x:xs) | eh_primo x = x
        | otherwise = primeiro_primo xs
