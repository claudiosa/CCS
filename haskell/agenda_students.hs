module Agenda_Eletronica where
{- Alunos: Fabio Takeshi Sakamoto
	       Fernando Galera
	   CI�NCIA DA COMPUTA��O - 3� FASE -}

--------------------------------------------------------------------
--                   Sitema de uma Agenda Eletr�nica
--------------------------------------------------------------------

{- No arquivo texto banco.bd ficam os cadastros das pessoas na agenda,
	armazenando o nome da pessoa, idade, email e tel. O padr�o adotado � que cada
	par�metro � separado por sustenido(#)(pessoa#idade#email#tel).
    Utilizando este padr�o foram implementadas as fun��es:
	- incluir dados, ver todos os dados cadastrados, buscar um cadastro pelo nome
    da pessoa, buscar pela idade, buscar pelo email,
	buscar pelo tel, remover dados e alterar dados. -}


import IO
import System
import Char( toUpper )

main = agenda


{- A fun��o iniciar disp�e na tela um menu de op��es. -}

agenda = do{
		putStr "\n";
                putStrLn " **************************************************";
		putStrLn " *               Agenda Eletr�nica                *";
		putStrLn " **************************************************";
        	putStrLn " 1: Incluir pessoa no cadastro";
        	putStrLn " 2: Ver todos as pessoas cadastradas na Agenda";
		putStrLn " 3: Buscar por pessoa (nome da pessoa)";
		putStrLn " 4: Buscar por idade (idade da pessoa)";
		putStrLn " 5: Buscar por email (email da pessoa)";
		putStrLn " 6: Buscar por tel (tel da pessoa) ";
		putStrLn " 7: Remover pessoa do cadastro";
		putStrLn " 8: Alterar par�metros de uma pessoa";
		putStrLn " 9: Verificar quantas pessoas est�o cadastradas";
		putStrLn " 0: Fim";
		putStrLn " *************************************************";
		putStr " Entre com sua op��o: ";
		opcao <- getChar;
		putStr "\n";
   		f_menu opcao;
		}

{- A fun��o getAndOpenFile verifica se o arquivo banco.bd j�
	existe. Se existir ele apenas faz a leitura inicialmente, caso contr�rio cria um
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

{- aux_remove_altera re�ne caracter�sticas comuns das
	fun��es de remo��o e altera��o. -}

aux_remove_altera f = do
			pessoa <- le_pessoa
			cadastros <- busca devolvepessoa pessoa
			if (cadastros == "\nN�o h� registros") then putStrLn cadastros
				else do
					putStrLn cadastros
					putStrLn "\ntel: "
					tel <- getLine
					teste <- remove pessoa tel
					if (teste == "\nDado n�o cadastrado") then putStrLn teste
					 else f

{- le_pessoa l� o nome do pessoa para ser manipulado por outras fun��es. -}

le_pessoa = do
		putStrLn "\npessoa: "
		pessoa <- getLine
		return pessoa


{- le_arq captura os dados inseridos pelo usu�rio e re�ne ao conte�do j� existente
	no arquivo, fazendo a inser��o. -}

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


{- le_arq_imp coloca na tela todo o conte�do do arquivo. -}

le_arq_imp :: IO ()
le_arq_imp = do
	 	fromHandle <- getAndOpenFile ReadMode
		contents <- hGetContents fromHandle
		putStr (subst_separa contents)
		hClose fromHandle
		putStr "\n\nDone."


{- Fun��o que imprime na tela a quantidade de pessoas cadastradas no Banco de Dados -}
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

{- A fun��o busca recebe outra fun��o como par�metro(+ Alta ordem) e executa a busca no arquivo de acordo
	com o dado passado. -}

busca f dado = do
		fromHandle <- getAndOpenFile ReadMode
		contents <- hGetContents fromHandle
		if ((compara f dado contents) == "") then return ("\nN�o h� registros")
			else return (compara f dado contents)

{- A fun��o remove efetua a remo��o. Inicialmente ela faz uma busca e devolve
    na tela o cadastro completo de todos os pessoas com o mesmo nome, para que o usu�rio
	confirme qual o tel do pessoa a ser removido. -}

remove pessoa tel = do
			fromHandle <- getAndOpenFile ReadMode
			contents <- hGetContents fromHandle
			if ((re pessoa tel contents [])=="0") then
				return "\nDado n�o cadastrado"
		 	 else
		   		do
				 toHandle   <- getAndOpenFile WriteMode
				 hPutStr toHandle (re pessoa tel contents [])
          			 hClose toHandle
          			 return "Done."

{- re � uma auxiliar da fun��o remove, que encontra o dado e o retira do arquivo. -}


re :: String -> String -> String -> String -> String
re pessoa tel [] s = "0"
re [] tel x s = []
re pessoa tel x s
	| (pessoa == devolvepessoa x) && (tel == devolvetel x) = s ++ j ++ (devolve x)
	| otherwise = re pessoa tel (devolve x) (s ++ j ++ devolveCad x)
	where
	 j	| length s == 0 = ""
		| otherwise = "\n"


{- A fun��o compara efetua a compara��o entre dados do arquivo e dados passados. -}

compara f a [] = ""
compara f [] x = []
compara f a x
	| comp_sub a (f x) = devolveCad x ++ "\n" ++ compara f a (devolve x)
	| otherwise = compara f a (devolve x)


{- A fun��o comp_sub faz a compara��o letra a letra de duas Strings verificando se uma � substring da outra.-}
comp_sub :: String -> String -> Bool
comp_sub [] a = True
comp_sub a [] = True
comp_sub (a:x) (b:y)
	| toUpper a == toUpper b = True && (comp_sub x y)
	| otherwise = False


{- devolvepessoa trata da devolu��o do nome do pessoa no cadastro do arquivo. -}

devolvepessoa :: String -> String
devolvepessoa [] = []
devolvepessoa (a:b)
	| a == '#' = []
	| otherwise = a:devolvepessoa b



{- devolveCad trata da devolu��o do cadastro completo referente ao nome do
	pessoa no cadastro do arquivo. -}

devolveCad :: String -> String
devolveCad [] = []
devolveCad (a:b)
	| a == '\n' = []
	| otherwise = a:devolveCad b



{- A fun��o devolve trata da devolu��o do restante dos cadastros do arquivo. -}

devolve :: String -> String
devolve [] = []
devolve (a:b)
	| a == '\n' = b
	| otherwise = devolve b


{- A fun��o devolveidade trata da devolu��o da idade da pessoa no cadastro do arquivo -}

devolveidade :: String -> String
devolveidade [] = []
devolveidade (a:b)
	| a == '#' = auxidade b
	| otherwise = devolveidade b

auxidade [] = []
auxidade (a:b)
	| a == '#' = []
	| otherwise = a:auxidade b


{- A fun��o devolveemail trata da devolu��o do email do pessoa no cadastro do arquivo -}

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

{- devolvetel trata da devolu��o do tel do pessoa no cadastro do arquivo -}

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

{-A fun��o sust_separa troca o separador # recebido na String por '\t'(tabula��es)-}

subst_separa :: String -> String
subst_separa [] = []
subst_separa (a:x)
	|a == '#' = '\t':'\t':subst_separa x
	|otherwise = a:subst_separa x