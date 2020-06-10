go :: IO ()
go = do
    main
    -- main2 -- (it is not at same type)
    main3
    putStrLn "The End"

main :: IO ()
main = putStrLn "xxxxxxx"

main2 :: String
main2 = show (f  2  4)

--print :: Show a => a -> IO ()     -- Defined in ‘System.IO’
--main3 :: Show a => a -> IO ()
main3 :: IO ()
main3 = print (f 2 3)

f :: Num a => a -> a -> a
f x y = (+) x y 
