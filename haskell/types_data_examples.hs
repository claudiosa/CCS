-- Algebraic data types
-- data Bool = False | True  > from Prelude.hs

type My_ZERO_or_ONE = Int
data My_Const_Bool = Val_BOOL My_ZERO_or_ONE
    deriving (Show) 

my_true :: My_Const_Bool
my_true = Val_BOOL 1
{-
*Main> :t my_true
my_true :: My_Const_Bool
-}

data Type_Const_Car = Car 
    {company :: String, 
     model :: String, 
     year :: Int} 
     deriving (Show)

-- Car isolated is the value constructor or data constructor
car_01 :: Type_Const_Car
car_01 =  Car "Ford" "Mustang" 1967                            --
car_02 :: Type_Const_Car
car_02 =  Car "BMW" "X5566" 2020                            --
--  {company="Ford", model="Mustang", year=1967} 

vector_of_car :: [Type_Const_Car]                               --
vector_of_car = [car_01, car_02]                               --