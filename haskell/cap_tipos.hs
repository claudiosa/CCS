import Char
-- import Numeric

f_pot ::  Float -> Int -> Float
f_pot x n = x^n

dif :: Int
dif = ord 'a' - ord 'A'  -- 32

maiusc_Min :: Char -> Char
maiusc_Min ch = chr ((ord ch) + dif)

minusc_Mai :: Char -> Char
minusc_Mai ch = chr ((ord ch) - dif)

conv x
   | x >= 'a' && x <= 'z' = minusc_Mai x
   | x >= 'A' && x <= 'Z' = maiusc_Min x
   | otherwise = error " não é uma letra entre A e z  ... "




div_1 a b = a / b

div_2 a b = (fromIntegral a) / b


div_3 :: Float -> Float -> Float
div_3 a b =  a / b

data Cor = Verde | Azul | Amarelo
     deriving (Eq,Show)

corBasica :: Cor -> Bool
corBasica c = (c == Verde) || (c == Azul || (c == Amarelo)

{-- 

data Nova_Cor = Vermelho | Azul | Amarelo | Rosa | Roxo |
  Verde | Lilaz
  deriving (Eq,Show)

combinacao_Cor :: Nova_Cor -> Nova_Cor -> Nova_Cor
combinacao_Cor  Vermelho Azul    = Roxo
combinacao_Cor  Azul Amarelo     = Verde
combinacao_Cor  Amarelo  Azul    = Verde
combinacao_Cor  _        _       = error  "Não existe essa combinacao"

infixl 7 &&&

(&&&) :: Int -> Int -> Int
a &&& b
    | a > b        = a
    | otherwise    = b
--}
