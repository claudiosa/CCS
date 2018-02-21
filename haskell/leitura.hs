import IO

dobro x = x * x

main = do
      putStrLn     " Lendo um inteiro "
      um_int  <- le_int_2          
      print ( dobro  um_int )
      putStrLn     " Lendo um real "
      um_float  <- le_float_2     
      print ( dobro  um_float )
      print " FIM do  main "	  
 
le_float_2 :: IO Float
le_float_2 = readLn
le_int_2 :: IO Int
le_int_2 = readLn

