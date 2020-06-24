
module DOT_COMP where
-- DOT COMPOSITION functions

--my_sum :: Num a => a -> a -> a
my_sum :: Int -> Int  -> Int 
my_sum x  y =  (+) x  y

my_sum_10 :: Int -> Int  
my_sum_10 x =  (+) x 10

my_double :: Int -> Int  
my_double x = (*) 2 x

dot_comp_1, dot_comp_2, dot_comp_3 :: Int -> Int
dot_comp_1  = my_double . my_sum_10 -- in 2 out 24
dot_comp_2  = my_sum 7 . my_double . my_sum_10  -- in 2 out 24 + 7  = 31
dot_comp_3  = dot_comp_1 . dot_comp_1 


my_exp :: Int -> Int  -> Int
my_exp x 0 = 1
my_exp x 1 = x
my_exp x n | n > 0 = x * my_exp x (n-1)
my_exp _ n | n < 0 = error "Negative Expoention in my_exp \n"
-- my_exp _ _ = 