module Types_Studies where
-- in general at the same name of the FILE.hs
-- Algebraic data types ... different number in their fields
--  Type_Doctor : type constructor called ...
--  Value_Surgery and  Value_Medical: value constructor

main :: IO ()
main  =
   do
      putStrLn "Begin ========="
      print (corBasica Verde)
      putStrLn "End ==========="
 
data Cor = Verde | Azul | Amarelo
     deriving (Eq ,Show)

corBasica :: Cor -> Bool
corBasica c = (c == Verde) || (c == Azul) || (c == Amarelo)

data Nova_Cor =   Azul_N | Verde_N | Amarelo_N | Vermelho |  Rosa | Roxo  
	deriving (Eq,Show)

combina_Cor :: Nova_Cor -> Nova_Cor -> Nova_Cor
combina_Cor  Vermelho    Azul_N    = Roxo
combina_Cor  Azul_N      Amarelo_N   = Verde_N
combina_Cor  Amarelo_N   Roxo    = Rosa
combina_Cor  _        _       =  error  "NO COMBINATION ALLOWED"

{-- ################################# --}
