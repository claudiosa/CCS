 {- 
    main = putStrLn "hello, world"

        $ ghc --make helloworld
    [1 of 1] Compiling Main             ( helloworld.hs, helloworld.o )
    Linking helloworld ...


        $ ./helloworld
    hello, world


        ghci> :t putStrLn
    putStrLn :: String -> IO ()
    ghci> :t putStrLn "hello, world"
    putStrLn "hello, world" :: IO ()


        main = do   print True
                print 2
                print "haha"
                print 3.2
                print [3,4,3]

    $ runhaskell print_test.hs
    True
    2
    "haha"
    3.2
    [3,4,3]
        main = do
        c <- getChar
        if c /= ' '
            then do
                putChar c
                main
            else return ()

This program looks like it should read a character and then check if it's a space.
 If it is, halt execution and if it isn't, print it to the terminal and then do the same thing all over again.




    main = do
    putStrLn "Hello, what's your name?"
    name <- getLine
    putStrLn ("Hey " ++ name ++ ", you rock!")


    ghci> :t getLine
getLine :: IO String

    main = do
        putStrLn "Hello, what's your name?"
        name <- getLine
        putStrLn $ "Read this carefully, because this is your future: " ++ tellFortune name


       main = do
        foo <- putStrLn "Hello, what's your name?"
        name <- getLine
        putStrLn ("Hey " ++ name ++ ", you rock!")


      main = do
    a <- return "hell"
    b <- return "yeah!"
    putStrLn $ a ++ " " ++ b



          main = do
        let a = "hell"
            b = "yeah"
        putStrLn $ a ++ " " ++ b


          main = do   putStr "Hey, "
                putStr "I'm "
                putStrLn "Andy!"

    $ runhaskell putstr_test.hs
    Hey, I'm Andy!



        main = do   putChar 't'
                putChar 'e'
                putChar 'h'



    putStr :: String -> IO ()
putStr [] = return ()
putStr (x:xs) = do
    putChar x
    putStr xs



        main = do   print True
                print 2
                print "haha"
                print 3.2
                print [3,4,3]

    $ runhaskell print_test.hs
    True
    2
    "haha"
    3.2
    [3,4,3]


    import Control.Monad

    main = do
        c <- getChar
        when (c /= ' ') $ do
            putChar c
            main

So as you can see, it's useful for encapsulating the if something then do some I/O action else return () pattern.


        main = do
        a <- getLine
        b <- getLine
        c <- getLine
        print [a,b,c]

Is exactly the same as doing this:.

    main = do
        rs <- sequence [getLine, getLine, getLine]
        print rs

sequence takes a list of I/O actions and returns an I/O actions that will perform those actions one after the other.

Prelude> sequence [putChar 'a', putChar 'b']
ab[(),()]
Prelude>

Prelude> let x = 'a'
Prelude> print x
'a'
Prelude> 


Prelude>     putStrLn $ "precisa do $ quando " ++ " usa varias" ++ "funcoes"
precisa do $ quando  usa variasfuncoes

Prelude> putStrLn $ "Hey " ++ "xxxx"  ++ ", you rock!"  
Hey xxxx, you rock!
OU
Prelude> putStrLn ("Hey " ++ "xxxx"  ++ ", you rock!")  
Hey xxxx, you rock!
Prelude> 

   
    import Control.Monad
    import Data.Char

    main = forever $ do
        putStr "Give me some input: "
        l <- getLine
        putStrLn $ map toUpper l

-}
