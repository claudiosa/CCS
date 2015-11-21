



soma_lista :: [Int] -> Int
soma_lista [] = 0
soma_lista (x:xs) = x + soma_lista xs

data Dia = Segunda | Terça | Quarta | Quinta | Sexta | Sábado | Domingo
           deriving (Enum,Show)
----------------------------------------------------------------------------------------------	   
f_um_int :: Int 
f_um_int = 77	   
{-
Main> 789 /  f_um_int
ERROR - Cannot infer instance
*** Instance   : Fractional Int
*** Expression : 789 /  f_um_int

Main> 789 / (fromIntegral)  f_um_int
10.2467532467532

Main> :t  (/)
(/) :: Fractional a => a -> a -> a

-}
{-	   

Main> log 77
4.34380542185368

Main> log     f_um_int
ERROR - Cannot infer instance
*** Instance   : Floating Int
*** Expression : log  f_um_int

Main> :t log
log :: Floating a => a -> a

Main> log (fromIntegral     f_um_int)
4.34380542185368

Main> :t sin
sin :: Floating a => a -> a

-}	   
f_dois_integer :: Integer	   
f_dois_integer = 99


le_imprime_1 = getLine >>= \e -> putStrLn e
le_imprime_2 = do  e <- getLine
                   putStrLn e
