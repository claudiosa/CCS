/* o problema dos números primos... é
    da Grécia Antiga... são números divisíveis
    por ele mesmo (todos são) e por 1 (idem).
*/ 
 x :- 	write(' ... digite um numero....  '),	read(X),
	Y is X - 1 ,
	/* o Y será o divisor mais alto ... menos ele próprio */
        primo(X,Y).

/* O método de teste dos números
  primos, descrito a seguir,
  é um dos mais ineficientes.... pense em otimizações
   a partir deste... por exemplo:
 `` Será mesmo necessário testar todos os números
      de N até 1?''
 */

/* REGRA PRINCIPAL DA RECURSÃO (RPR)*/
primo(N,Div) :- 
	Div > 1,            /* divisor que no minimo seja 2 */
	N mod Div =\= 0,    /* diferente de 0 */
	X2 is Div - 1,      /* decrementa o divisor */  	X2 >= 1,             	primo(N, X2 ).

/* condições de PARADA à recursão .....
   essas podem vir depois ou antes da regra principal....
  depende de como foi implementada na RPR */
primo(1,0) :- nl, write('O 1 por definição é um numero primo !'), !.
/* opcional....
primo(2,1) :- nl, write('O 2 por definição é um numero primo !'), !.
*/
/* os dois acima foram colocados para satisfazer 
   a condição da regra geral descrita anteriormente... */

primo(X,Y) :- X >= 2, 	      Y == 1,
	      nl, write(X), write(' é um numero primo !'), !.

primo( X , Y) :- 
	Y =\= 1, 
	nl, write(X), write(' não eh um numero primo ').
/******************************************************/
