{- Alunos: Fredi Rolf Bieging
           Reges B. Boegershausen
-}
module Farmacia where

import IO
import System
import Char (toUpper)

farmacia = inicio

inicio :: IO ()
inicio =
       do    {
       	putStrLn "--------------------------------------------------";
		putStrLn "*                MANO DRUGSTORE                  *";
        putStrLn "--------------------------------------------------";
        putStrLn "1 -> Cadastrar Remédio";
        putStrLn "2 -> Listar todos os remédios";
        putStrLn "3 -> Buscar por nome científico";
        putStrLn "4 -> Buscar por nome comercial";
        putStrLn "5 -> Buscar por classificação";
        putStrLn "6 -> Buscar por preço";
        putStrLn "7 -> Remover Cadastro";
        putStrLn "8 -> Alterar Cadastro";
        putStrLn "9 -> Sair";
        putStr "\nDigite uma das opções acima:";
        ler_op;
               }

{----------Le a opção do menu---------------}

ler_op :: IO ()
ler_op = do{
        opcao <- getChar;
		putStr "\n";
		menu opcao;
        }

menu :: Char -> IO ()
menu i =
     do
       case i of
              '1' -> do
                       cadastrar
                       inicio
              '2' -> do
                       putStrLn "\nCIENTÍFICO\tCOMERCIAL\tCLASSIFICAÇÃO\tPREÇO"
                       listar
                       inicio
              '3' -> do
		       listar
                       putStr "\nNome Científico: "
                       cient <- getLine
                       printb nome_cient cient
                       inicio
              '4' -> do
		       listar
                       putStr "\nNome Comercial: "
                       comerc <- getLine
                       printb nome_comerc comerc
                       inicio
              '5' -> do
		       listar
                       putStr "\nClassificação: "
                       classif <- getLine
                       printb dev_class classif
                       inicio
              '6' -> do
		       listar
                       putStr "\nPreço: "
                       preco <- getLine
                       printb dev_preco preco
                       inicio
              '7' -> do
                       rem_alt gambi
                       inicio
              '8' -> do
                       rem_alt cadastrar
                       inicio
              '9' -> putStrLn "Sistema encerrado!"


gambi = putStrLn ""

{-----Cadastra um novo produto-------------}

cadastrar :: IO ()
cadastrar =
          do
            putStrLn "\nNome Científico: "
            cientifico <- getLine
            putStrLn "\nNome Comercial: "
            comercial <- getLine
            putStrLn "\nClassificação: "
            classe <- getLine
            putStrLn "\nPreço: "
            preco <- getLine
            toHandle <- getAndOpenFile AppendMode
            hPutStr toHandle (cientifico ++ "\t" ++ comercial ++ "\t" ++ classe ++ "\t" ++ preco ++ "\n")
            hClose toHandle

{------Lista todo o conteúdo do arquivo---------}

listar :: IO ()
listar =
          do
            {
            fromHandle <- getAndOpenFile ReadMode;
		    conteudo <- hGetContents fromHandle;
		    putStr conteudo;
		    putStrLn "\n\n";
		    hClose fromHandle;
            }

{--------Imprime o resultado da busca--------------}

printb f pessoa =
          do
             {
             putStrLn "\nCIENTÍFICO\tCOMERCIAL\tCLASSIFICAÇÃO\tPREÇO";
			 cadastros <- busca f pessoa;
			 putStrLn cadastros;
			 }


{-------Executa a busca segundo os parametros passados----------}

busca f dado =
        do
          {
		  fromHandle <- getAndOpenFile ReadMode;
    	  	  contents <- hGetContents fromHandle;
		  if ((compara f dado contents) == "") then return ("\nNão há registros")
		  else return (compara f dado contents);
          }

{--A função compara efetua a comparação entre dados do arquivo e dados passados--}

compara f a [] = ""
compara f [] x = []
compara f a x
	|comp_sub a (f x) = devolveCad x ++ "\n" ++ compara f a (devolve x)
--	| a == f x = devolveCad x ++ "\n" ++ compara f a (devolve x)
	| otherwise = compara f a (devolve x)

