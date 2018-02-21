

c(lilaz). c(vermelho). c(azul).

padrao(X,Y,Z) :-
   c(X),
   c(Y),
   c(Z),
   \==(X,Y),
   \==(X,Z),
   \==(Y,Z).
   
   
