module Cadastro where
import IO
import System
import Numeric
import Char (toUpper)
import Hugs.Prelude

-- Definições

type Cadastro  = (String,Int,Float,Char)
type Cadastros = [Cadastro]

nome   :: Cadastro -> String
idade  :: Cadastro -> Int
altura :: Cadastro -> Float
sexo   :: Cadastro -> Char

nome   (a,_,_,_) = a
idade  (a,b,c,d) = b
altura (a,b,c,d) = c
sexo   (a,b,c,d) = d


-- Função Principal --
{-- Antes do menu de opções ser exibido, deve ser realizada uma checagem 
a fim de verificar se o arquivo é vazio ou não. Se o arquivo está vazio 
é necessário que a inclusão de uma lista vazia ([]) seja realizada para 
que as demais operações possam ser realizadas com sucesso.
--}

-- 

-- Menu de Opções --
menu::IO()
menu = 
	do
		putStrLn " "
		putStrLn " ___________________________________________"
		putStrLn "|                                           |"
		putStrLn "|           CADASTRO DE PESSOAS             |" 
		putStrLn "|                                           |"
		putStrLn "|   a -  Insere cadastro                    |"
		putStrLn "|   b -  Imprime cadastro                   |"
		putStrLn "|   c -  Busca por nomes                    |"
		putStrLn "|   d -  Soma das idades                    |"
		putStrLn "|   e -  Média das alturas                  |"
		putStrLn "|   f -  Busca por sexo                     |"
		putStrLn "|   g -  Excluir um cadastro                |"
		putStrLn "|   h -  Excluir todos cadastros            |"
		putStrLn "|   i -  Sair do Sistema                    |"
		putStrLn "|___________________________________________|"                  
		putStr "Digite uma das opções:"
		le_opcao

le_opcao :: IO ()
le_opcao=
	   do 	{  
			-- opção do bloco do.... só aceita tipos
			-- monádicos .... onde I/O é uma sub-classe
			opcao <- getChar;
			putStr "\n";
			f_menu (toUpper opcao); -- veja o tipo de f_menu
		}
f_menu :: Char -> IO()
f_menu i =
	  do
		case i of
			'A' -> insereCadastro
			'B' -> imprimeCadastros
			'C' -> buscaNomes
			'D' -> somaIdades
			'E' -> alturaMedia
			'F' -> buscaSexo
			'G' -> excluirCadastro
			'H' -> excluirTodos
			otherwise -> sair i
		putStrLn "Operacao Concluida"
		if not(i=='I') then menu else putStr ""


--insereCadastro :: IO ()
insereCadastro=
		do 
		        pt_arq <- abreArquivo "dados.txt" WriteMode
		       	putStrLn "Nome: "
			nome <- getLine
			putStrLn "Idade: "
			idade <- getLine
			putStrLn "Altura: " 
			altura <- getLine
			putStrLn "M -Masculino |F -Feminino"
			putStrLn "Sexo: "
			sexo <- getChar
-- Marcio: o erro é sempre  aqui....

-- procedimento:
{- 1. abrir arquivo... se não existe ... crie... devolvendo o ponteiro./..
   2. ler conteudo no modo Append ou no modo que interessa....
   3. retornar e manipular (atualizar,inserir,ordenar, excluir,...) a lista lida do arquivo faz tudo o que se deseja com lista...
   4. salvar a lista  nova  no arquivo
   5. fechar arquivo
Isto tem que fazer para cada uma das opcoes acima... haja visto que a lista não estah 
sendo passada como argumento nas opcoes...
-}
			-- cadastros <- readFile "dados.txt"
			 
			-- putStrLn (show cadastro)
		         -- escreveCadastros (cadastro:(read cadastros))
			hPutStr pt_arq (meu_converte nome idade altura [(toUpper sexo)])
			putStrLn "\nAtualizando cadastros...."
			pausa

converte :: String -> String -> String -> String -> IO Cadastro
converte nome idade altura sexo = return (read ("(\""++nome++"\","++idade++","++altura++",'"++sexo++"')"))

-- conserte o pgm para algo simples como ................................... tudo simples e obvio...
meu_converte :: String -> String -> String -> String -> String
meu_converte nome idade altura sexo = nome ++ "#" ++ idade ++ "#" ++ altura ++"#"++ sexo ++ "\n"
meu_converte nome idade altura sexo = "um erro \n"



-- MARCIO OLHE os nomes abaixo..... veja se isto nao dah confusao...
imprimeCadastros :: IO ()    
imprimeCadastros = do 	cadastros <- leCadastros
			imprime cadastros
			putStrLn "Atualizando cadastros...."
			
imprime [] = putStr ""
imprime (x:xs) = do 
			imprimeCadastro x
			imprime xs


		
imprimeCadastro :: Cadastro -> IO()
imprimeCadastro x = putStrLn ((nome x)++"\t"++(show (idade x))++"\t"++(show (altura x))++"\t"++[(sexo x)])
	
			
			
			
buscaNomes = do 
		cadastros <- leCadastros
		putStrLn "Digite o nome desejado: "
		nome <- getLine
		putStrLn "Nome\tIdade\tAltura\tSexo\n\n"
		buscaPorNome cadastros nome