comp_sub :: String -> String -> Bool
comp_sub [] a = True
comp_sub a [] = True
comp_sub (a:x) (b:y)
	|toLower a == toLower b = True && (comp_sub x y)
	|otherwise = False

{--------------------}

rem_alt f =
                    do





                      {
                      putStrLn "Nome científico: ";
			          nc <- getLine;
			          cadastros <- busca nome_cient nc;
			          if (cadastros == "\nNão há registros")
                      then putStrLn cadastros
                      else
                           do
                             {
					         putStrLn cadastros;
					         putStrLn "\nClassificação: ";
					         classif <- getLine;
					         ret <- remove nc classif;
					         if (ret == "\nDado não cadastrado")
                             then putStrLn ret
                             else f;
					         }
                    }

{- A função inicialmente faz uma busca e devolve o cadastro completo de todos os dados com o mesmo nome, para que o usuário confirme qual o dado a ser apagado. -}

remove nome classif =
                  		do
                  			{
                    		fromHandle <- getAndOpenFile ReadMode;
			        		contents <- hGetContents fromHandle;
			        		if (rm nome classif contents [] == "0")
			        		then return "\nDado não cadastrado"
                    		else
                        		do  
                        			{                        			
				          			toHandle <- getAndOpenFile WriteMode;
				          			hPutStr toHandle (rm nome classif contents []);
          			      			hClose toHandle;
          			      			return "Ok";
          			      			}
          			      	}	
                    		


{- rm é uma auxiliar da função remove, que encontra o dado e o retira do arquivo. -}

rm :: String -> String -> String -> String -> String
rm nome classif [] s = "0"
rm [] classif x s = []
rm nome classif x s
	| (nome == nome_cient x) && (classif == dev_class x) = s ++ j ++ (devolve x)
	| otherwise = rm nome classif (devolve x) (s ++ j ++ devolveCad x)
	where
	 j	| length s == 0 = ""
		| otherwise = "\n"



{------Abre o arquivo para modo "mode"(passado como parametro)-------}

getAndOpenFile :: IOMode -> IO Handle
getAndOpenFile mode =
    do
       catch (openFile "generic.txt" mode)
             (\_ -> do putStrLn ("Impossível abrir generic.txt \n")
                       getAndOpenFile WriteMode)


{-------Devolve o restante dos cadastros do arquivo------}

devolve :: String -> String
devolve [] = []
devolve (a:b)
	| a == '\n' = b
	| otherwise = devolve b

{----Devolve o cadastro completo------}

devolveCad :: String -> String
devolveCad [] = []
devolveCad (a:b)
	| a == '\n' = []
	| otherwise = a:devolveCad b

{------Devolve o nome cientifico--------}

nome_cient :: String -> String
nome_cient [] = []
nome_cient (a:b)
	| a == '\t' = []
	| otherwise = a : nome_cient b

{------Devolve o nome comercial--------}

nome_comerc :: String -> String
nome_comerc [] = []
nome_comerc (a:b)
	| a == '\t' = aux_nome b
	| otherwise = nome_comerc b

aux_nome [] = []
aux_nome (a:b)
	| a == '\t' = []
	| otherwise = a:aux_nome b

{------Devolve a classificação--------}

dev_class :: String -> String
dev_class [] = []
dev_class (a:b)
	| a == '\t' = aux_class b
	| otherwise = dev_class b

aux_class [] = []
aux_class (a:b)
	| a == '\t' = aux_aux_class b
	| otherwise = aux_class b

aux_aux_class [] = []
aux_aux_class (a:b)
	| a == '\t' = []
	| otherwise = a:aux_aux_class b


{---------Devolve o preço------------}

dev_preco :: String -> String
dev_preco [] = []
dev_preco (a:b)
	| a == '\t' = aux_preco b
	| otherwise = dev_preco b

aux_preco [] = []
aux_preco (a:b)
	| a == '\t' = aux_aux_preco b
	| otherwise = aux_preco b

aux_aux_preco [] = []
aux_aux_preco (a:b)
	| a == '\t' = aux_aux_aux_preco b
	| otherwise = aux_aux_preco b

aux_aux_aux_preco [] = []
aux_aux_aux_preco (a:b)
	| a == '\n' = []
	| otherwise = a:aux_aux_aux_preco b