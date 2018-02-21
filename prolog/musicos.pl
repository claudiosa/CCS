  instrumento(harpa).
  instrumento(violoncelo).
  instrumento(piano).
  dia(3).
  dia(5).
  
  musicos( m(joao,X1,5), m(antonio,X2,D2), m(xico,X3,D3) ) :-
      
    instrumento(X1),
    instrumento(X2),
    instrumento(X3),
    (X2 \== piano),
    (X1 \== X2 , X3 \== X2, X1 \== X3),
    dia(D3),
    dia(D2),
    ((D2 == 3 , D3 == 5);(D2 == 5 , D3 == 3)),
    (X1 \== violoncelo , X3 == piano , D3 == 3).