somaIdades :: IO ()
somaIdades = do 
		cadastros <- leCadastros
		putStrLn (show (soma idade cadastros))
			
alturaMedia :: IO ()
alturaMedia = do 
		cadastros <- leCadastros
		putStrLn (show (mediaAltura cadastros))
			
buscaSexo :: IO ()
buscaSexo = do 
		do 
		cadastros <- leCadastros
		putStrLn "Digite o sexo desejado (M | F): "
		sexo <- getChar
		if ( (toUpper sexo) /= 'M' && (toUpper sexo) /= 'F')
			then 
				do
				  putStrLn "Sexo Invalido"
				  buscaSexo
			else
				do
				  putStrLn "Nome\tIdade\tAltura\tSexo\n\n"
				  buscaPorSexo cadastros (toUpper sexo)	
			
excluirCadastro :: IO ()
excluirCadastro = do 
			putStrLn ""
			
			
excluirTodos :: IO ()
excluirTodos = 
		do 	
			putStrLn "Tem certeza que deseja apagar todos os dados do sistema?(s/n)"
			resp <- getChar
			if not((toUpper resp)=='S') then putStrLn "" else 
				  do 	arquivo <-openFile "dados.txt" WriteMode
					hPutStr arquivo ""
					putStrLn "Apagando dados...."       

sair :: Char -> IO ()
sair i 	|i=='I' 	= putStrLn "Saindo do sistema...."
	|otherwise 	= putStrLn "Operacao Invalida..."
	
-- Funções Auxiliares




{- Na presente função, leitura dos cadastros, a função 'read' se faz 
necessária para a conversão do tipo de conteúdo (de String para o 
desejado)
-}
leCadastros :: IO Cadastros
leCadastros = do {
			-- Estah errado este tipo...
			-- O ARQURIVO NAO FOI ABERTO.....
			 pt_arq <- abreArquivo "dados.txt" WriteMode; 
			
			--conteudo <- readFile "dados.txt" 
			-- E NAO FOI FECHADO....
			 return (read conteudo)



-- escreveCadastros :: Cadastros -> IO()
escreveCadastros cadastros =   do
                          { -- algo bem simples como .... 
			  pt_arq <- abreArquivo "dados.txt" WriteMode;
			  adicionaCadastros cadastros pt_arq;
			  fechaArquivo pt_arq;
			  putStr "salvo com sucesso";
			  pausa;
			  }
{- marcio .... aqui é abrir arquivo ... escreve e fechar... só isto....-}				    {-handle <- openFile "dados.txt" WriteMode
				   hPutStr handle "["
				    hClose handle
				    handlea <- openFile "dados.txt" AppendMode
				    adicionaCadastros cadastros handlea
				    hClose handlea
-}
                        

adicionaCadastros [] handle = hPutStr handle "]"
adicionaCadastros (x:[]) handle = hPutStr handle ((show x)++"]")
adicionaCadastros (x:xs) handle = do hPutStr handle ((show x) ++ ",")
				     adicionaCadastros xs handle



buscaPorNome :: Cadastros -> [Char] -> IO ()   
buscaPorNome [] nm      = putStrLn "Cadastro nao encontrado..."
buscaPorNome (x:xs) nm  | (nome x) == nm  =  putStrLn ((nome x)++"\t"++(show (idade x))++"\t"++(show (altura x))++"\t"++[(sexo x)])
			| otherwise       = buscaPorNome xs nm

buscaPorSexo :: Cadastros -> Char -> IO ()   
buscaPorSexo [] sx      = putStrLn "Fim da Pesquisa..."
buscaPorSexo (x:xs) sx  | (sexo x) == sx  = do imprimeCadastro x
					       buscaPorSexo xs sx	
			
			| otherwise       = buscaPorSexo xs sx

soma :: Num a => (Cadastro -> a) -> Cadastros -> a
soma f []     = 0
soma f (x:xs) = (f x) + (soma f xs)

mediaAltura :: Cadastros -> Float
mediaAltura x =  (soma altura x)/( fromInt (length x) )

-- fromInt -> trasnforma de Int para Float

-- FUNCOES AUXILIARES DE ARQUIVOS
abreArquivo :: String -> IOMode -> IO Handle
abreArquivo arquivo modo =
       catch (openFile arquivo modo)
             (\_ -> do {
	               putStrLn ("Impossivel abrir "++ arquivo ++ " permissão negada ~ talvez ");
		       putStrLn "Será aberto com um novo nome default: saida.txt e limpo" ;
                       abreArquivo "saida.txt" WriteMode -- ou openFile "saida.txt" WriteMode diretamente
                       }      
	     )
		      

-- fechaArquivo :: IO Handle -> IO Handle
fechaArquivo handle_arq = hClose handle_arq
{-
       catch (hClose handle_arq)
             (\_ -> do {
	               putStrLn ("Impossivel fechar o arquivo ~ talvez ");
		       pausa;
                       }      
	     )
	     
-}
{-
        modo: AppendMode, WriteMode, ReadMode
-} 
		       

pausa = do{
	  putStrLn "\n\t\t<<Aperte alguma tecla>>";
	  getChar;
        }
		       

