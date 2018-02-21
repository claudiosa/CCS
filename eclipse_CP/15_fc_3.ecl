
:- lib(ic).
fc_3 :-
      [X,Y]  :: 1 .. 7,
      X #\= Y,             % Atraso na reducao
      (X #= 3;X #= 4),     % Acorda para uma instanciacao
      get_domain(X,Dx),
      get_domain(Y,Dy),nl,
      write(X), write(' ...... '), write(Dx), nl,	
      write(Y), write(' ...... '), write(Dy).	

/*
Neste ultimo caso, as restricoes (X #= 3;X #= 4) torna um dos
lados instaciados, sendo um DESPERTAR da outra restricao pendente.
Com um dos lados instanciados, a outra restricao pode
ser verificada a frente. Dai o nome: forward checking
*/
