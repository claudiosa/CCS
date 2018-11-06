x :-  soma(99, X), nl , write(X). /* driver */
/* porque duas variaveis?
   ... a recursao obrigatoriamente....
   tem que ter uma condicao de parada... eh o momento que
    comecamos a retomar um caminho desbravado...
.... logo ...
     duas variaveis ... sao necessarias para que uma
delas seja incrementada ou decremntada ateh um valor
em que a clausula recursiva seja verdade...
   

*/

soma(3,3). /* .... condicao de parada ... */
soma( X , Resultado) :- 
	X1 is X-3	,  /* aqui se decrementa.... */
	X1 >=0       	, 
	soma(X1, Sominha)          ,    /* recursiva principal */
	Resultado is X + Sominha          . /* acumulador .... */


x2 :- soma2(3,X),  nl , write(X). /* driver */

soma2(99, 99). /* .... condicao de parada ... */
soma2( X , Resultado ) 
	:- 
	X1 is X + 3	,  /* aqui se decrementa.... */
	X1 =< 99                	, 
	soma2(X1, Sominha )               ,    /* recursiva principal */
	Resultado is X + Sominha          . /* acumulador .... */
