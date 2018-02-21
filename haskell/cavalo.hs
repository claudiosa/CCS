--------------------------------------------------------------------
--
--   Pictures.hs
--
--   Simon Thompson
--
--   June 1998
--   Last modified 28 September 2000
--
-- An implementation of a type of rectangular pictures using lists of
-- lists of characters.
-- Alterado:: CCS ... nov/2002
--------------------------------------------------------------------

-- The basics
-- ^^^^^^^^^^

module Cavalos where

type Picture = [[Char]]

-- The example used in Craft2e: a polygon which looks like a horse. Here
-- taken to be a 16 by 12 rectangle.

horse :: Picture

horse = [".......##...",
         ".....##..#..",
         "...##.....#.",
         "..#.......#.",
         "..#...#...#.",
         "..#...###.#.",
         ".#....#..##.",
         "..#...#.....",
         "...#...#....",
         "....#..#....",
         ".....#.#....",
         "......##...."]

-- A completely white picture.

white :: Picture

white = ["............",
         "............",
         "............",
         "............",
         "............",
         "............",
         "............",
         "............",
         "............",
         "............",
         "............",
         "............"]

-- Small black and white squares

sb, sw :: Picture

sb = ["##","##"]
sw = ["..",".."]

-- Getting a picture onto the screen.

printPicture :: Picture -> IO ()

printPicture = putStr . concat . map (++"\n")

{- cuidar....
concat [ [3 .. 7] ]
[3,4,5,6,7]  
-}

-- reescrevendo a printPicture

imp_cavalo_3  x = putStr (uma_soh_lista (mapear (concatena "\n" ) x ))

imp_cavalo_4   = putStr . uma_soh_lista . mapear (concatena  "\n")   


-- convencional...
imp_cavalo [] = putStr "................."
imp_cavalo (c:resto) = do {
						    putStr c;
						    putStr "\n";
						    imp_cavalo resto
						   } 

-- Transformations of pictures.
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-- Reflection in a vertical mirror.

flipV :: Picture -> Picture

flipV = map reverse
vira_V cavalo = xmapear inverte_1 cavalo

-- Reflection in a horizontal mirror.

flipH :: Picture -> Picture
flipH = reverse
vira_H cavalo = inverte_1 cavalo


-- Rotation through 180 degrees, by composing vertical and horizontal
-- reflection. Note that it can also be done by flipV.flipH, and that we
-- can prove equality of the two functions.

rotate :: Picture -> Picture
rotate = flipH . flipV

--  O operador ponto "." (ver o rotate acima), é equivalente há:

rotaciona :: Picture -> Picture
rotaciona cavalo = flipH (flipV cavalo)
rotac_2   cavalo = vira_H (vira_V cavalo)
rotac_3   cavalo = vira_V (vira_H cavalo)


-- One picture above another. To maintain the rectangular property,
-- the pictures need to have the same width.

above :: Picture -> Picture -> Picture
above = (++)
um_sobre_outro x = append x x -- simples concatenação de duas listas....

-- One picture next to another. To maintain the rectangular property,
-- the pictures need to have the same height.

sideBySide :: Picture -> Picture -> Picture

sideBySide = zipWith (++)
lado_a_lado x =  aplica_f_sobre append x x

-- Superimose one picture above another. Assume the pictures to be the same
-- size. The individual characters are combined using the combine function.

superimpose :: Picture -> Picture -> Picture
superimpose = zipWith (zipWith combine) --  dois argumentos
sobre_poe x =  aplica_f_sobre (aplica_f_sobre combine)  x


frente_a_frente horse cav_vert  = aplica_f_sobre (aplica_f_sobre combine) horse cav_vert
cav_vert = xmapear reverse horse


x_sobre_ok = imp_cavalo (superimpose horse (flipV horse))

-- For the result to be '.' both components have to the '.'; otherwise
-- get the '#' character.

combine :: Char -> Char -> Char
combine topCh bottomCh
  = if (topCh == '.' && bottomCh == '.')
    then '.'
    else '#'


-- Inverting the colours in a picture; done pointwise by invert...
invertColour :: Picture -> Picture
invertColour = map (map invert)
troca_cor x = xmapear (xmapear invert) x

