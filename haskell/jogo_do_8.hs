module JOGO_8 where

import Array

{-- esta funcao, transforma uma lista para a forma matricial--}
mat x = listArray ((1,1),(3,3)) x

{-Funções que retornam somente lista da tupla, ou semente o pai do
nó, ou somente o nó atual respectivamente-}
lista :: ([Int],Int,Int)->[Int]
pai,nos :: ([Int],Int,Int)->Int

lista (a,b,c)  = a
pai   (a,b,c)  = b
nos   (a,b,c)  = c

{-estado final-}
lista_final :: [Int]
lista_final = [1,2,3,4,5,6,7,8,0]

{-x = lista que o usuário deseja encontrar a solução-}
jogo_8 :: [Int] -> IO()
jogo_8 x = imprime2 (caminho(busca [(x,0,0)] [(x,0,0)]))
jogo_82 x = busca [(x,0,0)] [(x,0,0)]

{-Função que recebe uma árvore em forma de lista e
devolve somente o ramo da árvore que encontrou a
solução final-}
caminho (a:b) = reverse (imprime (nos a) (a:b))

imprime a [] = []
imprime a (b:c)
                |a == nos(b) = lista b : imprime (pai b) c
                |otherwise  = imprime a c

busca :: [([Int],Int,Int)] -> [([Int],Int,Int)] -> [([Int],Int,Int)]
busca [] visitados = error "fracasso"
busca (no:subarvore) visitados
             | lista(no)  == lista_final = no:visitados
             | otherwise = busca (subarvore ++ visit) (visit ++ visitados)
                            where
                              visit = (insere 4 (maior (no:subarvore)) no visitados)

maior x = foldl (\x y -> if x>y then x else y) 0 (map nos x)

{-- faz uma busca em amplitude nó a nó, caso a lista que possui os
filhos estiver vazia, ocorrerá fracasso --}

{-- insere na lista de filhos, os novos filhos que ainda nao estao
na lista de visitados--}
--insere:: Int -> Int->  ([Int],Int,Int)-> [([Int],Int,Int)] -> [([Int],Int,Int)]
insere 0 y z w = []
insere x y (a,b,c) z  = (filho x (encontra (a,c,y+1)) z) ++
                                                  (insere (x-1) (y+1) (a,b,c) z)

{-- cria os filhos caso eles nao pertencam a lista de visitados--}

filho 1 ((a,b),c,d,e) y
        | (a+1>3)                           = []
        | (pertence (elems (c // [((a,b),(c!(a+1,b))),
                                             ((a+1,b),0)])) y) == [] = []
        | otherwise                         = [((elems (c // [((a,b),
                                         (c!(a+1,b))),((a+1,b),0)])),d,e)]

filho 2 ((a,b),c,d,e) y
        | b-1<1                             = []
        | (pertence (elems (c // [((a,b),(c!(a,b-1))),
                                             ((a,b-1),0)])) y) == [] = []
        | otherwise                         = [((elems (c // [((a,b),
                                         (c!(a,b-1))),((a,b-1),0)])),d,e)]

filho 3 ((a,b),c,d,e) y
        | b+1>3                             = []
        | (pertence (elems (c // [((a,b),(c!(a,b+1))),
                                             ((a,b+1),0)])) y) == [] = []
        | otherwise                         = [((elems (c // [((a,b),
                                         (c!(a,b+1))),((a,b+1),0)])),d,e)]

filho 4 ((a,b),c,d,e) y
        | (a-1)<1                           = []
        | (pertence (elems (c // [((a,b),(c!(a-1,b))),
                                             ((a-1,b),0)])) y) == [] = []
        | otherwise                         = [((elems (c // [((a,b),
                                         (c!(a-1,b))),((a-1,b),0)])),d,e)]


-- ---------------/Funcoes Auxiliares/----------------

{--encontra a posicao em coordenadas do 0(zero) na matriz--}

encontra   (x,y,z)
             | (encontra1 x) ==  1 = ((1,1), mat x,y,z)
             | (encontra1 x) ==  2 = ((1,2), mat x,y,z)
             | (encontra1 x) ==  3 = ((1,3), mat x,y,z)
             | (encontra1 x) ==  4 = ((2,1), mat x,y,z)
             | (encontra1 x) ==  5 = ((2,2), mat x,y,z)
             | (encontra1 x) ==  6 = ((2,3), mat x,y,z)
             | (encontra1 x) ==  7 = ((3,1), mat x,y,z)
             | (encontra1 x) ==  8 = ((3,2), mat x,y,z)
             | otherwise           = ((3,3), mat x,y,z)

{-- funcao auxiliar da funcao acima(encontra) --}

encontra1 [] = error "a lista nao possui 0"
encontra1 (a:x)
            |a == 0    = 1
            |otherwise =  1 + encontra1 x

{-esta funcao compara a lista corrente com a lista de visitados,
para ver se a lista corrente pertence a lista de visitados -}

pertence x  [] = x
pertence x (b:y)
                | x == lista (b) =[]
                | otherwise = pertence x y

-- Fuções de impressão --------------------

imprime2 :: [[Int]]->IO()
imprime2 []   = putStr "fim"
imprime2 (a:x)= do
         {
                  implista 0 a;
                  imprime2 x
         }

implista :: Int -> [Int]->IO()
implista x [a] = do
                      {
                   putStr " " ;
                   putStr (show a);
                   putStrLn "|";
                   putStrLn "-------" ;
                      }
implista 0 a   =   do
            {
                putStrLn "-------";
                putStr "|";
                implista 1 a
            }

implista x (a:b) |x==3 = do
                {
                putStr " " ;
                putStr (show a);
                putStrLn "|";
                putStr "|";
                implista (1) b
                 }

         | otherwise = do
                      {
                   if x==1 then putStr"" else putStr " ";
                   putStr (show a);
                   implista (x+1) b
                      }

