module Agenda_Eletronica where
{- Alunos: Fabio Takeshi Sakamoto
	       Fernando Galera
	   CIÊNCIA DA COMPUTAÇÃO - 3ª FASE -}

--------------------------------------------------------------------
--                   Sitema de uma Agenda Eletrônica
--------------------------------------------------------------------

{- No arquivo texto banco.bd ficam os cadastros das pessoas na agenda,
	armazenando o nome da pessoa, idade, email e tel. O padrão adotado é que cada
	parâmetro é separado por sustenido(#)(pessoa#idade#email#tel).
    Utilizando este padrão foram implementadas as funções:
	- incluir dados, ver todos os dados cadastrados, buscar um cadastro pelo nome
    da pessoa, buscar pela idade, buscar pelo email,
	buscar pelo tel, remover dados e alterar dados. -}


import IO
import System
import Char( toUpper )

main = agenda


{- A função iniciar dispõe na tela um menu de opções. -}

agenda = do{
		putStr "\n";
                putStrLn " **************************************************";
		putStrLn " *               Agenda Eletrônica                *";
		putStrLn " **************************************************";
        	putStrLn " 1: Incluir pessoa no cadastro";
        	putStrLn " 2: Ver todos as pessoas cadastradas na Agenda";
		putStrLn " 3: Buscar por pessoa (nome da pessoa)";
		putStrLn " 4: Buscar por idade (idade da pessoa)";
		putStrLn " 5: Buscar por email (email da pessoa)";
		putStrLn " 6: Buscar por tel (tel da pessoa) ";
		putStrLn " 7: Remover pessoa do cadastro";
		putStrLn " 8: Alterar parâmetros de uma pessoa";
		putStrLn " 9: Verificar quantas pessoas estão cadastradas";
		putStrLn " 0: Fim";
		putStrLn " *************************************************";
		putStr " Entre com sua opção: ";
		opcao <- getChar;
		putStr "\n";
   		f_menu opcao;
		}

{- A função getAndOpenFile verifica se o arquivo banco.bd já
	existe. Se existir ele apenas faz a leitura inicialmente, caso contrário cria um
	arquivo com o nome banco.bd.    -}

getAndOpenFile :: IOMode -> IO Handle
getAndOpenFile mode =
    do
       catch (openFile "banco.bd" mode)
             (\_ -> do putStrLn ("Cannot open banco.bd \n")
  
                       getAndOpenFile WriteMode)
f_menu i =
	 do {
	    case i of	
	    {
	     '1' ->  ler_arq ;
            '2' -> do  {
			putStrLn "\npessoa\t\tidade\t\temail\t\ttel\n" ;
			le_arq_imp ;
		      }	;
	    '3' -> do {
			putStrLn "\npessoa\t\tidade\t\temail\t\ttel\n" ;
			le_arq_imp ;
			pessoa <- le_pessoa ;
			imp_busca devolvepessoa pessoa 
			};
           		
	      '4' -> do {
			putStrLn "\npessoa\t\tidade\t\temail\t\ttel\n" ;
			le_arq_imp ;
			putStrLn "\nidade: " ;
			idade <- getLine ;
			imp_busca devolveidade idade 
           		};
	      '5' -> do
			putStrLn "\npessoa\t\tidade\t\temail\t\ttel\n"
			le_arq_imp
			putStrLn "\nemail: "
			email <- getLine
			imp_busca devolveemail email
           		
	       '6' -> do
			putStrLn "\ntel: "
			tel <- getLine
			imp_busca devolvetel tel
           		
	        '7' -> do
			putStrLn "\npessoa\t\tidade\t\temail\t\ttel\n"
			le_arq_imp
			aux_remove_altera nd
           		
	         '8' -> do
			aux_remove_altera ler_arq
           		
	          '9' -> do
			cont_arq
           		
	           '0' -> do
			putStrLn("Desenvolvido por Fabio Sakamoto e Fernando Galera")
		
                 };   -- fim do case...l
	       if i !=  '0' then agenda else putStrLn  "FIM" ;
         }     

{- imp_busca imprime na tela o resultado da busca. -}

imp_busca f pessoa = do	
putStrLn ("\npessoa\t\tidade\t\temail\t\ttel\n")
			cadastros <- busca f pessoa
			putStrLn (subst_separa cadastros)

nd = putStrLn""

{- aux_remove_altera reúne características comuns das
	funções de remoção e alteração. -}

aux_remove_altera f = do
			pessoa <- le_pessoa
			cadastros <- busca devolvepessoa pessoa
			if (cadastros == "\nNão há registros") then putStrLn cadastros
				else do
					putStrLn cadastros
					putStrLn "\ntel: "
					tel <- getLine
					teste <- remove pessoa tel
					if (teste == "\nDado não cadastrado") then putStrLn teste
					 else f

{- le_pessoa lê o nome do pessoa para ser manipulado por outras funções. -}

le_pessoa = do
		putStrLn "\npessoa: "
		pessoa <- getLine
		return pessoa


{- le_arq captura os dados inseridos pelo usuário e reúne ao conteúdo já existente
	no arquivo, fazendo a inserção. -}

ler_arq :: IO ()
ler_arq = do
		  {
	      fromHandle <- getAndOpenFile ReadMode;
          contents   <- hGetContents fromHandle;
	  putStrLn contents;
	  putStrLn "\npessoa: ";
	  pessoa <- getLine;
	  putStrLn "\nidade: ";
	  idade <- getLine;
	  putStrLn "\nemail: ";
	  email <- getLine;
	  putStrLn "\ntel: ";
	  tel <- getLine;
	  toHandle   <- getAndOpenFile WriteMode;
	  hPutStr toHandle (contents ++ pessoa ++ "#" ++ idade ++ "#" ++ email ++ "#" ++ tel ++ "\n");
          hClose toHandle;
          putStr "Done."
          }


{- le_arq_imp coloca na tela todo o conteúdo do arquivo. -}

le_arq_imp :: IO ()
le_arq_imp = do
	 	fromHandle <- getAndOpenFile ReadMode
		contents <- hGetContents fromHandle
		putStr (subst_separa contents)
		hClose fromHandle
		putStr "\n\nDone."


{- Função que imprime na tela a quantidade de pessoas cadastradas no Banco de Dados -}
cont_arq :: IO ()
cont_arq = do
	 	fromHandle <- getAndOpenFile ReadMode
		contents <- hGetContents fromHandle
		putStrLn ("Total de pessoas cadastradas: ")
		print (conta contents)
		hClose fromHandle
		putStr "\n\nDone."

{- Retorna a quantidade de pessoas cadastradas no Banco de Dados-}
conta :: String -> Int
conta [] = 0
conta (a:x)
	| a == '\n' = 1 + conta x
	|otherwise = 0 + conta x

{- A função busca recebe outra função como parâmetro(+ Alta ordem) e executa a busca no arquivo de acordo
	com o dado passado. -}

busca f dado = do
		fromHandle <- getAndOpenFile ReadMode
		contents <- hGetContents fromHandle
		if ((compara f dado contents) == "") then return ("\nNão há registros")
			else return (compara f dado contents)

{- A função remove efetua a remoção. Inicialmente ela faz uma busca e devolve
    na tela o cadastro completo de todos os pessoas com o mesmo nome, para que o usuário
	confirme qual o tel do pessoa a ser removido. -}

remove pessoa tel = do
			fromHandle <- getAndOpenFile ReadMode
			contents <- hGetContents fromHandle
			if ((re pessoa tel contents [])=="0") then
				return "\nDado não cadastrado"
		 	 else
		   		do
				 toHandle   <- getAndOpenFile WriteMode
				 hPutStr toHandle (re pessoa tel contents [])
          			 hClose toHandle
          			 return "Done."

{- re é uma auxiliar da função remove, que encontra o dado e o retira do arquivo. -}


re :: String -> String -> String -> String -> String
re pessoa tel [] s = "0"
re [] tel x s = []
re pessoa tel x s
	| (pessoa == devolvepessoa x) && (tel == devolvetel x) = s ++ j ++ (devolve x)
	| otherwise = re pessoa tel (devolve x) (s ++ j ++ devolveCad x)
	where
	 j	| length s == 0 = ""
		| otherwise = "\n"


{- A função compara efetua a comparação entre dados do arquivo e dados passados. -}

compara f a [] = ""
compara f [] x = []
compara f a x
	| comp_sub a (f x) = devolveCad x ++ "\n" ++ compara f a (devolve x)
	| otherwise = compara f a (devolve x)


{- A função comp_sub faz a comparação letra a letra de duas Strings verificando se uma é substring da outra.-}
comp_sub :: String -> String -> Bool
comp_sub [] a = True
comp_sub a [] = True
comp_sub (a:x) (b:y)
	| toUpper a == toUpper b = True && (comp_sub x y)
	| otherwise = False


{- devolvepessoa trata da devolução do nome do pessoa no cadastro do arquivo. -}

devolvepessoa :: String -> String
devolvepessoa [] = []
devolvepessoa (a:b)
	| a == '#' = []
	| otherwise = a:devolvepessoa b



{- devolveCad trata da devolução do cadastro completo referente ao nome do
	pessoa no cadastro do arquivo. -}

devolveCad :: String -> String
devolveCad [] = []
devolveCad (a:b)
	| a == '\n' = []
	| otherwise = a:devolveCad b



{- A função devolve trata da devolução do restante dos cadastros do arquivo. -}

devolve :: String -> String
devolve [] = []
devolve (a:b)
	| a == '\n' = b
	| otherwise = devolve b


{- A função devolveidade trata da devolução da idade da pessoa no cadastro do arquivo -}

devolveidade :: String -> String
devolveidade [] = []
devolveidade (a:b)
	| a == '#' = auxidade b
	| otherwise = devolveidade b

auxidade [] = []
auxidade (a:b)
	| a == '#' = []
	| otherwise = a:auxidade b


{- A função devolveemail trata da devolução do email do pessoa no cadastro do arquivo -}

devolveemail :: String -> String
devolveemail [] = []
devolveemail (a:b)
	| a == '#' = auxemail b
	| otherwise = devolveemail b

auxemail [] = []
auxemail (a:b)
	| a == '#' = aux2email b
	| otherwise = auxemail b

aux2email [] = []
aux2email (a:b)
	| a == '#' = []
	| otherwise = a:aux2email b

{- devolvetel trata da devolução do tel do pessoa no cadastro do arquivo -}

devolvetel :: String -> String
devolvetel [] = []
devolvetel (a:b)
	| a == '#' = auxtel b
	| otherwise = devolvetel b

auxtel [] = []
auxtel (a:b)
	| a == '#' = aux2tel b
	| otherwise = auxtel b

aux2tel [] = []
aux2tel (a:b)
	| a == '#' = aux3tel b
	| otherwise = aux2tel b

aux3tel [] = []
aux3tel (a:b)
	| a == '\n' = []
	| otherwise = a:aux3tel b

{-A função sust_separa troca o separador # recebido na String por '\t'(tabulações)-}

subst_separa :: String -> String
subst_separa [] = []
subst_separa (a:x)
	|a == '#' = '\t':'\t':subst_separa x
	|otherwise = a:subst_separa x