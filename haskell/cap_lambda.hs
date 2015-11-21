fatorial 0 = 1
fatorial n = fatorial (n-1) * n

g x = x / (fatorial x)

inc = \x -> (+) x 1


data Lam = Var Int | Comb Lam Lam | Abstr Int Lam

testa_liberdade a b|livre_ou_ligada a b = "A variavel eh livre"
                   |otherwise           = "A variavel eh ligada"
		   
livre_ou_ligada x (Var y)            =  x == y
livre_ou_ligada x (Comb lamb_1 lamb_2)  = livre_ou_ligada x lamb_1 ||
                                          livre_ou_ligada x lamb_2
livre_ou_ligada x (Abstr int_var lamb) = (x /=  int_var) && 
                                         (livre_ou_ligada x lamb)
livre_ou_ligada     _   _              = False

