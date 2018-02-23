
/*
Um predicado (ou função) que calcule  a soma da seguinte sequência:
    1*n + 2*n + 3*n  + ... + n*n
    Admita N =7  para fins de teste.
*/
   

serie(N, S) :- aux(N,N,S).

/*aux(1, N, X ) :- X is (N*1).    :- !. com corte ...*/
aux(0, _, 0 ) :- !.
aux(1, N, N ) :- !. 
aux(N_var , Fixo ,S):- 
            Aux is (N_var -1),
            aux(Aux , Fixo , S1 ),
            S is ((N_var* Fixo) + S1).
          
