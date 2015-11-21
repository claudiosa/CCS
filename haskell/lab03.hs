
import qualified Control.Exception as E
{-
Recursao -- Exercicios Propostos

a) soma de 1 a n
b) fatorial  de  n
c) soma de m a n
d) fibonacci
e) Usando Euclides ... a divisao inteira
f) Reusando anterior a funcao modulo
g) f 91 de Mcharty

8 ways to report errors in Haskell
http://www.randomhacks.net/articles/2007/03/10/haskell-8-ways-to-report-errors
-}


s m n | m > n = error "Erro de entrada"
s m n | m == n = m
s m n = n +  s m (n-1)

{-
*Main> s (-11) 10
-11
*Main> s (-10) 10  
0
*Main> s (10) 10 
10
*Main> 
-}
{-
myDiv3 :: Float -> Float -> Either String Float
myDiv3 x 0 = Left "Divison by zero"
myDiv3 x y = Right (x / y)



divSum3 :: Float -> Float -> Float -> Either String Float
divSum3 x y z = do
  xdy <- myDiv3 x y
  xdz <- myDiv3 x z
  return (xdy + xdz)

-}
