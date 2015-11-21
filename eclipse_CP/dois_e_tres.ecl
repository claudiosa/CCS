:-lib(ic).

dois( Letras) :-
          Letras = [ D, O, I , S , T, R, E , C, N] ,
          Carry  = [ C1 , C2 , C3 ] ,
          Letras #:: [ 0 .. 9 ] ,
          Carry #:: [ 0 .. 1 ] ,
          get_domain(D, Dd),nl,
          write('Dominio D: '), write(Dd), 
          alldifferent( [ D, O, I , S , T, R, E , C, N ] ) ,
          C #= 1 ,
        D + T + C3 #= I + 10 * C,
        
        O + R + C2 #= N + 10 * C3 ,
         I + E + C1 #= C + 10 * C2 ,
        S + S #= O + 10 * C1 ,
         get_domain(D, Dd), nl,
         write('Dominio D: '), 
         write(Dd),
         labeling( [ D, O, I , S , T, R, E , C, N ] ) ,
         labeling( Carry )
         /*,
         get_domain(D, Dd),nl,
         write('Dominio D: '), 
         write(Dd)
         */
           .
