\begin{verbatim}
module Meu_Menu where
import IO
import System 


-- Dúvidas Gerais antes de começar ......

frase = "Isto é uma string"

f 1 = "resposta errada"
f 2 = "OK string"

f_demo x = sqrt x


{-
Menu> putStrLn  "45"
45

Menu> putStr (f 1)
resposta errada
Menu> putStr  frase
Isto é uma string

Menu> :type putStr
putStr :: String -> IO ()
Menu> :type putStrLn
putStrLn :: String -> IO ()

 Imprimindo inteiros...
Menu> show (34+3)            
"37"

Menu> show ( 34.78 / 3.56)
"9.76966292134832"
logo:
Menu> :type show
show :: Show a => a -> String

Menu> show (f 1)
"\"resposta errada\""


Menu> show ((f 1)++(f 2))
"\"resposta erradaOK string\"

-}

{- se utilizar como um executável.... 
 a primeira a ser chamada como default
 no caso main
-}

main :: IO ()
main =
	imp_menu

imp_menu :: IO ()
imp_menu =
	do
	   putStrLn "\n *****************************" 			
	   putStrLn " Opção s: Soma a+b     "	
	   putStrLn " Opção l: Le lista str "
	   putStrLn " Opção r: Num Reais    "	
	   putStrLn " Opção f: Fim          "	
	   putStrLn " *****************************"	
	   putStr   " Digite i, e ou s: "	
	   le_opcao

{- Tipicamente é uma sequência de funcoes.... -}

le_opcao :: IO ()
le_opcao =
       do { opcao <- getChar;
           f_menu opcao
	  }	   

f_menu :: Char -> IO ()	   	
f_menu i  =
 do
 case (i) of
   's' ->   do { soma_a_b; imp_menu}			
   'l' ->   do { putStrLn "\n\n Comece a digitar...\n\n";
			   x <- le_lista; 
			   putStrLn x; 
			   imp_menu
		}
   'r' ->   do { mexe_real ; 
                 imp_menu  }		
{-		
   'n' ->  do  { putStrLn "\n\n Comece a digitar...\n\n" ;
		y <- le_L_num ; 
		putStrLn  y; 
		imp_menu
  	       }
-}	  

   'f' ->  do { putStrLn "\n bye-bye !!!"  }	
   _   ->  do { imp_menu }

{- Erro tipico:
Prelude> :l aula09_menu_io1.hs 
ERROR "aula09_menu_io1.hs":33 - Syntax error in expression 
(unexpected `}', possibly due to bad layout)
Isto indica: alinhamento de do e  { ....
-}

soma_a_b :: IO ()
soma_a_b =
       do {
	 hSetBuffering stdout NoBuffering ; 
	 -- setando a saída padrão...
	 -- sem bufferização...
	 putStr   "\n \n Entre com um  inteiro: "  ;
         x1 <- readNum ;
	 putStr (show x1) ;
	 putStr "  imprimiu o x1  .... \n " ;
         putStr   "Entre com um outro inteiro: "  ;
         x2 <- readNum ;
	 putStr (show x2);
	 putStr "  imprimiu o x2  .... \n " ;
         putStr  ("A soma é " ++ show (x1+x2) ++ "\n")
         }
        

mexe_real :: IO ()
mexe_real =
       do {
           hSetBuffering stdout NoBuffering ; 
	   -- setando a saída padrão...
	   -- sem bufferização...
	  putStr   "\n \n Entre com um real: "  ;
      x <- read_real ;
	  putStr ( show x ) ;
	  putStr "  imprimiu o x  .... \n " ;
	  putStr "  novamente o x  ....  " ;
      putStr (show (x + 7)) ;
	  putStr " \n  ainda o x  .... " ;
      putStr (show (f_demo (x + 7))) ;
	  }
	 
{-

 Entre com um real: 4
4.0  imprimiu o x  .... 
   novamente o x  ....  11.0 
  ainda o x  .... 3.316625
 ***************************

-}

readNum :: IO Integer
readNum =  
       	do { 
       	line <- getLine; 
       	readIO  line }


read_real :: IO Float
read_real =
        do {
	    line <- getLine;
	    readIO  line }

le_lista :: IO String
le_lista  = do {
		hSetBuffering stdin NoBuffering ; -- não é necessário
		 caracter <- getChar;
		   if caracter == '\n' -- foi finalizado com um enter...
		      then return ""
		      else do { cauda <- le_lista;
			       return (caracter:cauda)
			       }
		}		   	

{- funcionava ??? algum aluno para consertar....
-- lê uma lista de números... para o tipo IO
le_L_num :: [IO Integer]
le_L_num  = do {
		hSetBuffering stdin NoBuffering ; -- não é necessário
		num <- readNum;
		if num == 0  -- foi finalizado com um 0...
		   then return []
		   else do {  cauda <- le_L_num ;
			     return (num:cauda)
			    }
	       }		   	
			  
-}

{- Construído por Claudio Cesar de Sá, 9/9/2002
   revisado em maio/2004 ....
-}
\end{verbatim}
