
type Cadastro = ([Char], Int)

pessoa :: Int -> Cadastro
pessoa rg
	| rg == 1 = ("João Silva", 12)
	| rg == 2 = ("Jonas Souza", 51)
	| rg == 3 = ("Jocileide Strauss", 21)
	| otherwise = error "Nao existe este numero de registro"

-- questão 1.a

separa_nome (x,_) = x
idade ( _ , i ) = i


menor x y
	| x1 <= x2  = x
	| otherwise =  y
		where
		   x1 = idade x
		   x2 = idade y


menor_idade:: Int -> Cadastro
menor_idade w
	| w == 1 = pessoa 1
	| otherwise = menor (pessoa w) (menor_idade (w-1))



-- questão 1.b

div2 x y | y == 0 = error "Nao existe" 
	 | x < y = 0 
	 | otherwise = 1 + (div2 (x-y) y)

soma_idade:: Int -> Int
soma_idade 0 = 0
soma_idade n = idade (pessoa n) + soma_idade (n-1)

media_idade:: Int -> Int
media_idade w =  div2 (soma_idade w) w

-- questão 1.c

maior:: Int -> Int -> Int
maior x y
	| x1 >= x2  = x
	| otherwise =  y
		where
		   x1 = idade (pessoa x)
		   x2 = idade (pessoa y)


maior_idade:: Int -> Int
maior_idade w
	| w == 1 = w
	| otherwise = maior w (maior_idade (w-1))



-- questão 2.a

-- versão 1

maior_nome_aux:: Cadastro -> [Cadastro] -> Cadastro
maior_nome_aux a [] = a
maior_nome_aux a (b:c)
	| length (separa_nome a) >= length (separa_nome b) = maior_nome_aux a c
	| otherwise = maior_nome_aux b c

maior_nome1:: [Cadastro] -> Cadastro
maior_nome1 [] = error "colocar uma lista de entrada"
maior_nome1 (a:b) = maior_nome_aux a b


-- versão 2
maior_nome2:: [Cadastro] -> Cadastro
maior_nome2 [] = error "colocar uma lista de entrada"
maior_nome2 (a:[]) = a
maior_nome2 (a:b)
	| length (separa_nome a) > length (separa_nome (maior_nome2 b)) = a
	| otherwise = maior_nome2 b 

-- questão 2.b

separa_idade (_,y) = y

verificaMenor:: [Cadastro] -> Cadastro -> Cadastro
verificaMenor [] a = a
verificaMenor (a:b) c
	|separa_idade a < separa_idade c = verificaMenor b a
	|otherwise = verificaMenor b c

verificaMaior:: [Cadastro] -> Cadastro -> Cadastro
verificaMaior [] a = a
verificaMaior (a:b) c
	|separa_idade a > separa_idade c = verificaMaior b a
	|otherwise = verificaMaior b c

maiorMenor:: [Cadastro] -> (Cadastro, Cadastro)
maiorMenor (a:b) = (verificaMaior b a, verificaMenor b a)

-- questão 2.c
compara_inicio :: Char -> [Char] -> Bool
compara_inicio _ [] = True
compara_inicio x (c:d)
	|x /= c = False
	|otherwise = True

comeca_nome :: Char -> [Cadastro] -> [Cadastro]
comeca_nome _ [] = []
comeca_nome x (a:b)
	|compara_inicio x y == True = (a : (comeca_nome x b))
	|otherwise = comeca_nome x b
		where y = separa_nome a


-- questão 3
soma_moedas:: [Int] -> Int
soma_moedas [] = 0
soma_moedas (a:b) = a + soma_moedas b

verifica_moedas :: [Int] -> Bool
verifica_moedas [] = True
verifica_moedas (a:b)
	| verifica_moedas_aux a == False = False
	| otherwise = verifica_moedas b

verifica_moedas_aux:: Int -> Bool
verifica_moedas_aux x
	| x == 10 || x == 25 || x == 5 || x == 50 = True
	|otherwise = False


cafe:: [Int] -> ([Char], Int)
cafe [] = error "Eh necessario colocar moedas!"
cafe (a:b)
	| verifica_moedas (a:b) == False = ("Blim-bloin! Existem moedas que nao sao 5 ou 10 ou 25 ou 50" , 999)
	| soma_moedas (a:b) == 100 = ("Trim! delicie seu cafe! conta exata" , 0 )
	| soma_moedas (a:b) > 100 = ("Trim! delicie seu cafe! e pegue seu troco de" ,((soma_moedas (a:b)) - 100))
	| otherwise = ("Desculpe! faltaram moedas! favor colocar" ,(100 - (soma_moedas (a:b))))


-- questão 4

ou_exclusivo:: Int -> [Int] -> [Int]
ou_exclusivo x [] = []
ou_exclusivo x (a:b)
	| (x == 1 && a == 1) ||(x == 0 && a == 0) = (0 : (ou_exclusivo x b))
	| otherwise = (1 : (ou_exclusivo x b))


video :: [Int] -> [Int] -> [[Int]]
video [] (c:d) = []
video (a:b) [] =[]
video (a:b) (c:d) = ((ou_exclusivo a (c:d)) : (video b (c:d)))

-- questão 5

qtas_vezes:: Int -> [Int] -> Int
qtas_vezes _ [] = 0 
qtas_vezes x (a:b)
	|x == a = 1 + qtas_vezes x b
	|otherwise = qtas_vezes x b

remove_todos:: Int -> [Int] -> [Int]
remove_todos _ [] = []
remove_todos x (a:b)
	| x /= a = (a : (remove_todos x b))
	| otherwise = remove_todos x b


nao_unicos :: [Int] -> [Int]
nao_unicos [] = []
nao_unicos (a:b)
	| (qtas_vezes a (a:b)) > 1 = (a : (nao_unicos (remove_todos a (a:b))))
	| otherwise = nao_unicos (remove_todos a (a:b))

-- questão 6


-- a função remove_todos e qtas_vezes já foram implementadas na questão 5


num_ocorr [] = []
num_ocorr (a:b) = ((a, qtas_vezes a (a:b)) : (num_ocorr (remove_todos a (a:b))))

-- [("João Silva", 12),("Jonas Souza", 51), ("Jocileide Strauss", 21)]

