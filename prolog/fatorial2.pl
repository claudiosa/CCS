fatorial( 0, 1 ).
fatorial( X, Fat ) :-
                         X  >  0,
                        Aux  is  (X - 1),
                        fatorial( Aux , Parcial ),
                        Fat  is  ( X   *  Parcial ).