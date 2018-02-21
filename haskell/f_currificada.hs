
f_7 x = 7 + x

duas_f f  = f . f
idem_f f a = f ( f a )


tres_1_f f  =  f . f . f
tres_2_f f =  duas_f f . f
tres_3_f f =  f .  duas_f  f

{-
Main> duas_f  f_7    7
21
Main> duas_f  f_7    3
17
Main> 
Main>  f_7     3
10
Main> duas_f   f_7   3
17
Main> tres_1_f  f_7  3
24
Main> tres_2_f  f_7  3
24
Main> tres_3_f  f_7  3
24

Main> :type f_7     
f_7 :: Num a => a -> a
Main> :type duas_f
duas_f :: (a -> a) -> a -> a
Main> :type tres_1_f
tres_1_f :: (a -> a) -> a -> a
Main> :type tres_2_f
tres_2_f :: (a -> a) -> a -> a
Main> :type tres_3_f
tres_3_f :: (a -> a) -> a -> a
Main> :type (.)
(.) :: (a -> b) -> (c -> a) -> c -> b

-}
