{- Gabriela Salvador Thumé 29/05/2011


	Uso:	$ ghci
		Prelude> :load ovelhas_no_campo(simulated-annealing).hs
		*OVELHAS> otimiza

	Saída:
		*OVELHAS> otimiza
				     OTIMIZAÇÃO COM SIMULATED ANNEALING

		Procura uma configuração aceitável de 5 ovelhas no tabuleiro. Gera uma solução aleatória de início, e a cada nova interação, troca um de seus elementos por uma posição aleatória e escolhe o de menor custo (calculado por quantas ovelhas estão em conflito ou gramas em branco) OU o de pior custo de acordo com a probabilidade obtida por (e^(-maior-menor)/temperatura).

		Configuração: [(3,4),(3,2),(2,2),(3,5),(3,3)]


-}

module OVELHAS where

import System.Random
import System.IO.Unsafe (unsafePerformIO,unsafeInterleaveIO)

randsZeroUm :: Int -> [Double]
randsZeroUm 0 = []
randsZeroUm s = randsZeroUm (s-1) ++ [ran]
                where   
                ran = unsafePerformIO (randomRIO (0, 1 :: Double))

randsAB :: Int -> Int -> Int -> [Int]
randsAB 0 _ _ = []
randsAB s min max = randsAB (s-1) min max ++ [ran]
                    where   
                    ran = unsafePerformIO (randomRIO (min, max))

primeiro (a:b) = a

fat 0 = 1
fat n = n * fat (n - 1)

e :: Double
e = sum [1 / fat n | n <- [0 .. 20]]

solucaoAleatoria :: Int -> Int -> Int -> [(Int,Int)]
solucaoAleatoria 0 _ _ = []
solucaoAleatoria s min max = solucaoAleatoria (s-1) min max ++ [(ran1,ran2)]
                             where   
                             ran1 = unsafePerformIO (randomRIO (min, max))
                             ran2 = unsafePerformIO (randomRIO (min, max))

-- calcula o custo de uma configuração
calculaCusto custo [] = custo
calculaCusto custo (x:xs)
	| local_aceitavel x xs = calculaCusto custo xs
	| otherwise = calculaCusto (custo+100.0) xs

calcula campo = calculaCusto (testa 0.0 (1,1) campo) campo

geraVizinha [] = []
geraVizinha configuracao = inserir 0 posicao aleatorio configuracao
				where
					posicao = primeiro (randsAB 1 0 5)
					aleatorio = (solucaoAleatoria 1 1 5)
inserir _ _ _ [] = [] 
inserir n posicao aleatorio (x:xs)
	| n == posicao = aleatorio ++ xs
	| otherwise = [x] ++ inserir (n+1) posicao aleatorio xs 
	

pertence (x,y) [] = False
pertence (x,y) ((x2,y2):xs) 
	| (x,y) == (x2,y2) = True
	| otherwise = pertence (x,y) xs

otimiza = 
	do{
		putStr "                     OTIMIZAÇÃO COM SIMULATED ANNEALING"; putStr "\n"; putStr "\n";
		putStr "Procura uma configuração aceitável de 5 ovelhas no tabuleiro. Gera uma solução aleatória de início, e a cada nova interação, troca um de seus elementos por uma posição aleatória e escolhe o de menor custo (calculado por quantas ovelhas estão em conflito ou gramas em branco) OU o de pior custo de acordo com a probabilidade obtida por (e^(-maior-menor)/temperatura)."; 
		putStr "\n"; putStr "\n";
		putStr "Configuração: ";	
		print(annealing 10000.0 0.95 (solucaoAleatoria 5 1 5));
	}

annealing temperatura taxa solucao
	| temperatura < 0.1 = solucao
	| (calcula solucao < calcula vizinha) || (rand < p) = annealing (temperatura*taxa) taxa solucao
	| otherwise = annealing (temperatura*taxa) taxa vizinha
     where
	rand = primeiro (randsZeroUm 1)
	p = probabilidade solucao vizinha temperatura
	vizinha = geraVizinha solucao


-- distribuição de Boltzman
probabilidade solucao vizinha temperatura = e**((- (calcula solucao) - (calcula vizinha)) / temperatura)



-- verifica se todas as áreas do campo foram cobertas (mais nenhuma posição é aceitável)
testa :: Double -> (Int,Int) -> [(Int,Int)] -> Double
testa num _ [] = num
testa num (x,y) campo
	| (x,y) == (5,5) && not(local_aceitavel (x,y) campo) = num
	| (x,y) == (5,5) = (num+100.0)
	| not(local_aceitavel (x,y) campo) = if(x<=4) 
					       then testa num (x+1,y) campo
  				               else testa num (1,y+1) campo
	| otherwise = if(x<=4) 
		        then testa (num+100.0) (x+1,y) campo
  		        else testa (num+100.0) (1,y+1) campo


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
