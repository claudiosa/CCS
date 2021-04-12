{-# OPTIONS_GHC -Wall -Werror #-}

--module  Documentation.SBV.Examples.Puzzles.SendMoreMoney where
module Main where
-- import  Send_more_money
import Data.SBV
-- https://hackage.haskell.org/package/sbv-8.14/docs/src/
main :: IO ()
-- main = print =<< sendMoreMoney
main = do
  result <- send_2 -- sendMoreMoney
  print result

-- | Solve the puzzle. We have:
--
-- >>> sendMoreMoney
-- Solution #1:
--   s = 9 :: Integer
--   e = 5 :: Integer
--   n = 6 :: Integer
--   d = 7 :: Integer
--   m = 1 :: Integer
--   o = 0 :: Integer
--   r = 8 :: Integer
--   y = 2 :: Integer
-- This is the only solution.
--
-- That is:
--
-- >>> 9567 + 1085 == 10652
-- True
-- OK
sendMoreMoney :: IO AllSatResult
sendMoreMoney = allSat $ do
        ds@[s,e,n,d,m,o,r,y] <- mapM sInteger ["s", "e", "n", "d", "m", "o", "r", "y"]
        let isDigit x = x .>= 0 .&& x .<= 9
            val xs    = sum $ zipWith (*) (reverse xs) (iterate (*10) 1)
            send      = val [s,e,n,d]
            more      = val [m,o,r,e]
            money     = val [m,o,n,e,y]
        constrain $ sAll isDigit ds
        constrain $ distinct ds
        constrain $ s ./= 0 .&& m ./= 0
        solve [send + more .== money]



send_2 :: IO AllSatResult
send_2 = allSat $ do
        [s,e,n,d,m,o,r,y] <- mapM sInteger ["s", "e", "n", "d", "m", "o", "r", "y"]
        let 
        --isDigit x = x .>= 0 .&& x .<= 9
          
        send =  s*1000 + e*100 + n*10 + d
        more =  m*1000 + o*100 + r*10 + e 
        money = m*10000 + o*1000 + n*100 + e*10 + y 

        constrain $ distinct [s,e,n,d,m,o,r,y]
        constrain $ sAll isDigit [s,e,n,d,m,o,r,y]
        constrain $ for_each [s,e,n,d,m,o,r,y]
        constrain $ s ./= 0 .&& m ./= 0
        solve [send + more .== money]


for_each [] = True
for_each (a:b) = 
     (a .>= 0 .&& a .<= 9) : for_each b


