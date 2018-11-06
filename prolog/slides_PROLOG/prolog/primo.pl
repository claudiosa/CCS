/* o problema dos n�meros primos... �
    da Gr�cia Antiga... s�o n�meros divis�veis
    por ele mesmo (todos s�o) e por 1 (idem).
*/ 
 x :- 	write(' ... digite um numero....  '),	read(X),
	Y is X - 1 ,
	/* o Y ser� o divisor mais alto ... menos ele pr�prio */
        primo(X,Y).

/* O m�todo de teste dos n�meros
  primos, descrito a seguir,
  � um dos mais ineficientes.... pense em otimiza��es
   a partir deste... por exemplo:
 `` Ser� mesmo necess�rio testar todos os n�meros
      de N at� 1?''
 */

/* REGRA PRINCIPAL DA RECURS�O (RPR)*/
primo(N,Div) :- 
	Div > 1,            /* divisor que no minimo seja 2 */
	N mod Div =\= 0,    /* diferente de 0 */
	X2 is Div - 1,      /* decrementa o divisor */  	X2 >= 1,             	primo(N, X2 ).

/* condi��es de PARADA � recurs�o .....
   essas podem vir depois ou antes da regra principal....
  depende de como foi implementada na RPR */
primo(1,0) :- nl, write('O 1 por defini��o � um numero primo !'), !.
/* opcional....
primo(2,1) :- nl, write('O 2 por defini��o � um numero primo !'), !.
*/
/* os dois acima foram colocados para satisfazer 
   a condi��o da regra geral descrita anteriormente... */

primo(X,Y) :- X >= 2, 	      Y == 1,
	      nl, write(X), write(' � um numero primo !'), !.

primo( X , Y) :- 
	Y =\= 1, 
	nl, write(X), write(' n�o eh um numero primo ').
/******************************************************/
