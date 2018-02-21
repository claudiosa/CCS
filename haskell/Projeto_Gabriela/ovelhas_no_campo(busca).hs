{- Gabriela Salvador Thumé 28/05/2011


	Busca exaustiva para encontrar o menor número de ovelhas de forma a cobrir todo o campo

	Uso:	$ gci
		Prelude> :load ovelhas_no_campo(busca).hs
		*OVELHAS> numero_de_ovelhas

 
        Saída:			     MINIMIZAÇÃO DE OVELHAS

		Partindo de um campo com obstáculos e gramas sem ninguém para cuidar, o algoritmo tenta preencher com o mínimo de ovelhas possíveis o campo. Começando com uma ovelha, testa todas as configurações possíveis e parte para o número de ovelhas mais um.

		Número de ovelhas: 5


-}

module OVELHAS where

ordena [] = []
ordena (x:xs) = ins x (ordena xs)

ins (x,y) [] = [(x,y)]
ins (x,y) ((x2,y2):xs)
	| (x < x2) = [(x,y)]++((x2,y2):xs) 
	| (x == x2) && (y<y2) = [(x,y)]++((x2,y2):xs) 		
	| (x == x2) && (y>y2) = [(x2,y2)]++((x,y):xs) 
	| otherwise = [(x2,y2)]++ins (x,y) xs

pertence (x,y) [] = False
pertence (x,y) ((x2,y2):xs) 
	| (x,y) == (x2,y2) = True
	| otherwise = pertence (x,y) xs

conta num [] = num
conta num (x:xs) = conta (num+1) xs

numero_de_ovelhas =
	do{
		putStr "                     MINIMIZAÇÃO DE OVELHAS"; putStr "\n"; putStr "\n";
		putStr "Partindo de um campo com obstáculos e gramas sem ninguém para cuidar, o algoritmo tenta preencher com o mínimo de ovelhas possíveis. Começando com uma ovelha, testa todas as configurações possíveis e parte para esse número de ovelhas mais um."; 
		putStr "\n"; putStr "\n";
		putStr "Número de ovelhas: ";	
		print(conta 0 busca);
	}


busca = ordena(configuracao 1 (1,1) (5,5) [])

configuracao numero_ovelhas (x,y) (xf,yf) campo 
-- se percorrer todas as possibilidades de configuração e não conseguir, aumenta o numero minimo de ovelhas pra +1
	| insere numero_ovelhas 0 (x,y) (xf,yf) campo == [] = if (x<=4) 
							         then configuracao numero_ovelhas (x+1,y) (x,y) []
							         else if (y<=4) 
								        then configuracao numero_ovelhas (1,y+1) (x,y) []
								        else configuracao (numero_ovelhas+1) (1,1) (5,5) []
	| otherwise = insere numero_ovelhas 0 (x,y) (xf,yf) campo 

insere total numero_ovelhas (x,y) (xf,yf) campo
	| (total == numero_ovelhas) || ((x,y) == (xf,yf)) = testa (1,1) campo
-- se o local for aceitavel, adiciona no campo e tenta inserir na proxima posicao			 
	| local_aceitavel (x,y) campo =  if(x<=4) then insere total (numero_ovelhas+1) (x+1,y) (xf,yf) ([(x,y)]++campo)
				         else if(y<=4) then insere total (numero_ovelhas+1) (1,y+1) (xf,yf) ([(x,y)]++campo)
					      else insere total (numero_ovelhas+1) (1,1) (xf,yf) ([(x,y)]++campo)
	| otherwise = if(x<=4) then insere total numero_ovelhas (x+1,y) (xf,yf) campo
  		      else if(y<=4) then insere total numero_ovelhas (1,y+1) (xf,yf) campo
			   else insere total numero_ovelhas (1,1) (xf,yf) campo

-- verifica se todas as áreas do campo foram cobertas (mais nenhuma posição é aceitável)
testa _ [] = []
testa (x,y) campo
	| (x,y) == (5,5) && not(local_aceitavel (x,y) campo) = campo
	| not(local_aceitavel (x,y) campo) = if(x<=4) 
					       then testa (x+1,y) campo
  				               else testa (1,y+1) campo
	| otherwise = []


-- Verifica se a posição da ovelha no campo é aceitável
local_aceitavel (x,y) campo
	| not(pertence (x,y) campo) && tabuleiro (x,y) == 1 &&
	  not(pertence (x-1,y-2) campo) && 
	  not(pertence (x+1,y-2) campo) &&
	  not(pertence (x-2,y-1) campo) &&
	  not(pertence (x+2,y-1) campo) &&
	  not(pertence (x-2,y+1) campo) &&
	  not(pertence (x+2,y+1) campo) &&
	  not(pertence (x-1,y+2) campo) &&
	  not(pertence (x+1,y+2) campo) = True
	| otherwise = False


tabuleiro (x,y)
-- Se for um obstáculo, retorne 99, senão 1
	| (x,y) == (3,1) || (x,y) == (1,2) || (x,y) == (4,2) || (x,y) == (1,3) || (x,y) == (2,3) || (x,y) == (4,4) || (x,y) == (5,4) = 99
	| otherwise = 1
