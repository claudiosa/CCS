
para_sempre :: IO () -> IO ()
para_sempre a = do { a; para_sempre a; }

repita_N :: Int -> IO () -> IO ()
repita_N 0 a = return ()
repita_N n a = do { a; repita_N (n-1) a; }

{-
Main> repita_N 7 (putStr " Oi mundo " )
 Oi mundo  Oi mundo  Oi mundo  Oi mundo  Oi mundo  Oi mundo  Oi mundo

 Main> repita_N 7 (putStr ("   Oi mundo " ++ "\n"))
   Oi mundo
   Oi mundo
   Oi mundo
   Oi mundo
   Oi mundo
   Oi mundo
   Oi mundo

Main>  
Main> para_sempre (putChar 'h')
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh........

-}