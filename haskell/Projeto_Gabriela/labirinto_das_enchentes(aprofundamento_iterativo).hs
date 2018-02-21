{- Gabriela Thumé - Inteligência Artificial 07/05/2011

   Busca com aprofundamento iterativo

   Problema do labirinto: estado inicial: (1,1)
	                  estado final: (16,16)

   Uso: $ ghci
	Prelude> :load labirinto_das_enchentes(aprofundamento_iterativo).hs
	*LABIRINTO> inicio

   Saida:
		             BUSCA COM APROFUNDAMENTO ITERATIVO

	A solucao por busca com aprofundamento iterativo eh demorada pois os nos do nivel inferior d sao geradas uma vez e os filhos da raiz sao gerados d vezes! (considere o fato de que a primeira solucao estah na profundidade 30). Nesse problema de caminhos em um labirinto, temos ciclos, assim cada no teve de ser identificado com o numero de sua profundidade tambem, garantindo nao ter estados repetidos, mas podendo passar por lugares jah antes visitados, porem por caminhos diferentes.

	Resultado usando passos de tamanho = 1:


	  X    X    X    X    X    X    X    X    X    X                                
		                                       X                                
	     |||||               |||||                 X                                
	     |||||               |||||                 X                                
	-----|||||               |||||--------------------||||||||||||||||||||||||||||||
	     |||||               |||||                 X  -----  X    X    X    X    X  
	     |||||||||||||||||||||||||                    -----                      X  
		       -----                              -----                      X  
		       -----                              -----                      X  
		       -----          |||||||||||||||||||||||||                      X  
		       -----                              |||||-------------------------
		       -----                              |||||                      X  
		       -----                              |||||                      X  
		       -----          |||||||||||||||||||||||||                      X  
		       -----                                                         X  
		       -----                                                         X  


	Resultado usando passos de tamanho = 5:


	  X    X    X    X    X    X    X    X    X    X                                
		                                       X                                
	     |||||               |||||                 X                                
	     |||||               |||||                 X                                
	-----|||||               |||||--------------------||||||||||||||||||||||||||||||
	     |||||               |||||                 X  -----  X    X    X    X    X  
	     |||||||||||||||||||||||||                    -----                      X  
		       -----                              -----                      X  
		       -----                              -----                      X  
		       -----          |||||||||||||||||||||||||                      X  
		       -----                              |||||-------------------------
		       -----                              |||||                      X  
		       -----                              |||||                      X  
		       -----          |||||||||||||||||||||||||                      X  
		       -----                                                         X  
		       -----                                                         X  


	Resultado usando passos de tamanho = 10:


	  X    X    X    X    X    X    X    X    X    X                                
		                                       X                                
	     |||||               |||||                 X                                
	     |||||               |||||                 X                                
	-----|||||               |||||--------------------||||||||||||||||||||||||||||||
	     |||||               |||||                 X  -----  X    X    X    X    X  
	     |||||||||||||||||||||||||                    -----                      X  
		       -----                              -----                      X  
		       -----                              -----                      X  
		       -----          |||||||||||||||||||||||||                      X  
		       -----                              |||||-------------------------
		       -----                              |||||                      X  
		       -----                              |||||                      X  
		       -----          |||||||||||||||||||||||||                      X  
		       -----                                                         X  
		       -----                                                         X  


	Os resultados foram iguais porque ele sempre encontra um resultado na profundidade = 30. A diferença ficou no tempo de execução.
	
-}

module LABIRINTO where

import IO
import System

-- função que verifica se uma tupla faz parte de uma lista de tuplas
member (x,y, n1) [] = False
member (x,y, n1) ((q,w, n2):ws)
	| (x,y,n1) == (q,w,n2) = True 
	| otherwise = member (x,y,n1) ws

-- função que calcula o custo de um caminho, baseado na tabela de custos (final do arquivo)
custo_total [] = 0
custo_total ((x,y,n):ws) = (custo(x,y) + custo_total ws)

caminho :: [((Int, Int), (Int, Int), Int)] -> [(Int, Int)]
-- Percorre o caminho final
caminho []  = []
caminho ((pai, filho, nivel):xs) = [(filho)]++caminho xs

final :: ((Int, Int), (Int, Int), Int) -> Bool
-- se for a configuração (16,16), então o nó é final!
final (pai, (x,y), n)
	| (x,y)==(16,16) = True
	| otherwise = False


