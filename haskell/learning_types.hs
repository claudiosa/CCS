-- Algebraic data types
-- data Bool = False | True  > from Prelude.hs
data My_Const_Bool = My_Bool Bool
    deriving (Show) 

-- my_true :: My_Bool 
my_true = True

data Constructor_Car = Car 
    {company :: String, 
     model :: String, 
     year :: Int} 
     deriving (Show)

car_01 :: Constructor_Car
car_01 =  Car "Ford" "Mustang" 1967                            --
car_02 :: Constructor_Car
car_02 =  Car "BMW" "X5566" 2020                            --
--  {company="Ford", model="Mustang", year=1967} 

vector_of_car :: [Constructor_Car]                               --
vector_of_car = [car_01, car_02]                               --