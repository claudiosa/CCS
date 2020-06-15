module Jogos where
import IO
import System
import Char (toUpper)

iniciar::IO()
iniciar = do menu      --inicia o sistema

menu::IO()
menu =
	   do
		putStr "\n"
                putStrLn "*********************************************"
		putStrLn "*                                           *"
                putStrLn "*            CADASTRO DE JOGOS              *" 
		putStrLn "*                                           *"
		putStrLn "*********************************************"
		putStrLn "*                                           *"
                putStrLn "*   1  -  Insere novo jogo                  *"
                putStrLn "*   2  -  Alterar um cadastro               *"
                putStrLn "*   3  -  Excluir um cadastro               *"
                putStrLn "*   4  -  Excluir todos cadastros           *"
                putStrLn "*   5  -  Busca por titulo                  *"
                putStrLn "*   6  -  Busca por desenvolvedor           *"
                putStrLn "*   7  -  Busca por categoria               *"
                putStrLn "*   8  -  Listar jogos cadastrados          *"
		putStrLn "*   9  -  Busca por substring do titulo     *"
                putStrLn "*   B  -  Criar copia da lista de jogos     *"
                putStrLn "*   R  -  Restaurar lista de jogos          *"
		putStrLn "*   H  -  Explicação do sistema e funções   *"
                putStrLn "*   0  -  Sair do Sistema                   *"
		putStrLn "*********************************************"                  
                putStr "Digite uma das opcoes:"
		le_opcao

abreArquivo :: String -> IOMode -> IO Handle
abreArquivo prompt mode =
    do putStr prompt
       nome <- getLine
       catch (openFile nome mode)
             (\_ -> do putStrLn ("Impossivel abrir "++ nome ++ "\n")
                       abreArquivo prompt mode)


le_opcao :: IO ()
le_opcao=
	   do
		opcao <- getChar
		putStr "\n"
                f_menu (opcao)

f_menu::Char->IO()
f_menu i =
	   do
	     case i of
               '1' -> opcao_1      

               '2' -> opcao_2

               '3' -> opcao_3

               '4' -> opcao_4
		     

               '5' -> opcao_5

               '6' -> opcao_6

               '7' -> opcao_7
	
	       '8' -> opcao_8

	       '9' -> opcao_9

               'B' -> opcao_B

               'R' -> opcao_R

               'H' -> opcao_H

	       '0' ->do 
                       putStr "Saindo do sistema...."
                                  
               otherwise -> menu      
             putStr "Operacao Concluida"
             if (i/='0') then menu else putStr ""            

{-se i for diferente de 0 retorna ao menu, senão sai do programa.-}

---------------------------bloco de opcoes---------------------------------      
opcao_1  = do
                        putStr "Titulo: "
                        titulo <-getLine
                        putStr "Desenvolvedor: " 
			autor <-getLine
                        putStrLn "(A) - Acao | (E) -Estrategia/RPG | (S) -Simulacao/Corrida | (O) -Outros"
                        putStr "Genero: "
                        tipo <-getChar
                        arquivo <- openFile "dados.txt" AppendMode
                        hPutStr arquivo (titulo++"."++autor++"."++[toUpper(tipo)]++"\n")       
                        hClose arquivo
                        putStr "\n\nAtualizando cadastros...."

opcao_2  = do
	 putStr "TITULO: "
	 titulo <- getLine             --1o. exclui 
         putStr "DESENVOLVEDOR:"
         autor <- getLine
         arquivo1 <- openFile "dados.txt" ReadMode
	 conteudo <- hGetContents arquivo1
	 buscaCad titulo autor (padrao conteudo) 0
         if (estaCad titulo autor (padrao conteudo)) then do 
                                                           arquivo <- openFile "dados1.txt" WriteMode
                                                           hPutStr arquivo (desdobra (removeCadastro titulo autor (padrao conteudo)))
                                                           hClose arquivo
                                                           copiaDe <- openFile "dados1.txt" ReadMode
                                                           cont <-hGetContents copiaDe
                                                           copiaPara <- openFile "dados.txt" WriteMode
                                                           hPutStr copiaPara cont
                                                           hClose copiaPara
                                                           putStrLn "INFORME NOVOS DADOS\n"
                                                           putStr "TITULO:"
                                                           titulo <- getLine               --insere dados
                                                           putStr "DESENVOLVEDOR:"
                                                           autor <- getLine
                                                           putStr "GENERO:"
                                                           genero <- getChar
                                                           arquivo <- openFile "dados.txt" AppendMode
                                                           hPutStr arquivo (titulo++"."++autor++"."++[toUpper(genero)]++"\n")       
                                                           hClose arquivo
                                                           putStr "Atualizando cadastros...."           
                                                    else putStr ""

