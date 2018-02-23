{- Gabriela Thumé - Inteligência Artificial 18/04/2011

   Busca em largura

   Problema do labirinto: estado inicial: (1,1)
	                  estado final: (16,16)

   Uso: $ ghci
	Prelude> :load labirinto_das_enchentes(busca_largura).hs
	*LABIRINTO> inicio

   Saida:
		             BUSCA EM LARGURA

	Faz uma busca em largura, expandindo cada nivel antes de expandir os nos do proximo

	[(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(15,2),(15,3),(15,4),(15,5),(15,6),(15,7),(15,8),(15,9),(15,10),(15,11),(15,12),(15,13),(15,14),(15,15),(15,16),(16,16)]



	  X                                                                             
	  X                                                                             
	  X  |||||               |||||                                                  
	  X  |||||               |||||                                                  
	-----|||||               |||||--------------------||||||||||||||||||||||||||||||
	  X  |||||               |||||                    -----                         
	  X  |||||||||||||||||||||||||                    -----                         
	  X            -----                              -----                         
	  X            -----                              -----                         
	  X            -----          |||||||||||||||||||||||||                         
	  X            -----                              |||||-------------------------
	  X            -----                              |||||                         
	  X            -----                              |||||                         
	  X            -----          |||||||||||||||||||||||||                         
	  X    X    X  -----  X    X    X    X    X    X    X    X    X    X    X    X  
		       -----                                                         X  

	Custo total da travessia:39


-}

module LABIRINTO where

import IO
import System

member (pai,(x,y)) [] = False
member (pai,(x,y)) ((paizao,(q,w)):ws)
	| (x == q) && (y == w) = True 
	| otherwise = member (pai,(x,y)) ws

adiciona (x,y) [] = [(x,y)]
adiciona (x,y) (w:ws) = w: adiciona (x,y) ws

-- Função para encontrar o ramo da árvore explorado (retorna os pais de cada nó), a partir de um caminho
encontra _ [] = []
encontra (x,y) ((pai,(x2,y2)):xs)
	| (x == x2) && (y == y2) = [(x2,y2)]++encontra pai xs
	| otherwise = encontra (x,y) xs

-- Percorre o caminho final
caminho ((pai, filho):xs) = [(filho)]++encontra pai xs

custo_total [] = 0
custo_total ((x,y):ws) = (custo(x,y) + custo_total ws)

--inicio = reverse(caminho(anda [((1,1),(1,1))] []))

inicio = 
	do{
		putStr "                     BUSCA EM LARGURA"; putStr "\n"; putStr "\n";
		putStr "Faz uma busca em largura, expandindo cada nivel antes de expandir os nos do proximo"; 
		putStr "\n"; putStr "\n";	
		print(reverse(caminho(anda [((1,1),(1,1))] [])));
		imprime (reverse(caminho(anda [((1,1),(1,1))] [])));
		putStr "Custo total da travessia:";
		print(custo_total (caminho(anda [((1,1),(1,1))] []))); putStr "\n";
	}


-- se não há mais nós a serem visitados e nenhum já encontrado foi final, o problema não tem solução
anda [] lclosed = error "Nao tem solucao"
-- busca com lopen(lista corrente de nós abertos) e lclosed(nós já visitados não finais)
anda (no:xs) lclosed
-- se o nó em questão é final, então retorna o nó e os já visitados para procurar qual foi o caminho percorrido
   	| final no  == True = [no]++lclosed
-- se não é final, expande o nó e o adiciona nos nós já visitados
     	| xs==[] = anda ((expande 5 [no] lclosed)) ([no]++lclosed)
        | (not(member no xs)) = anda (xs++(expande 5 [no] lclosed)) ([no]++lclosed)
        | otherwise = anda xs lclosed
--	| otherwise = anda (xs++(expande 5 [no] lclosed)) ([no]++lclosed)

-- expande o nó em filhos resultantes das ações que ainda não estão na lista de nós já visitados
expande 1 _ _ = []
expande y ((pai,filho):lopen) lclosed	
-- verifica se a ação de número y-1 gera uma configuração já incluida na lista de visitados
-- se ainda não tiver sido incluido, retorna ele concatenado com o da próxima ação
	| not((acao (y-1) filho) == (0,0))  && not(member (filho,acao (y-1) filho) lopen) && not(member (filho,acao (y-1) filho) lclosed) =  [(filho,(acao (y-1) filho))]++(expande (y-1) ((pai,filho):lopen) lclosed)
-- se já tiver sido incluido, procura a próxima acao
	| otherwise =  (expande (y-1) ((pai,filho):lopen) lclosed)
-- && not(member (filho,acao (y-1) filho) lclosed)
-- se for a configuração (16,16), então o nó é final!
final (pai, (x,y))
	| (x,y)==(16,16) = True
	| otherwise = False

acao 4 (x,y) 
	| ((custo (x,(y+1)) == 1) || (custo (x,(y+1)) == 5)) && (y<16) = (x,(y+1))
   	| otherwise = (0,0)

acao 3 (x,y) 
	| ((custo ((x+1),y) == 1) || (custo ((x+1),y) == 5)) && (x<16) = ((x+1),y)
	| otherwise = (0,0)

acao 2 (x,y) 
	| ((custo (x,(y-1)) == 1) || (custo (x,(y-1)) == 5)) && (y>1) = (x,(y-1))
	| otherwise = (0,0)

acao 1 (x,y)
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
