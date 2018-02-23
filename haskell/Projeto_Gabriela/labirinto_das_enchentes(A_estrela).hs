{- Gabriela Thumé - Inteligência Artificial 10/05/2011

   Busca A*

   Problema do labirinto: estado inicial: (1,1)
	                  estado final: (16,16)

   Uso: $ ghci
	Prelude> :load labirinto_das_enchentes(A_estrela).hs
	*LABIRINTO> inicio

   Saida:
		             BUSCA A*

	Faz uma busca em largura, porem expande primeiro o no com menor custo (de acordo com a distancia de manhattan) em relacao a raiz + em relacao ao destino, e garante assim que a primeira solucao encontrada eh a melhor solucao em relacao a origem e ao destino. Cuidando que a ordenacao seja pelo maior custo entre a raiz e o destino entre o no e o seu pai.

	[(1,1),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(3,7),(4,7),(5,7),(6,7),(7,7),(8,7),(9,7),(9,6),(10,6),(11,6),(12,6),(13,6),(14,6),(15,6),(16,6),(16,7),(16,8),(16,9),(16,10),(16,11),(16,12),(16,13),(16,14),(16,15),(16,16)]



	  X                                                                             
	  X    X    X    X    X    X    X                                               
	     |||||               |||||  X                                               
	     |||||               |||||  X                                               
	-----|||||               |||||--------------------||||||||||||||||||||||||||||||
	     |||||               |||||  X                 -----                         
	     |||||||||||||||||||||||||  X                 -----                         
		       -----            X                 -----                         
		       -----       X    X                 -----                         
		       -----       X  |||||||||||||||||||||||||                         
		       -----       X                      |||||-------------------------
		       -----       X                      |||||                         
		       -----       X                      |||||                         
		       -----       X  |||||||||||||||||||||||||                         
		       -----       X                                                    
		       -----       X    X    X    X    X    X    X    X    X    X    X  

	Custo total da travessia:37

-}


module LABIRINTO where

import IO
import System


-- função que verifica se uma tupla faz parte de uma lista de tuplas
member (x,y, n1) [] = False
member (x,y, n1) ((q,w, n2):ws)
	| (y==w) && (x==q) = True 
	| otherwise = member (x,y,n1) ws

-- função que calcula o custo de um caminho, baseado na tabela de custos (final do arquivo)
custo_total [] = 0
custo_total ((x,y):ws) = (custo(x,y) + custo_total ws)

-- Percorre o caminho final
caminho (((x,y), filho, n2):xs) = [(filho)]++encontra (x,y) xs

encontra _ [] = []
encontra (x,y) (((x3,y3),(x2,y2),n2):xs)
	| (x == x2) && (y == y2) = [(x2,y2)]++(encontra (x3,y3) xs)
	| otherwise = encontra (x,y) xs

{-caminho [] = []
caminho ((pai, filho, n2):xs) = [(filho)]++caminho xs
-}
final :: ((Int, Int), (Int, Int), Int) -> Bool
-- se for a configuração (16,16), então o nó é final!
final (pai, (x,y), n)
	| (x,y)==(16,16) = True
	| otherwise = False


inicio = 
	do{
		putStr "                     BUSCA A*"; putStr "\n"; putStr "\n";
		putStr "Faz uma busca em largura, porem expande primeiro o no com menor custo (de acordo com a distancia de manhattan) em relacao a raiz + em relacao ao destino, e garante assim que a primeira solucao encontrada eh a melhor solucao em relacao a origem e ao destino. Cuidando que a ordenacao seja pelo maior custo entre a raiz e o destino entre o no e o seu pai."; putStr "\n"; putStr "\n";	
		print(reverse(caminho(anda [((1,1),(1,1),0)] [])));
	        imprime (reverse(caminho(anda [((1,1),(1,1),0)] []))); 
		putStr "Custo total da travessia:";
		print(custo_total (caminho(anda [((1,1),(1,1),0)] []))); putStr "\n";
       }

ordena [] = []
ordena (x:xs) = insere x (ordena xs)

insere (pai,(x,y), cust) [] = [(pai,(x,y), cust)]
insere (pai,(x,y), cust) ((pai2,(x2,y2), cust2):xs)
	| (cust < cust2) = [(pai,(x,y),cust)]++((pai2,(x2,y2),cust2):xs) 
	| otherwise = [(pai2,(x2,y2),cust2)]++insere (pai,(x,y),cust) xs

-- Busca em largura, porém ordena a expansão do nó corrente.

anda [] lclosed = lclosed
anda (no:xs) lclosed
   	| final no  == True = [no]++lclosed
        | (not(member no xs)) = anda ((ordena (expande 1 [no] lclosed))++(ordena xs)) ([no]++lclosed)
        | otherwise = anda (ordena xs) lclosed

expande :: Int -> [((Int, Int), (Int, Int), Int)] -> [((Int, Int), (Int, Int), Int)] -> [((Int, Int), (Int, Int), Int)]
expande 5 _ _ = []
expande y ((pai,filho,cust):lopen) lclosed	
	| not((acao y filho) == (0,0))  && not(member (filho,acao y filho,0) lopen) && not(member (filho,acao y filho,0) lclosed)  =  
	[(filho,(acao y filho), (calcula_custo(caminho ([(filho,(acao y filho),0)]++[(pai,filho,0)]++lclosed))))]++(expande (y+1) ((pai,filho,cust):lopen) lclosed)
	| otherwise =  (expande (y+1) ((pai,filho,cust):lopen) lclosed)
