{- ONLY 1 WINNER ... PLAYER ONE = 1 -}

data Object = Rock | Paper | Scissor
              deriving (Show, Enum, Eq, Ord)

win_of :: Object -> Object -> Bool
-- ONLY PLAYS winner for player 1
win_of Rock Scissor = True -- Example: player 1 Rock, player 2 Scissor
win_of Paper Rock  = True
-- win_of Rock  Paper = True
win_of Scissor Paper = True
win_of player_1 player_2  
        | player_1 == player_2  = False
        | otherwise = False

index_where_PLAYER_1_WIN :: [(Object, Object)] -> [Int]
index_where_PLAYER_1_WIN match = filter_True ( build_index (answer_MATCH match))
{-
*Main> index_where_PLAYER_1_WIN sample_01
[2]
*Main> index_where_PLAYER_1_WIN sample_02
[2,4]
*Main> index_where_PLAYER_1_WIN sample_03
[2,4,5]
*Main> 
 -}

--anwser_MATH game = map win_of game --- FUTURE
answer_MATCH [] = []
answer_MATCH ((a,b) : rest_of_list) =  win_of  a b : answer_MATCH rest_of_list

--index_winner_1 list = map (back_index_of_value True) list --- FUTURE
build_index l = invert (aux_index (invert l))

{-
*Main> build_index [3,4,5,6]
[(3,1),(4,2),(5,3),(6,4)]
*Main> build_index [True,False]
[(True,1),(False,2)]
*Main> 
-}
-- add a number for each position ... but inverser sequence
aux_index  []  = []
aux_index  [a]  = [(a,1)]
aux_index  (a:b) = (a,length (a:b) ): aux_index b

-- same of reverse --- FUTURE
invert l = reverse l

filter_True [] = []
filter_True ((a,b): sub_LIST) =  
        if a == True
                then b: filter_True sub_LIST
                else filter_True sub_LIST


{-  sample of  matches -}
sample_01, sample_02, sample_03 :: [(Object, Object)]
sample_01 = [(Rock,Paper),(Rock, Scissor),(Rock ,  Rock )]
sample_02 = [(Rock,Paper ),( Rock , Scissor ),( Rock , Rock ),( Scissor ,Paper)]
sample_03 = [(Rock,Paper),(Rock , Scissor ),( Rock ,Rock ),(Scissor ,Paper),(Paper ,Rock)]

