-- http://jxs.me/2010/06/28/tail-recursion-haskell/
-- Lenght  of any  list -- 
no_tail_lenght :: Num p => [a] -> p
no_tail_lenght [] = 0
no_tail_lenght (_:b) = 1 +  no_tail_lenght b

-- Sum all elements of numeric list
no_tail_sum :: Num p => [p] -> p
no_tail_sum [] = 0
no_tail_sum (a:b) = a + no_tail_sum b


{- TAIL RECURSIVE IN HASKELL -}

-- Example 01
length2 :: Num p => [a] -> p
length2 [] = 0
length2 (a:b) = tail_length (a:b) 0
  where
    tail_length [] count = count
    tail_length (_:b) count = tail_length b (count+1)

-- Example 02
fact2 :: (Eq t, Num t) => t -> t
fact2 x = tailFact x 1
    where 
      tailFact 0 a = a
      tailFact n a = tailFact (n - 1) (n * a)

-- Example 03
sum_2 :: Num t => [t] -> t
sum_2 lst =  tail_sum lst 0
   where
       tail_sum [] v_sum = v_sum
       tail_sum [a] v_sum = (a + v_sum)
       tail_sum (a:b) v_sum =  tail_sum b (v_sum + a)

-- Example 04
{- It is already tail recursive -}
member :: Int -> [Int] -> Bool
member _ [] = False
member x (q:ws)
   | (x == q) = True
   | otherwise = member x ws 