opcao_3   = do 
			 putStr "TITULO: "
			 titulo <- getLine
                         putStr "AUTOR:"
                         autor <- getLine
                         arquivo1 <- openFile "dados.txt" ReadMode
			 conteudo <- hGetContents arquivo1
			 arquivo <- openFile "dados1.txt" WriteMode
                         hPutStr arquivo (desdobra (removeCadastro titulo autor (padrao conteudo)))
			 hClose arquivo
			 copiaDe <- openFile "dados1.txt" ReadMode
			 cont <-hGetContents copiaDe
			 copiaPara <- openFile "dados.txt" WriteMode
			 hPutStr copiaPara cont
			 hClose copiaPara
			 putStr "Deletando dados..."

opcao_4   = do
			putStr "Tem certeza que deseja apagar todos os dados do sistema?(s/n)"
			resp <- getChar
			putStr "\n"
			if not((toUpper resp)=='S') then putStr "" else 
				do arquivo <-openFile "dados.txt" WriteMode
			   	   hPutStr arquivo ""
                           	   putStr "Apagando dados...."         

opcao_5   = do 
		arquivo <- openFile "dados.txt" ReadMode
		conteudo <- hGetContents arquivo
		lista_nomes conteudo
		putStr "TITULO: "
		titulo <- getLine
		putStrLn "_______RESULTADOS:_______"
		buscaTitulo titulo (padrao conteudo) 0  
		hClose arquivo

opcao_6   = do 
			 arquivo <- openFile "dados.txt" ReadMode
			 conteudo <- hGetContents arquivo
			 lista_titulo conteudo
			 putStr "DESENVOLVEDOR: "
			 autor <- getLine
			 putStrLn "_______RESULTADOS:_______"
			 buscaAutor autor (padrao conteudo) 0
			 hClose arquivo

opcao_7    = do
                         putStrLn "A -Ação |E -Estratégia/RPG |S -Simulação/Corrida |O -Outros"
                         putStr "GENERO: "
                         genero <- getChar
			 arquivo <- openFile "dados.txt" ReadMode
			 conteudo <- hGetContents arquivo
                         putStrLn ""   --so para pular uma linha apos o getChar
			 putStrLn "_______RESULTADOS:_______"
                         buscaGenero [(toUpper genero)] (padrao conteudo) 0
		         hClose arquivo

opcao_8   = do
                        arquivo <- openFile "dados.txt" ReadMode
                        conteudo <- hGetContents arquivo
			imprime (padrao conteudo)
			delay <- getChar
                        hClose arquivo

opcao_9   = do		
			arquivo <- openFile "dados.txt" ReadMode
                        conteudo <- hGetContents arquivo
			putStr "TITULO: "
			titulo <- getLine
			putStrLn "_______RESULTADOS:_______"
			busca_titulo titulo conteudo	
			hClose arquivo

opcao_B   = do
                        arquivo <- openFile "dados.txt" ReadMode
                        backup   <- abreArquivo "Nome do arquivo de backup: " WriteMode
                        conteudo   <- hGetContents arquivo
                        hPutStr backup conteudo
                        hClose backup
                        putStr "Fazendo backup de dados...."           

opcao_R   = do
                        arquivo <- abreArquivo "Copiar de(nome do arquivo de backup): " ReadMode
                        arquivoDestino   <- openFile "dados.txt" AppendMode
                        conteudo   <- hGetContents arquivo
                        hPutStr arquivoDestino (conteudo)
                        hClose arquivoDestino
			putStr "Copiando dados...."

opcao_H   = do 
			 putStrLn "________________AJUDA__________________\n"
			 putStrLn "O sistema tem como finalidade manter os"
			 putStrLn "dados de uma lista pessoal de jogos para"
			 putStrLn "que possam ser acessados/atualizados de"
			 putStrLn "forma rápida, prática e organizada.\n"
			 putStrLn "O menu é auto-explicativo e de fácil"
			 putStrLn "entendimento."

