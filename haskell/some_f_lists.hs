

module MY_LISTS where

{-  To be improved -}
n_esimo  _ [] = error "EMPTY LIST" 
n_esimo n _ | n <= 0 = error "Negative number or invalid index"
n_esimo 1 (a:_) = a
n_esimo n (a:b) = n_esimo (n-1) b
{-
*Main> n_esimo 3 ["a","b","c","d"]
"c"
*Main> n_esimo (-3) ["a","b","c","d"]
"*** Exception: negative number or invalid index
CallStack (from HasCallStack):
  error, called at some_f_lists.hs:2:24 in main:Main
*Main> n_esimo 0 ["a","b","c","d"]
"*** Exception: negative number or invalid index
CallStack (from HasCallStack):
  error, called at some_f_lists.hs:2:24 in main:Main
*Main> n_esimo 0 []
*** Exception: EMPTY LIST
CallStack (from HasCallStack):
  error, called at some_f_lists.hs:1:17 in main:Main
*Main> 

-}
{-  To be improved -}
back_index_of_value  _ [] = error "X is not in this list"
back_index_of_value  x (a:_) | x ==a  = 1
back_index_of_value  x (a:b) | not(x == a) = 1 + back_index_of_value x b
back_index_of_value _ _   = error "Please check your code"


{- prime number -}
eh_primo :: Int -> Bool
eh_primo 0  =  False
eh_primo 1  =  True
eh_primo n
        |(n_divisiveis n n == 2)   = True
        | otherwise         = False

{- how many divisors between two numbers a/b -}
n_divisiveis :: Int-> Int-> Int
n_divisiveis a 1   = 1
n_divisiveis a b
        |(mod a b == 0) = 1 + n_divisiveis a (b-1)
        |otherwise      = n_divisiveis a (b-1)

{- given a list, which is the first prime number -}
primeiro_primo :: [Int] -> Int
primeiro_primo (x:xs) | eh_primo x = x
        | otherwise = primeiro_primo xs
