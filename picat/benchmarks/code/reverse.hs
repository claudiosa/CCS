import Text.Printf
import Control.Exception
import System.CPUTime

normal_reverse []    = []
normal_reverse (x:t) = (normal_reverse t) ++ [x]

tailend_reverse         lst   = tailend_reverse_aux [] lst
tailend_reverse_aux acc []    = acc
tailend_reverse_aux acc (x:t) = tailend_reverse_aux (x:acc) t

time :: IO t -> IO t
time fun = do
    start <- getCPUTime
    v <- fun
    end   <- getCPUTime
    let diff = (fromIntegral (end - start)) / (10^12)
    printf "%0.6f secs\n" (diff::Double)
    return v

bench fun funName siz = do
    printf "%s with %d: " (funName::[Char]) (siz::Int)
    let list = [1..siz]
    time $ fun list `seq` return ()

dummy [] = []
dummy (h:t) = dummy t

main = do
    bench dummy           "dummy"           10000000
    bench normal_reverse  "normal reverse"  1000000
    bench tailend_reverse "tailend reverse" 1000000
    bench normal_reverse  "normal reverse"  10000000
    bench tailend_reverse "tailend reverse" 10000000