lista_de_acoes :: [ IO() ] 
lista_de_acoes =
    [ putStrLn   "Aqui começa uma lista de ações de IO" ,
      do { putStr   "Digite dois números::  "  ;
           x <-  le_Float   ;
           y <-  le_Float   ;
	   putStr "A média é dada por:  " ;
           print ( f_media_2  x  y ) ;
	 } ,
      putStr "\n saltando de linha \n"   ,
      do
	  putStrLn " Tudo visivel localmente neste 'do' "    
	  putStr   "O tamanho dessa  lista de ações: "    ,
     print  ( f_compto   lista_de_acoes ),
     putStr "\n \t FIM ..."  
    ]    

-- lendo um valor real
le_Float :: IO Float
le_Float = do { linha <- getLine ;
                 return (read linha :: Float) ;
              }		  

-- comprimento de uma lista
f_compto :: [ IO() ]  -> Int
f_compto [] = 0
f_compto (a:b) = 1 +  f_compto b	      

-- valor médio entre dois números
f_media_2  :: Float   -> Float   -> Float  
f_media_2     x    y    = (/)  ( (+) x  y )  2

-- função genérica de execuçao de uma lista
exec_lista ::  [ IO() ]  ->  IO()
exec_lista [] = return ()
exec_lista (a:b) = do { a ;
                       exec_lista  b; 
		      }




mp_lista_1 ::  [ Int ]  ->  IO()
imp_lista_1 [] = return ()
imp_lista_1  (a:b) = do { print a ;
                       imp_lista_1  b ;
                       }
					     
{-
Main>
imp_lista_1 [4 .. 9]
4
5
6
7
8
9

-}


imp_lista_2 ::  [ Int ]  ->  IO()
imp_lista_2 [] = return ()
imp_lista_2  (a:b) = do { putStr (show a);
                             imp_lista_2  b;
                                }
							  
{-
Main> imp_lista_2 [4 .. 9]
456789
Main>
-}

-- 
