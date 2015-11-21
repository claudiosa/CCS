x:- gera(100).
/* vai gerar X numeros e testar quais deles são primos */

/* gerador */
gera(0).
gera(N) :-  
	  N1 is N-1, 
	  primo(N,N1), 
	  gera(N1).

/* o programa de numero primo modificado */
primo(N,Div) :- 
	Div > 1,            /* divisor que no minimo seja 2 */
	N mod Div =\= 0,    /* =\= diferente de 0 */
	X2 is Div - 1,
  	X2 >= 1,       
	primo(N, X2 ).

primo(1,0) :-  write(' 1 '), !.
primo(2,1) :-  write(' 2 '), !.

primo(X,Y) :- X > 2, 
	      Y == 1,
	      write(X), write(' '), !.

primo( _ , Y) :- 
	Y =\= 1. 
/* Não escreve nada se não for primo  ! */
