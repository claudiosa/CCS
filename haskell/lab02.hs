{-
Prelude> 3 + 4                                              
7
Prelude> + 3  4 

<interactive>:1:0: parse error on input `+'
Prelude> (+) 3  4
7
Prelude> 

Prelude> (-) 3  (-4)
7
Prelude>  3 - (-4)  
7

-}

{- Duvida: Como executar um programa no INTERPRETADOR?
Prelude> :h n ISTO EH UM HELP

Prelude> :load lab02.hs 
[1 of 1] Compiling Main             ( lab02.hs, interpreted )
Ok, modules loaded: Main.


-}


hip_t_r a b = sqrt ((+) (a^2) (b^2))

alfa a b =  a / (hip_t_r a b) -- relacao decimal
beta a b =  b / (hip_t_r a b)

ang_alfa  a b = ( acos (alfa a b) * 180)    /    pi

ang_beta  a b = ( sen (beta a b) * 180)    /    pi




{-
*Main> acos (0.7071067811865475)
0.7853981633974484
*Main> (acos (0.7071067811865475) * 180)/pi
45.00000000000001
*Main> 

  para casa: acertar tudo .... 
  -}









