import Array

vet :: Array Int Char
vet = array (1,6) [(1,'b'),(2,'r'),(3,'a'),(4,'s'),(5,'i'),(6,'l')]


quad_array :: Int -> Array Int Int
quad_array n = array (0,n) [(i,i*i) | i <-[0..n]]


histograma (inf,sup) xs = atualHist (array (inf,sup) [(i,0) | i <- [inf..sup]]) xs

atualHist hist []    = hist
atualHist hist (x:xs) = atualHist (hist //[(x, hist!x +1)]) xs


--funcao que calcula a determinante de uma matriz pela regra de Sarrus

determinante x = (x ! (1,1) * x ! (2,2) * x ! (3,3)) + (x ! (1,2) * x ! (2,3) * x ! (3,1)) +
                 (x ! (1,3) * x ! (2,1) * x ! (3,2)) - (x ! (3,1) * x ! (2,2) * x ! (1,3)) -
                 (x ! (3,2) * x ! (2,3) * x ! (1,1)) - (x ! (3,3) * x ! (2,1) * x ! (1,2))

matriz x = listArray ((1,1),(3,3)) x     --construtor da matriz
