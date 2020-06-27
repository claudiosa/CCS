module Monads_Study where

{--
Maybe monad represents computations which might
"go wrong" by not returning a value.
For reference, here are the definitions of return and (>>=) for Maybe 
--}

-- it is already defined, for functions reasons
return :: a -> Maybe a
return x  = Just x


(>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
(>>=) m g = case m of
          Nothing -> Nothing
          
-- show an example latter
--m >>= return     =  m                        -- right unit
--return x >>= f   =  f x                      -- left unit
--(m >>= f) >>= g  =  m >>= (\x -> f x >>= g)  -- associativity

{--          
 where (>=>) is the monad composition operator, a close analogue of the function composition operator (.), only with flipped arguments. It is defined as:

   (>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
   f >=> g = \x -> f x >>= g     Just x  -> g x

--}



-- Maybe Nothing ... becomes secure the partials function
-- in error case, just Nothing
safe_division :: (Ord a, Fractional a) => a -> a -> Maybe a
safe_division x y
    | y > 0     = Just ( x / y)
    | otherwise = Nothing

