{- Gabriela Thumé - Inteligência Artificial 30/04/2011

   Busca em Profundidade

   Problema do labirinto: estado inicial: (1,1)
	                  estado final: (16,16)

   Uso: $ ghci
	Prelude> :load labirinto_das_enchentes(busca_profundidade).hs
	*LABIRINTO> inicio

   Saida: 
		             BUSCA EM PROFUNDIDADE


	[(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(2,16),(2,15),(2,14),(2,13),(2,12),(2,11),(2,10),(2,9),(2,8),(2,7),(2,6),(2,5),(2,4),(2,3),(2,2),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,7),(8,8),(8,9),(8,10),(8,11),(8,12),(8,13),(8,14),(8,15),(8,16),(9,16),(9,15),(9,14),(9,13),(9,12),(9,11),(9,10),(9,9),(9,8),(9,7),(9,6),(9,5),(9,4),(9,3),(9,2),(9,1),(10,1),(10,2),(10,3),(10,4),(10,5),(10,6),(11,6),(11,7),(11,8),(11,9),(11,10),(12,10),(12,9),(12,8),(12,7),(12,6),(12,5),(12,4),(12,3),(12,2),(12,1),(13,1),(13,2),(13,3),(13,4),(13,5),(13,6),(14,6),(14,5),(14,4),(14,3),(14,2),(14,1),(15,1),(15,2),(15,3),(15,4),(15,5),(15,6),(15,7),(15,8),(15,9),(15,10),(15,11),(15,12),(15,13),(15,14),(15,15),(15,16),(16,16)]



	  X    X    X    X    X    X    X    X    X    X    X    X    X    X    X    X  
	  X    X    X    X    X    X    X    X    X    X    X    X    X    X    X    X  
	  X  |||||               |||||                                                  
	  X  |||||               |||||                                                  
	-----|||||               |||||--------------------||||||||||||||||||||||||||||||
	  X  |||||               |||||                    -----                         
	  X  |||||||||||||||||||||||||                    -----                         
	  X    X    X  -----  X    X    X    X    X    X  -----  X    X    X    X    X  
	  X    X    X  -----  X    X    X    X    X    X  -----  X    X    X    X    X  
	  X    X    X  -----  X    X  |||||||||||||||||||||||||                         
		       -----       X    X    X    X    X  |||||-------------------------
	  X    X    X  -----  X    X    X    X    X    X  |||||                         
	  X    X    X  -----  X    X                      |||||                         
	  X    X    X  -----  X    X  |||||||||||||||||||||||||                         
	  X    X    X  -----  X    X    X    X    X    X    X    X    X    X    X    X  
		       -----                                                         X  

	Custo total da travessia:159

-}

module LABIRINTO where

import IO
import System

-- função que verifica se uma tupla faz parte de uma lista de tuplas
member (x,y) [] = False
member (x,y) ((q,w):ws)
	| (x == q) && (y == w) = True 
	| otherwise = member (x,y) ws

-- função que calcula o custo de um caminho, baseado na tabela de custos (final do arquivo)
custo_total [] = 0
custo_total ((x,y):ws) = (custo(x,y) + custo_total ws)

-- Para imprimir o custo total:
--inicio = custo_total (busca [(1,1)] [])
-- Para imprimir o caminho percorrido:
inicio = do{

		putStr "                     BUSCA EM PROFUNDIDADE"; putStr "\n";
		putStr "\n"; putStr "\n";	
		print (reverse (busca [(1,1)] []));
		imprime (reverse (busca [(1,1)] []));
		putStr "Custo total da travessia:";
		print (custo_total (reverse (busca [(1,1)] []))); putStr "\n";

	}
-- função para saber se chegou ao objetivo (16,16)
final (x, y) 
   | (x,y) == (16,16) = True
   | otherwise = False

-- se não existem mais nós a serem verificados como finais, então não existe solução
busca [] lclosed = error "Nao tem solucao"
-- busca com lopen(lista corrente de nós abertos) e lclosed(nós já verificados e não finais)
busca (no:xs) lclosed = (anda 1 (no:xs) lclosed)

-- se nenhuma ação satisfaz como próximo nó, volta para a busca, adicionando o nó corrente em lclosed
anda 5 (no:xs) lclosed = busca xs ([no]++lclosed)
anda x (no:xs) lclosed
-- para imprimir os nós fechados
--	| final no == True = lclosed
-- para imprimir o caminho percorrido
	| final no == True = (no:xs)
-- se a ação existir (diferente de (0,0)) e ainda não tiver sido visitada (não repetindo a ação na lista de abertos e desconsiderando os nós fechados), faz a busca adicionando o nó resultante da ação nos nós abertos
	| ((acao x no) /= (0,0)) && not(member (acao x no) xs) && not(member (acao x no) lclosed) = busca ([acao x no]++(no:xs)) lclosed
-- se não tiver utilizado a ação x, procura a próxima ação x+1
        | otherwise = anda (x+1) (no:xs) lclosed

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


 
imp (x,y)
	| (custo (x,y)) == 5 = putStr "-----"
	| (custo (x,y)) == 99 = putStr "|||||"
	| (custo (x,y)) == 1 =  putStr  "  X  "

impMap (x,y)
	| (custo (x,y)) == 5 = putStr "-----"
	| (custo (x,y)) == 99 = putStr "|||||"
	| (custo (x,y)) == 1 = putStr "     " 

imprime caminho = do{ putStr "\n"; putStr "\n"; putStr "\n"; mapa (1,1) caminho;}

mapa (x,y) [] = putStr ""
mapa (x,y) caminho
   | (member (x,y) caminho) && (y < 16)= do{ imp (x,y); mapa (x,y+1) caminho;}
   | not(member (x,y) caminho) && (y < 16)= do{ impMap (x,y); mapa (x,y+1) caminho;}
   | (member (x,y) caminho) && (y==16) && (x < 16) = do{imp (x,y);  putStr "\n";  mapa (x+1,1) caminho;}
   | not(member (x,y) caminho) && (y==16) && (x < 16) = do{impMap (x,y);  putStr "\n";  mapa (x+1,1) caminho;}
   | (member (x,y) caminho) && (y==16) && (x == 16) = do{ imp (x,y); putStr "\n";  putStr "\n";}
   | not(member (x,y) caminho) && (y==16) && (x == 16) = do{impMap (x,y);  putStr "\n";  putStr "\n";}


