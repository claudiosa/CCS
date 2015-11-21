import Char

type Meu_tipo = (String, Float, Char)
pessoas :: Float -> (String, Float, Char)
-- retorna uma tupla_3 a partir do rg passado
pessoas rg
           | rg == 1 = ("Joao Silva", 12, 'm')
           | rg == 2 = ("Jonas Souza", 81, 'm')
           | rg == 3 = ("Joice Silva", 21, 'f')
           | rg == 4 = ("Janete Souza", 55, 'f')
           | rg == 5 = ("Jocileide Strauss", 21, 'f')
           | otherwise = ("Nao ha ninguem mais", 0 , 'x')

--QUESTAO 5  - A
-- retorna a tupla_3 referente a pessoa de menor idade ate o valor x

questao_5_a :: Float -> (String, Float, Char)
questao_5_a x 
  | x==1 = pessoas 1
  | otherwise = menor ( pessoas x) (questao_5_a (x-1))

menor :: (String, Float, Char) -> (String, Float, Char) -> (String, Float, Char)
menor x y
  | x1 <= x2 = x
  | otherwise = y
  where
  x1 = idade x
  x2 = idade y

idade :: (String, Float, Char) -> Float
idade (x, y, z) = y

{-
Gabarito> questao_5_a 3
("Joao Silva",12.0,'m')
Gabarito> 
-}



--QUESTAO 5  - B
-- retorna a idade media de todas as pessoas ate um rg passado como parametro 
-- da função

questao_5_b :: Float -> Float

questao_5_b x = (soma_idade x)/x
   

soma_idade :: Float -> Float
  
soma_idade x
  | x == 1  = idade (pessoas 1)
  | otherwise = idade (pessoas x) + (soma_idade (x-1))

{-
Gabarito> questao_5_b 6  
1698.17 ...... troquei 99999 por 0 aqui....
Gabarito> questao_5_b 6
31.6667
Gabarito>
-}

--QUESTAO 5  - C
-- retorna o número de pessoas do sexo masculino 

questao_5_c :: Float -> Float

questao_5_c x = conta x 0

conta :: Float -> Float -> Float

conta x cont   | x == 0 = cont
                     | sex (pessoas x) /= 'm' = conta (x-1) cont
                     | otherwise = conta (x-1) (cont+1) 

sex :: (String, Float, Char) -> Char
sex (x, y, z) = z

{-
Gabarito> questao_5_c 6
2.0
Gabarito>
-}

--QUESTAO 5  - D
-- retorna o número de registro da pessoa de maior idade

maior :: Float -> Float -> Float
maior x y
  | x1 >= x2 = x
  | otherwise = y
  where
  x1 = idade (pessoas x)
  x2 = idade (pessoas y)

questao_5_d :: Float -> Float

questao_5_d x
  | x==1 = x
  | otherwise = maior x (questao_5_d (x-1))

{-
Gabarito> questao_5_d 6
6.0
Gabarito> questao_5_d 5
2.0
Gabarito> 
-}


