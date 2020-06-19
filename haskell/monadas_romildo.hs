module Main (main) 
    where
import System.IO ( stdout, hSetBuffering, BufferMode(NoBuffering) )
main :: IO ()
main = do 
    { 
    hSetBuffering stdout NoBuffering;
    putStr "Digite um número: ";
    s1 <- getLine;
    putStr "Digite outro número: ";
    s2 <- getLine ;
    putStr "Soma: ";
    putStrLn (show (read s1 + read s2) )
    }

{--
    *Main> main
    Digite um número: 3
    Digite outro número: 4
    Soma: 7

--}    