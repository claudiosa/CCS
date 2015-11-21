data Nova_Cor = Vermelho | Azul | Amarelo | Rosa | Roxo |
                               Verde | Lilaz
                              deriving (Eq,Show)

combinacao_Cor :: Nova_Cor -> Nova_Cor -> Nova_Cor
combinacao_Cor  Azul    Amarelo    =  Verde
combinacao_Cor  Amarelo  Azul    =  Verde
combinacao_Cor  Verde   Vermelho    = Lilaz
combinacao_Cor  Verde   Azul    = Amarelo
combinacao_Cor   Azul    _        =  Lilaz
combinacao_Cor   _        Vermelho  =  Rosa
combinacao_Cor  _        _       = error  "Uma combinação qualquer"
{--
Main> combinacao_Cor   Azul        Vermelho 
Lilaz
Main> combinacao_Cor   Azul  Lilaz          
Lilaz
Main> combinacao_Cor   Azul  Vermelho 
Lilaz
Main> combinacao_Cor   Verde   Vermelho 
Lilaz
Main> combinacao_Cor   Lilaz   Vermelho 
Rosa
Main> combinacao_Cor   Vermelho   Vermelho 
Rosa
Main> :r
Main> combinacao_Cor   Beje   Salmao
ERROR - Undefined constructor function "Salmao"
Main> combinacao_Cor   Rosa   Lilaz 

Program error: Uma combinação qualquer

--}