--troca_cor2 x = xmapear invert2 x

-- ... which works by making the result '.' unless the input is '.'.

invert :: Char -> Char
invert ch = if ch == '.' then '#' else '.'

--invert2 :: String -> String
--invert2 str = if str == "." then "#" else "."

concatena = append
append :: [a] -> [a] -> [a]
append [ ]  ys     =  ys
append (x : xs) ys =  x : append xs ys

uma_soh_lista  xs = foldr (++) [] xs

inverte_1 :: [a] -> [a]
inverte_1 []     =  []
inverte_1 (x:xs) =  append (inverte_1 xs) [x]

{-
  inverte_1 [4 .. 8]
  [8,7,6,5,4] 
-}


aplica_f_sobre  :: (a->b->c) -> [a]->[b]->[c]
aplica_f_sobre f (a:as) (b:bs)   = f a b : aplica_f_sobre f as bs
aplica_f_sobre _ _      _        = []

dobrar :: (a -> [b] -> [b]) -> c -> [a] -> [b]  
dobrar f e []     = []				
dobrar f e (x:xs) = f x (dobrar f e xs)

mapear = xmapear -- para o livro
xmapear :: (a -> b) -> [a] -> [b]    
xmapear f []     =  []
xmapear f (x:xs) = f x : xmapear f xs  

{-
imp_cavalo horse
.......##...
.....##..#..
...##.....#.
..#.......#.
..#...#...#.
..#...###.#.
.#....#..##.
..#...#.....
...#...#....
....#..#....
.....#.#....
......##....

 ...acabou....   
 -}

  
{-
Pictures> printPicture horse    

.......##...
.....##..#..
...##.....#.
..#.......#.
..#...#...#.
..#...###.#.
.#....#..##.
..#...#.....
...#...#....
....#..#....
.....#.#....
......##.... 



Pictures> printPicture (flipH horse)
......##....
.....#.#....
....#..#....
...#...#....
..#...#.....
.#....#..##.
..#...###.#.
..#...#...#.
..#.......#.
...##.....#.
.....##..#..
.......##...

Pictures> printPicture (flipV horse)
...##.......
..#..##.....
.#.....##...
.#.......#..
.#...#...#..
.#.###...#..
.##..#....#.
.....#...#..
....#...#...
....#..#....
....#.#.....
....##......

printPicture (rotaciona  horse)
....##......
....#.#.....
....#..#....
....#...#...
.....#...#..
.##..#....#.
.#.###...#..
.#...#...#..
.#.......#..
.#.....##...
..#..##.....
...##.......

Pictures> printPicture (rotate  horse)
....##......
....#.#.....
....#..#....
....#...#...
.....#...#..
.##..#....#.
.#.###...#..
.#...#...#..
.#.......#..
.#.....##...
..#..##.....
...##.......

Pictures>    

imp_cavalo (lado_a_lado horse)
.......##..........##...
.....##..#.......##..#..
...##.....#....##.....#.
..#.......#...#.......#.
..#...#...#...#...#...#.
..#...###.#...#...###.#.
.#....#..##..#....#..##.
..#...#.......#...#.....
...#...#.......#...#....
....#..#........#..#....
.....#.#.........#.#....
......##..........##....

 acabou....               
Pictures> imp_cavalo(rotac_3 horse)
....##......
....#.#.....
....#..#....
....#...#...
.....#...#..
.##..#....#.
.#.###...#..
.#...#...#..
.#.......#..
.#.....##...
..#..##.....
...##.......
.................
Pictures> imp_cavalo(rotac_2 horse)
....##......
....#.#.....
....#..#....
....#...#...
.....#...#..
.##..#....#.
.#.###...#..
.#...#...#..
.#.......#..
.#.....##...
..#..##.....
...##.......
.................
Pictures>      
 imp_cavalo(troca_cor horse)
#######..###
#####..##.##
###..#####.#
##.#######.#
##.###.###.#
##.###...#.#
#.####.##..#
##.###.#####
###.###.####
####.##.####
#####.#.####
######..####
................. 
-}
