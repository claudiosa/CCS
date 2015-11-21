data Lam = Var Int | Comb Lam Lam | Abstr Int Lam

testa_liberdade a b|livre_ou_ligada a b = "A variavel eh livre"
                   |otherwise           = "A variavel eh ligada"

livre_ou_ligada x (Var y) 				= x == y 
livre_ou_ligada x (Comb rator rand) 	= livre_ou_ligada x rator || livre_ou_ligada x rand
livre_ou_ligada x (Abstr bndvar corpo)  = (x /= bndvar) && (livre_ou_ligada x corpo) 
livre_ou_ligada _ _ 					= False