-------------------------          
estaCad::String->String->[[String]]->Bool
estaCad titulo autor [] = False 
estaCad titulo autor (a:b)
 |(compara (titulo++".") x)&&(compara (autor++".") y) = True
 |otherwise                                       = estaCad titulo autor b
                                                  where (x:y:z) = a
{-estaCad retorna True se o cadastro procurado estiver nos registros -}

imprime::[[String]]->IO()
imprime [] = putStrLn "Nao ha dados cadastrados"
imprime (a:[]) = do
		    imprimeDados a
imprime (a:b) = do 
		   imprimeDados a
		   imprime b
--imprime o que tem no arquivo
----------------------
divideArquivo::String->String
divideArquivo [] = []  
divideArquivo (a:b)
 |(a=='\n')= [a]
 |not(a=='\n') = (a:divideArquivo b)  
{- A funcao divideArquivo serve para informar onde termina um cadastro,
 sera usada para formar as listas-}

removeDaString::String->String->String
removeDaString [] _ = []
removeDaString (a:b) [] = (a:b)
removeDaString (a:b) (c:d)
 |a==c = removeDaString b d 
{- Usada para remover da string original os cadastros ja colocados na Lista que esta sendo formada-}

formaLista::String->[String]
formaLista [] = []
formaLista cadastro = (cad1: (formaLista (removeDaString cadastro cad1)))
		    where cad1 = divideArquivo cadastro
{- Usa divideArquivo e removeDaString e retorna uma lista cada cadastro(titulo++autor++genero) e um elemento separado-}

divideDado::String->String
divideDado [] = []
divideDado (a:b)
 |a=='.' = [a]
 |otherwise = (a:divideDado b)
{- Sera usado para informar quando um dado de um cadastro(elemento da lista formada pela funcao acima) termina -}

formaSublistas::String->[String]
formaSublistas [] = []
formaSublistas dado =(dado1:(formaSublistas (removeDaString dado dado1)))
                 where dado1 = divideDado dado

padrao::String->[[String]]
padrao cadastro = map formaSublistas (formaLista cadastro)
{- padrao combina as formaSublistas e formaLista para 'quebrar' a string 'cadastro' em várias listas(cadastros) e estas em sublistas(dados) -}

buscaCad::String->String->[[String]]->Int->IO()
buscaCad titulo autor [] 0 = putStrLn "Não encontrado"
buscaCad titulo autor [] n = putStr ""
buscaCad titulo autor (a:b) n
 |(compara (titulo++".") x)&&(compara (autor++".") y)= do imprimeDados a
						          buscaCad titulo autor b (n+1)	
 |otherwise = buscaCad titulo autor b n
            where (x:y:w:xs) = a 
{-Uma função busca que recebe dois dados(autor e titulo), usada na alteração de dados-} 

buscaGenero::String->[[String]]->Int->IO()
buscaGenero genero [] 0 = putStrLn "Genero não encontrado"
buscaGenero genero [] n = putStr ""
buscaGenero genero (a:b) n
 |compara (genero++".") w = do  imprimeDados a
			        buscaGenero genero b (n+1)
 |otherwise              = buscaGenero genero b n
			 where (x:y:w:xs) = a 

buscaAutor::String->[[String]]->Int->IO()
buscaAutor autor [] 0 = putStrLn "Autor não encontrado"
buscaAutor autor [] n = putStr ""
buscaAutor autor (a:b) n
 |pertence (autor) y 0 = do imprimeDados a
	                    buscaAutor autor b (n+1)
 |otherwise              = buscaAutor autor b n
			 where (x:y:xs) = a  

buscaTitulo::String->[[String]]->Int->IO()
buscaTitulo titulo [] 0 = putStrLn "Titulo não encontrado"
buscaTitulo titulo [] n = putStr ""
buscaTitulo titulo (a:b) n 
 |pertence (titulo) x 0   = do imprimeDados a
			       buscaTitulo titulo b (n+1) 	
 |otherwise = buscaTitulo titulo b n 
	    where (x:xs) = a

compara::String->String->Bool         
compara _ []          = False
compara [] _          = False
compara (a:[]) (x:[]) = if a==x then True else False
compara (a:b) (x:xs)
 |a==x      = compara b xs
 |otherwise = False
{---compara 2 strings e retorna True se forem iguais--}

