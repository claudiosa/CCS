module Types_Studies where

-- Algebraic data types
-- data Bool = False | True  > from Prelude.hs

-- other example
type My_ZERO_or_ONE = Int

data My_Const_Bool = Val_BOOL My_ZERO_or_ONE
    deriving (Show, Eq) 

my_true :: My_Const_Bool
my_true = Val_BOOL 1

my_false :: My_Const_Bool
my_false = Val_BOOL 0


-- other example
data New_Bool = True_N | False_N | Middle_N
the_generic :: New_Bool -> [Char]
the_generic False_N  = "Goes to ZERO"
the_generic Middle_N = "Goes to MIDDLE"
the_generic True_N   = "Goes to ONE"

--the_false False_N = "goes to ZERO"
--the_true True_N = "goes to ONE"

{-
*Main> :t my_true
my_true :: My_Const_Bool
-}
-- other example
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
{--
*Main> Car "Mercedes" "Coupe" 1969
Car {company = "Mercedes", model = "Coupe", year = 1969}
*Main> car_03 = Car {company = "Mercedes", model = "Coupe", year = 1969}
*Main> show (car_03)
"Car {company = \"Mercedes\", model = \"Coupe\", year = 1969}"
*Main> car_03
Car {company = "Mercedes", model = "Coupe", year = 1969}
*Main> :t car_03
car_03 :: Type_Const_Car
--}

vector_of_car :: [Type_Const_Car]                               --
vector_of_car = [car_01, car_02]                               --

-- Similar of enumerate in C
data New_Const_Constants = Zero | One | Two -- starting with Capital letters
    deriving (Eq, Show)



{-- ********************************************************** --}
