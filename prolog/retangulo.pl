imp_col(0).
imp_col(1):-  write('*'). 
imp_col(N2):- write('*'), 
          is(N1 , (N2-1)), 
          /* N1  is (N2-1)  */
	      imp_col(N1).

/**** Colunas ****/
retangulo( X, Y ) :- (X < 1; Y < 1), 
                     write('X >= 1 , Y >= 1').
retangulo(0, _ ) :- true.
retangulo(Linha, Coluna) :-  
               imp_col(Coluna), 
               nl, /* salta a linha */
               is(L_N, (Linha - 1) ), 
   		       retangulo( L_N, Coluna).
