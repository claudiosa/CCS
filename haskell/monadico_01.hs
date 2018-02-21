
-- poe_x = getChar  >>= (ins_x )   >>= putStr
poe_x = getChar  >>=  putChar -- primitiva monadica "bind" (>>=) acoplamento

imp_2_char (c1,c2) = do { putChar c1; putChar c2; }

ler_2_char_1 = getChar >>= \x1 ->
               getChar >>= \x2 ->
	       return(x1,x2)
	       
ler_2_char_2 = do { x1 <- getChar; 
                    x2 <- getChar ;
	            return(x1,x2)
	          }
	       

ins_x a = a:" uma string "
