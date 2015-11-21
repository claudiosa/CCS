/* MAC  */
:- lib(ic).
mac_1 :-
      [X,Y]  :: 1 .. 7,
      (X + 2) #< Y,             % Atraso na reducao
      get_domain(X,Dx),
      get_domain(Y,Dy),nl,
      write(X), write(' ...... '), write(Dx), nl,	
      write(Y), write(' ...... '), write(Dy).	
/* uma ou mais variaveis ainda tem o seu dominio incerto */

mac_2 :-
      [X,Y]  :: 1 .. 7,
      (X + 2) #< Y,             % Atraso na reducao
      X #> 2,                   % Visa remover inconsistencias
      get_domain(X,Dx),
      get_domain(Y,Dy),nl,
      write(X), write(' ...... '), write(Dx), nl,	
      write(Y), write(' ...... '), write(Dy).	
/* Valores inconsistentes sao removidos logo do seu dominio */
