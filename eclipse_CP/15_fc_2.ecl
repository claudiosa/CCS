
:- lib(ic).
fc_2 :-
      [X,Y]  :: 1 .. 7,
      X #\= Y,             % Atraso na reducao
      get_domain(X,Dx),
      get_domain(Y,Dy),nl,
      write(X), write(' ...... '), write(Dx), nl,	
      write(Y), write(' ...... '), write(Dy).	

/*
 Como ambos os lados de X #\= Y NAO estao instanciados.
 Logo, a restricao X #\= Y  eh inutil
 */

