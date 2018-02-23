--Árvore Binária de Inteiros

data ArvoreBin_Int = Nil_int | Nodo_int Int ArvoreBin_Int ArvoreBin_Int
       deriving Show   
       
arvoreB = Nodo_int 4 (Nodo_int 2 Nil_int Nil_int)
                 (Nodo_int 10 (Nodo_int 5 Nil_int Nil_int)
                          (Nodo_int 15 Nil_int Nil_int))
			  
folhas_int :: ArvoreBin_Int -> [Int]
folhas_int Nil_int = []
folhas_int (Nodo_int n Nil_int Nil_int) = [n]
folhas_int (Nodo_int _ esq dir) = folhas_int esq ++ folhas_int dir

--Árvore Binária Genérica

data ArvoreBin_gen a = Nil | Nodo a (ArvoreBin_gen a) (ArvoreBin_gen a)
        deriving Show
	
arvoreB1 :: ArvoreBin_gen Char
arvoreB1 = Nodo 'a' (Nodo 'b' Nil Nil)
                   (Nodo 'c' (Nodo 'd' Nil Nil)
                             (Nodo 'e' Nil Nil))

arvoreB2 :: ArvoreBin_gen (Integer,Char)
arvoreB2 = Nodo (4,'a') (Nodo (2,'b') Nil Nil)
                              (Nodo (10,'c') (Nodo (5,'d') Nil Nil)
                                             (Nodo (15,'e') Nil Nil))
folhas_gen :: ArvoreBin_gen a -> [a]
folhas_gen Nil = []
folhas_gen (Nodo n Nil Nil) = [n]
folhas_gen (Nodo _ esq dir) = folhas_gen esq ++ folhas_gen dir            


--Árvore Binária com Tuplas

data ArvoreBin_tup a = Vazio | No2 a |No ((ArvoreBin_tup a),(ArvoreBin_tup a))

folhas_tup :: ArvoreBin_tup Int -> [Int]
folhas_tup Vazio = []
folhas_tup (No (Vazio, Vazio)) = []
folhas_tup (No(No2 esq, Vazio)) = [esq]
folhas_tup (No (Vazio ,No2 dir)) = [dir]
folhas_tup (No (No2 esq,No2 dir)) = [esq]++[dir]
folhas_tup (No (esq , dir)) = folhas_tup esq ++ folhas_tup dir
