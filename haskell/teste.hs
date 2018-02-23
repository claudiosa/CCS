data Nova_Cor = Vermelho | Azul | Amarelo | Rosa | Roxo |
                               Verde | Lilaz
                              deriving (Eq,Show)

combinacao_Cor :: Nova_Cor -> Nova_Cor -> Nova_Cor
combinacao_Cor  Vermelho Azul    = Roxo
combinacao_Cor  Azul   Amarelo    =  Verde
combinacao_Cor  Amarelo  Azul    =  Verde
combinacao_Cor  Verde  Vermelho    = Lilaz
combinacao_Cor  Verde  Azul    = Amarelo
combinacao_Cor  _        _       = error  "Não existe essa combinação"
