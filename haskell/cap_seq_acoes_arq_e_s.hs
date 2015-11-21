import IO
olaMundo :: IO ()
olaMundo = putStr "Olá mundo!"
num_float :: Float
num_float = 3.4567
num_double :: Double
num_double = 9.87654
imprime :: Show a => a -> IO ()
imprime x = print x


le_Int :: IO Int
le_Int = do linha <- getLine
            return (read linha :: Int)

le_Float :: IO Float
le_Float = do linha <- getLine
              return (read linha :: Float)

soma_Int :: IO Int
soma_Int = do linha_1 <- le_Int
              linha_2 <- le_Int
 	      return (linha_1 + linha_2)
	      
soma_Interage :: IO ()
soma_Interage = do putStrLn "Entre com os números a serem somados:"
                   sum <- soma_Int
	 	   putStrLn "A soma é"
		   print sum
	      


w_arq_h  :: IO ()
w_arq_h =  do 
           fh <- openFile   "teste_1.txt"  WriteMode
           hPutStr  fh "Escrevendo no arquivo usando handles ! \n"
	   putStr   "Escrita com sucesso !"
	   hFlush   fh
	   hClose   fh


r_arq_h :: IO ()
r_arq_h = do 
          fh <- openFile   "teste_1.txt"   ReadMode
          conteudo <-  hGetContents   fh
	  putStrLn   conteudo
	  putStr     "Apresentada leitura do conteudo !" 
          hClose     fh


a_arq_h  :: IO ()
a_arq_h =  do
           fh <- openFile   "teste_1.txt"  AppendMode
           hPutStr  fh "Escrevendo no final deste arquivo ... \n"
           putStr   "Anexado com sucesso !"
	   hFlush   fh
	   hClose   fh
				 

w_direta :: IO ()
w_direta = do 
          writeFile   "teste_2.txt" "Escrevendo diretamente  no arquivo \n "
          putStr      " Já escrito algo em teste_2.txt"

r_direta :: IO ()
r_direta  = do 
            conteudo <- readFile "teste_2.txt"
            putStr     conteudo
	    putStr    " Sem mais nada em teste_2.txt"
	       

a_direta :: IO ()
a_direta = do
           appendFile   "teste_2.txt"  "\n Anexando no final do arquivo \n"
	   putStr        " ... Anexado OK ..."

----------------------------------------------------------------------------
le_imprime :: IO () 
le_imprime = do 
               {entrada <- getLine;    -- início do laço
                if ( entrada  == [] )  -- teste condicional
		      then return ()
                      else  do {putStrLn   entrada; 
                                le_imprime; }      
		   } -- fim do laço	
----------------------------------------------------------------------------	   
le_arquivo :: IO ()
le_arquivo =
 do
  { catch (testa_arquivo) trataErro;} 
    where  
     testa_arquivo   = do
        {conteudo <- readFile  "dados_2.txt";
	 putStr "Leitura do arquivo com sucesso!!!";
         return (read conteudo);
         }
     trataErro  erro = if IO.isDoesNotExistError erro
     	  then do
	{ putStr "Gerou uma exceção. Um arquivo novo foi criado";
	  writeFile  "dados_2.txt"   "Mensagem da exceção!!";
        }
        else	ioError erro
	  
	  
	  
	  




