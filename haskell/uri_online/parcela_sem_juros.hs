-- https://www.urionlinejudge.com.br/judge/en/problems/view/3060
-- AUTOR: https://gist.github.com/egydiopacheco/6bb4c60ce787d6bc71fa3836171bbf71
calcula :: Int -> Int -> [Int]
calcula pr pa = 
    lista1 ++ lista2
    where x = pr `div` pa
          y = pr `rem` pa
          lista1 = replicate y (x + 1)
          lista2 = replicate (pa - y) x

main::IO()
main = do
    preco    <- getLine
    parcelas <- getLine
    let pr = read preco :: Int
    let pa = read parcelas :: Int
    mapM_ print $ calcula pr pa