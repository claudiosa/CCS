-- TODO ...
data Bool = True | False

-- infix 1 my_OR

my_OR :: Bool -> Bool -> Bool 
my_OR  True   x = True
my_OR  False  x = x

-- my_OR