-- && (custo_total ((pai):lopen) <=  calcula_custo(filho))

calcula_custo ((x,y):xs) = custo_total ((x,y):xs) + calcula_manhattan (x,y)

calcula_manhattan (x,y) = (16-x)+(16-y)



acao 3 (x,y) 
	| ((custo (x,(y+1)) == 1) || (custo (x,(y+1)) == 5)) && (y<16) = (x,(y+1))
   	| otherwise = (0,0)

acao 4 (x,y) 
	| ((custo ((x+1),y) == 1) || (custo ((x+1),y) == 5)) && (x<16) = ((x+1),y)
	| otherwise = (0,0)

acao 1 (x,y) 
	| ((custo (x,(y-1)) == 1) || (custo (x,(y-1)) == 5)) && (y>1) = (x,(y-1))
	| otherwise = (0,0)

acao 2 (x,y)
	| ((custo ((x-1),y) == 1) || (custo ((x-1),y) == 5)) && (x>1) = ((x-1),y)
	| otherwise = (0,0)

-- Funcao que responde qual é o custo daquela posição:
-- Se for um rio, o custo é 5
-- Se for um obstaculo, 99, para demonstrar que não há como passar por alí
-- Se estiver livre, o custo é 1
custo (x,y)
	-- Rios
	| (x,y) == (5,1) ||
          (x,y) == (5,7) || (x,y) == (5,8) || (x,y) == (5,9) || (x,y) == (5,10) || 
          (x,y) == (8,4) || (x,y) == (9,4) || (x,y) == (10,4) || (x,y) == (11,4) || (x,y) == (12,4) || (x,y) == (13,4) || (x,y) == (14,4) || (x,y) == (15,4) || (x,y) == (16,4) ||
          (x,y) == (6,11) || (x,y) == (7,11) || (x,y) == (8,11) || (x,y) == (9,11) || 
          (x,y) == (11,12) || (x,y) == (11,13) || (x,y) == (11,14) || (x,y) == (11,15) || (x,y) == (11,16) = 5
	-- Obstaculo em formato U da esquerda
	| (x,y) == (3,2) || (x,y) == (4,2) || (x,y) == (5,2) || (x,y) == (6,2) || (x,y) == (7,2) ||
          (x,y) == (7,3) || (x,y) == (7,4) || (x,y) == (7,5) || (x,y) == (7,6) || 
          (x,y) == (3,6) || (x,y) == (4,6) || (x,y) == (5,6) || (x,y) == (6,6) = 99
	--Obstaculo em formato - da direita 
  	| (x,y) == (5,11) || (x,y) == (5,12) || (x,y) == (5,13) || (x,y) == (5,14) || (x,y) == (5,15) || (x,y) == (5,16) = 99
	--Obstaculo em formato de C ao contrário, em baixo
  	| (x,y) == (14,7) || (x,y) == (14,8)  || (x,y) == (14,9) || (x,y) == (14,10) || (x,y) == (14,11) || 
          (x,y) == (13,11) || (x,y) == (12,11) || (x,y) == (11,11) || (x,y) == (10,11) ||
          (x,y) == (10,7)  || (x,y) == (10,8)   || (x,y) == (10,9)  || (x,y) == (10,10) = 99
	| otherwise = 1

pertence (x,y) [] = False
pertence (x,y) ((q,w):ws)
	| (x == q) && (y == w) = True 
	| otherwise = pertence (x,y) ws

imp (x,y)
	| (custo (x,y)) == 5 = putStr "-----"
	| (custo (x,y)) == 99 = putStr "|||||"
	| (custo (x,y)) == 1 =  putStr  "  X  "

impMap (x,y)
	| (custo (x,y)) == 5 = putStr "-----"
	| (custo (x,y)) == 99 = putStr "|||||"
	| (custo (x,y)) == 1 = putStr "     " 

imprime :: (Num t, Num t1, Ord t, Ord t1) => [(t, t1)] -> IO ()
imprime caminha = do{ putStr "\n"; putStr "\n"; putStr "\n"; mapa (1,1) caminha;}

mapa (x,y) [] = putStr ""
mapa (x,y) caminha
   | (pertence (x,y) caminha) && (y < 16)= do{ imp (x,y); mapa (x,y+1) caminha;}
   | not(pertence (x,y) caminha) && (y < 16)= do{ impMap (x,y); mapa (x,y+1) caminha;}
   | (pertence (x,y) caminha) && (y==16) && (x < 16) = do{imp (x,y);  putStr "\n";  mapa (x+1,1) caminha;}
   | not(pertence (x,y) caminha) && (y==16) && (x < 16) = do{impMap (x,y);  putStr "\n";  mapa (x+1,1) caminha;}
   | (pertence (x,y) caminha) && (y==16) && (x == 16) = do{ imp (x,y); putStr "\n";  putStr "\n";}
   | not(pertence (x,y) caminha) && (y==16) && (x == 16) = do{impMap (x,y);  putStr "\n";  putStr "\n";}
