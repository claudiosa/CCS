module Types_Studies where
-- in general at the same name of the FILE.hs
-- Algebraic data types ... different number in their fields
--  Type_Doctor : type constructor called ...
--  Value_Surgery and  Value_Medical: value constructor

data Type_Doctor = Value_Surgery 
    {speciality :: String, 
     name :: String, 
     age :: Int,
     sallary :: Float,
     only_Hospital :: Bool
     }
     |
     Value_Medical 
    {speciality :: String, 
     name :: String, 
     age :: Int
     }
     deriving (Show)


prof_01 :: Type_Doctor
prof_01 =  Value_Surgery "Torax" "Bryan" 67 78.90 True

prof_02 :: Type_Doctor 
prof_02 =  Value_Medical "Neurologyst" "Bob" 70

-- OVERLOADING function .. get_Medical is overloaded
get_Medical (Value_Medical speciality name age) = show_Basic_Data speciality name age
get_Medical (Value_Surgery speciality name age sallary only_hospital) = show_Basic_Data speciality name age ++ " Sallary: " ++ show(sallary) ++ " Work in Hospital: " ++ show (only_hospital)


-- Common or basic printing
show_Basic_Data speciality name age = "Name: "++show (name)++ " Speciality: " ++ show (speciality) ++" Age: " ++ show(age)
-- to be improved HERE

all_doctors = [prof_01, prof_02]
print_all  = print all_doctors
{-- ********************************************************** --}