inicio =
     do{
	putStr "                     BUSCA COM APROFUNDAMENTO ITERATIVO"; putStr "\n"; putStr "\n";
	putStr "A solucao por busca com aprofundamento iterativo eh demorada pois os nos do nivel inferior d sao geradas uma vez e os filhos da raiz sao gerados d vezes! (considere o fato de que a primeira solucao estah na profundidade 30). Nesse problema de caminhos em um labirinto, temos ciclos, assim cada no teve de ser identificado com o numero de sua profundidade tambem, garantindo nao ter estados repetidos, mas podendo passar por lugares jah antes visitados, porem por caminhos diferentes.";
	putStr "\n\n";
	putStr "Resultado usando passos de tamanho = 1:";
        imprime (caminho(iteracao 1 0)); putStr "\n";
   	putStr "Resultado usando passos de tamanho = 5:";
	imprime (caminho(iteracao 5 0)); putStr "\n";
	putStr "Resultado usando passos de tamanho = 10:";		
	imprime (caminho(iteracao 10 0)); putStr "\n";
	putStr "Os resultados foram iguais porque ele sempre encontra um resultado na profundidade = 30. A diferença ficou no tempo de execução."; putStr "\n";
     }

iteracao 1 limite = 
      do{ 
         if (inicia limite /= []) then inicia limite
	 else iteracao 1 (limite+1);
      }

iteracao 5 limite = 
      do{ 
         if (inicia limite /= []) then inicia limite
	 else iteracao 5 (limite+5);
      }

iteracao 10 limite = 
      do{ 
         if (inicia limite /= []) then inicia limite
	 else iteracao 10 (limite+10);
      }

inicia :: Int -> [((Int, Int), (Int, Int), Int)]
inicia limite = reverse(busca limite [((1,1),(1,1),0)] [((0,0),(0,0),0)])


busca :: Int -> [((Int, Int), (Int, Int), Int)] -> [((Int, Int), (Int, Int), Int)] -> [((Int, Int), (Int, Int), Int)]
-- se não existem mais nós a serem verificados como finais, então não existe solução
busca limite [] lclosed = []
-- busca com lopen(lista corrente de nós abertos) e lclosed(nós já verificados e não finais)
busca limite ((pai,filho,nivel):xs) lclosed
	| (final (pai,filho,nivel) == True) = ((pai,filho,nivel):xs)
	| (limite == nivel) = busca limite xs ([(pai,filho,nivel)]++lclosed)
	| otherwise = anda limite 1 ((pai,filho,nivel):xs) lclosed

anda :: Int -> Int -> [((Int, Int), (Int, Int), Int)] -> [((Int, Int), (Int, Int), Int)] -> [((Int, Int), (Int, Int), Int)]
-- se nenhuma ação satisfaz como próximo nó, volta para a busca, adicionando o nó corrente em lclosed
anda limite 5 ((pai,filho,nivel):xs) lclosed = busca limite xs ([(pai,filho,nivel)]++lclosed)
anda limite x ((pai,filho,nivel):xs) lclosed
-- se a ação existir (diferente de (0,0)) e ainda não tiver sido visitada (não repetindo a ação na lista de abertos e desconsiderando os nós fechados), faz a busca adicionando o nó resultante da ação nos nós abertos
	| not((acao x filho) == (0,0)) && not(member (filho,(acao x filho),(nivel+1)) xs) && not(member (filho,(acao x filho),(nivel+1)) lclosed) =
                                                         busca limite ([(filho,(acao x filho), (nivel+1))]++((pai,filho,nivel):xs)) lclosed
-- se não tiver utilizado a ação x, procura a próxima ação x+1
        | otherwise = anda limite (x+1) ((pai,filho,nivel):xs) lclosed

-- Ações para andar (envia (0,0) se não puder executar a ação (existe um obstáculo no caminho ou esta na parede)):

-- Anda para a direita 
acao 1 (x,y)
	| ((custo (x,(y+1)) == 1) || (custo (x,(y+1)) == 5)) && (y<16) = (x,(y+1))
	| otherwise = (0,0)

-- Anda para esquerda
acao 2 (x,y)
	| ((custo (x,(y-1)) == 1) || (custo (x,(y-1)) == 5)) && (y>1)  = (x,(y-1))
	| otherwise = (0,0)

-- Anda para baixo
acao 3 (x,y) 
	| ((custo ((x+1),y) == 1) || (custo ((x+1),y) == 5)) && (x<16)  = ((x+1),y)
	| otherwise = (0,0)

-- Anda para cima
acao 4 (x,y) 
	| ((custo ((x-1),y) == 1) || (custo ((x-1),y) == 5)) && (x>1) = ((x-1),y)
	| otherwise = (0,0)

-- Função que responde qual é o custo daquela posição:
-- Se for um rio, o custo é 5
-- Se for um obstaculo, 99, para demonstrar que não há como passar por ali
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
