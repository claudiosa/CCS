
:- lib(ic).
fc_1 :-
      X :: 1 .. 7,
      X #\= 3,
      X #\= 5,
      get_domain(X,Dx),nl,
      write(X), write(' ...... '), 	
      write(Dx).

/* A restricao  #\= eh util, pois hah uma reducao
   do dominio na variavel X, jah instaciada 
*/
