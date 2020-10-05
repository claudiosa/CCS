{- 
Full Game
Author: CCS
To run: 
*Main> round_X sample_01 ... sample_04
*****************************************
 -}

module Rock_Game where
data Object = Rock | Paper | Scissor
              deriving (Show, Enum, Eq, Ord)

win_of :: Object -> Object -> (Int,Int)
win_of Rock Scissor = (1,0) -- player 1 wins
win_of Paper Rock  = (1,0)
win_of Scissor Paper = (1,0)
win_of player_1 player_2  
        | player_1 == player_2  = (0,0) -- null
        | otherwise = (0,1) -- player 2 wins


answer_MATCH :: [(Object, Object)] -> [(Int, Int)]
answer_MATCH [] = []
answer_MATCH ((a,b) : rest_of_list) =  win_of  a b : answer_MATCH rest_of_list

points_player_01 :: Num p => [(p, b)] -> p
points_player_01 [] = 0
points_player_01 ((a,_) : rest_of_list) = a + points_player_01 rest_of_list

points_player_02 :: Num b => [(p, b)] -> b
points_player_02 [] = 0
points_player_02 ((_,b) : rest_of_list) = b + points_player_02 rest_of_list

round_X :: [(Object, Object)] -> IO ()
round_X match 
        | p_1 >  p_2 = 
                putStrLn $ "Player 1 WINS with " ++ show (p_1) ++ " points"
        | p_1 <  p_2 =
                putStrLn $ "Player 2 WINS with " ++ show (p_2) ++ " points"
        | otherwise = 
                putStrLn $ "Match NULL where player 1 had " ++ show (p_1) ++ " points" ++
                " and " ++ " player 2 had " ++ show (p_2)++ " points"

        where
          res_match = answer_MATCH match
          p_1 = points_player_01 res_match    
          p_2 = points_player_02 res_match
         
{- SEQUENCE OF ACTIONS
                -- do
                 print "Player 1 WINS with " 
                 print p_1 
                 print "points"
                 -}


{-  sample of  matches -}
sample_01, sample_02, sample_03, sample_04 :: [(Object, Object)]
sample_01 = [(Rock,Paper),(Rock, Scissor),(Rock ,  Rock )]
sample_02 = [(Rock,Paper ),( Rock , Scissor ),( Rock , Rock ),( Scissor ,Paper)]
sample_03 = [(Rock,Paper),(Rock , Scissor ),( Rock ,Rock ),(Scissor ,Paper),(Paper ,Rock)]
sample_04 = [(Rock,Paper),(Rock , Paper ),(Scissor ,Rock),(Paper,Scissor),(Paper ,Rock)]