imprimeDados ::[String]->IO()
imprimeDados [] = putStr ""
imprimeDados (x:y:w:[]) = do 
			       putStr "TITULO:"
                               putStrLn (tira_ponto x)
                               putStr "DESENVOLVEDOR:"
                               putStrLn (tira_ponto y)
                               putStr "GENERO:"
                               putStrLn w
			       delay <- getChar
			       putStr ""
                               
removeCadastro::String->String->[[String]]->[[String]]
removeCadastro titulo autor [] = [[]]
removeCadastro titulo autor conteudo
 |(compara(titulo++".") a)&&(compara(autor++".") b)  = xs
 |otherwise               = (x:(removeCadastro titulo autor xs))
			  where (a:b:c) = x   --(a = titulo de x) 
				(x:xs) = conteudo --(x = 1o. cadastro)
				
desdobra::[[String]]->String  
desdobra [] = []     
desdobra (a:b) = desdobrar a++ desdobra b
{---desdobra retorna uma só lista com todos elementos de todas as sublistas das sublistas  -}

desdobrar::[String]->String     
desdobrar [] = []
desdobrar (a:b) = a++desdobrar b
{--- desdobrar retorna uma lista com todos elementos das sublistas -}

ult::String->String    --remove o último caracter da String
ult (a:b:[]) = [a]     --Se só tiver 2 caracteres, retorna só o 1o.
ult (a:b) = [a]++ult b --Senão coloca a na lista e concatena com ult b


numCadastros::[[String]]->Int
numCadastros conteudo = (length conteudo) --retorna o numero de sublistas 

genero::[[String]]->String->Int
genero [] n = 0
genero conteudo n
 |compara (n++".") z = 1 + genero b n  
 |otherwise   = genero b n
              where (x:y:z:w) = a
                    (a:b) = conteudo
{-- a função genero retorna o numero de cadastros do genero n -}

pertence::String ->String -> Integer -> Bool
pertence a "" 0 = False
pertence a [] n= True
pertence [] a n= True
pertence (x:y) (a:b) n
 |x==a = pertence y b (n+1)
 |otherwise =pertence (x:y) b n 

{- Retorna True se a 1a. string pertence a 2a. 
  ex:
  Main>pertence "calc" "calculo a" 0
  True
Esta função é usada na buscaTitulo e buscaAutor para que possa ser informada só uma substring e
o sistema busca os cadastros certos. -} 

tira_ponto l = filter ('.'/=) l

-- Função lista todos os titulos, antes da busca por titulo 
lista_nomes l = imprime_nome (padrao l)

imprime_nome [] = putStrLn("")
imprime_nome (a:x) = do
			impnome a
			imprime_nome x

impnome [] = putStrLn("")
impnome (a:b:c:[]) = putStrLn (tira_ponto a)
			
--Função lista todos os Desenvolvedores dos jogos cadastrados
--para depois buscar

lista_titulo l = imprime_titulo (padrao l)

imprime_titulo [] = putStrLn("")
imprime_titulo (a:x) = do
			imptitulo (a)
			imprime_titulo x

imptitulo [] =	putStrLn ("")
imptitulo (a:b:c:[]) = putStrLn (tira_ponto b)			

----busca por sub string
busca_substr l1 [] = False
busca_substr l1 (a:x)  |busca_sub l1 (a:x) = True
		       |otherwise = busca_substr l1 x 	
busca_sub [] l2 = True
busca_sub l1 [] = False
busca_sub (a:x) (b:y) |(toLower a) == (toLower b) = True && (busca_sub x y)
		      |otherwise = False

busca_titulo l1 l2 = bus_titulo l1 (padrao l2)

bus_titulo l1 [] = putStrLn("")
bus_titulo l1 (a:x) = do
			alpha l1 a
			bus_titulo l1 x

alpha l1 (a:b:c:[]) | busca_substr l1 (tira_ponto a) = do
							putStr "TITULO:"
                               				putStrLn (tira_ponto a)
                               				putStr "DESENVOLVEDOR:"
                               				putStrLn (tira_ponto b)
                               				putStr "GENERO:"
                               				putStrLn c
			       				delay <- getChar
			       				putStr ""
		     |otherwise = putStr ""
