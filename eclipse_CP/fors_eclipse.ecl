:-lib(ic).
:-lib(lists).
/*  Arrays:
1. Uma estrutura "quase" igual a lista
2. Há alguns predicados dirigidos a arrays
3. Há como converter array -- > lista
           flatten_array(Array, Lista),
4. Array tem acesso indexado = Vantagem
5. Array: tem tamanho limitado = desvantagem
http://eclipseclp.org/doc/bips/kernel/control/do-2.html

PARA TESTAR
term_variables([ArrayX],L_ArrayX),
	term_variables([ArrayY],L_ArrayY),
	 
*/


/*  
?- flatten_array(Array, List).
instantiation fault in flatten_array(Array, List)
Abort
Sentido Array --> Lista
flatten_array(+Array, -List)
+ eh valor de entrada e - eh a saida
Returns a flat list of the elements of a 
multi-dimensional array.

?- flatten_array([](3, 5, 7, 9), List).
List = [3, 5, 7, 9]
Yes (0.00s cpu)
?- flatten_array([](3, 5, 7, 9), [3, 5, 7, 9]).
Yes (0.00s cpu)
?- flatten_array(X, [3, 5, 7, 9]).
Abort


*/
%%% contrario use este
list2array(L,A) :-
                length(L, Size),
                dim(A,[Size]),
                (foreacharg(X,A),
		        foreach(X,L) do true). 
/*
?- list2array([3, 5, 7, 9], A).
A = [](3, 5, 7, 9)
Yes (0.00s cpu)
*/

/* DADOS */

a([](3, 5, 7, 9)). 
b([]([](7, 5, 8, 2),
     [](7, 8, 6, 4),   %% 25 2a linha
     [](3, 5, 7, 9),
     [](5, 5, 6, 7)
    )
  ). /* matrix bidimensional */
              %% 27 na 3a coluna 


matriz(X)  :-  
      X = [](
             [](7, 5, 8, 2),
             [](7, 8, 8, 4),
             [](3, 5, 7, 9),
             [](5, 5, 6, 7)
            ).


ex_arrays(A1,A2) :- 
       A1 = [](3, 2, 4, 1, 5),
       A2 = [](2, 3, 4, 5, 1),
       dim(A1, S1), writeln(size_Array_1: S1),
       dim(A2, S2), writeln(size_Array_2: S2),
       writeln( a1_Array_1:  A1 ),
       writeln( a2_Array_2:  A2 ).

%%% Qual a linha e coluna cuja soma dá  52 ?              

/*****************************************************/
t01 :-  
     ex_arrays(A1,A2), %%% toma dois array
     prod_escalar_Array( A1, A2, X) ,
     flatten_array(A1, LA1),
     % writeln("Array:"  :A1),
     writeln("Array CONVERTIDO para lista:"  :LA1),
     write(X).


/* SAIDA:
size_Array_1 : [5]
size_Array_2 : [5]
a1_Array_1 : [](3, 2, 4, 1, 5)
a2_Array_2 : [](2, 3, 4, 5, 1)
Lista de constraint em soma: : [6, 6, 16, 5, 5]
Um unico valor ... em um dominio -- se for o caso: : 38
Array CONVERTIDO para lista: : [3, 2, 4, 1, 5]
38
*/

t02 :-  
    a(Array), %% anteriormente definido
    writeln("... quanto eh o Array: " : Array ),		
    dim(Array, [N]), %% retorna o tamanho de Array em N
    dim(X, [N]), %% cria um array de tamanho N
    X ::  0 .. 1, %% vals do dominio para este array
    %% idem a    X :: [ 0,1 ]  %% DOMINIO REAL

    prod_escalar_Array( Array, X,  Sum_X ) ,
    %% a1.X[1][0 .. 1] + a2.X[2][0 .. 1] + ....
    eval(Sum_X)  #=< 10 , %%%  ou simplesmente  Sum_X  #> 10,
    %% contudo sum( ... ) este  eh BEM DIFERENTE serve para LISTA  e nao Array
    eval(Sum_X)  #>= 4 ,	
    flatten_array(X, LX),
    writeln("Antes do search ... Array de X: " : X ),	
    writeln("Antes do search ... Lista de X LX: " : LX ),	
    labeling(LX), %% X ou Lx estah indefinido entre [0,1] 
    %% -- o search em sempre em formato de LISTA
    writeln("Depois do search ... quanto eh X: " : X ).	

/* SAIDA
... quanto eh o Array:  : [](3, 5, 7, 9)
Lista de constraint em soma: : [_546{0 .. 3}, _800{0 .. 5}, _1054{0 .. 7}, _1308{0 .. 9}]
Um unico valor ... em um dominio -- se for o caso: : _1625{0 .. 24}
Antes do search ... Array de X:  : [](_272{[0, 1]}, _286{[0, 1]}, _300{[0, 1]}, _314{[0, 1]})
Antes do search ... Lista de X LX:  : [_272{[0, 1]}, _286{[0, 1]}, _300{[0, 1]}, _314{[0, 1]}]
Depois do search ... quanto eh X:  : [](0, 0, 0, 1)
Depois do search ... quanto eh X:  : [](0, 0, 1, 0)
Depois do search ... quanto eh X:  : [](0, 1, 0, 0)
Depois do search ... quanto eh X:  : [](1, 0, 1, 0)
Depois do search ... quanto eh X:  : [](1, 1, 0, 0)
*/

t10 :-
        N = 3,
        dim(X, [N]), %% cria um array
        X :: 0 .. 1, %% vals do dominio para este array
        
       %%% esta filtragem ...
       %%% X[1] +X[2] + X[3] #= 2, 
       %%%  ou de outro jeito
       %%% trocando por:
          (for(I,1,N), %% funciona ou tem sentido para ARRAY apenas
          %% vj explicacao em sala de aula do fromto
          fromto(0 , In , In+X[I], SSum),
          param(X) do %%% vem externo ao bloco
             true
           ),
         2 #= eval(SSum), %%%% eval: Soma de uma linha de array
%	 2 #= sum(SSum), %%%% sum: Soma de uma lista
 	flatten_array( X, LX ), %% converte Array versus Lista
    labeling(LX), %% search simplificado
	 writeln(" Array X " : X). %% imprime
       
/*
Saida:
 Array X  : [](0, 1, 1)
 Array X  : [](1, 0, 1)
 Array X  : [](1, 1, 0)
*/


t11 :-
	A1 = [](3, 2, 4, 1, 5),
	dim( A1 , N1 ), %% pega dim de A1
	dim( A2 , N1),  %% uma nova variavel de mesma dimensao que A1
	A2 :: [0,1], %% esta tera valores fixos entre 0 ou 1
	prod_escalar_Array( A1, A2, Sum_X) ,	
	%% UMA CONSTRAINT AQUI .. X eh o retorno e eh uma constraint
	%% OUTRA CONSTRAINT AQUI
	eval(Sum_X)  #= 7,
    flatten_array(A2, LA2),
	labeling(LA2), %% A2 via LA2 ...estah indefinido entre [0,1]
    writeln("... quanto eh A2: " : A2 ).
/* 
Saida:
... quanto eh A2:  : [](0, 1, 0, 0, 1)
... quanto eh A2:  : [](0, 1, 1, 1, 0)
... quanto eh A2:  : [](1, 0, 1, 0, 0)
*/
 

imp1 :- 
	matriz(X),
	dim(X,[L,C]), 
	writeln("Num de linhas" : L),
	writeln("Num de colunas" : C),
	(for( I , 1 , L ),
	 param( X , L )
	 do
	   %% retorna a I esima linha do array
	   arg( I ,  X ,  Array_I_Linha ),
	   writeln("Linha da matriz " :Array_I_Linha )
     ).


imp2 :- 
      matriz(X),
      dim(X,[L,C]), 
	 writeln("Num de linhas" : L) ,
	 writeln("Num de colunas" : C) ,
	(foreacharg(Array_I_Linha , X) ,
	  param(L)
	  do
	 writeln(" Linha da matriz " :Array_I_Linha  :L)
       ).
%%%%   OK

imp3 :- 
    matriz(X),
    dim(X,[L,C]), 
    writeln("Num de linhas" : L),
    writeln("Num de colunas" : C),
    (for( I , 1 , L ),
	param( X , L, C )
	do
        (for( J , 1 , C ),
	     param( I, X , L , C)
	     do
	       XX is X[I,J],
	       printf("%3d", XX)
	   %%print(" %d", X[I ,J]) %% formato errado
	   %%write(X[I,J])  %% formato errado
	),
	nl 
     ).

%%% imp generico de X - bidimensional
imp(X) :-
	dim(X,[L,C]),
	writeln("Num de linhas" : L),
	writeln("Num de colunas" : C),
	(for( I , 1 , L ),
	  param( X , C )
	  do(for( J , 1 , C ),
	      param( X, I , C )
	      do
		XX is X[I,J],
		printf("%3d", XX)
	  ),
	  nl
     ).



%t20 :-  A = [](3, 2, 4, 1, 5) ,  writeln( array_a:  A ) ,  A  = ..[ [] | L],   write(L).
%%% conv_Array_List( A , L ) :-  A = ..[ [] |L ], write( " a_l " ).
   

t20:-   
     a(A1),
	 writeln( t1_a1:  A1 ),
	 (foreacharg(X1, A1) 
	   do
	   printf(" %d :" ,  X1 )
     ).
      
%%foreacharg(X,StructOrArray) iterate Goals with X ranging over all arguments of %%StructOrArray. X is a local loop %%%%variable. Cannot be used for constructing a term.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prod_escalar_Array(A1, A2 , Result):-
	(
	 foreacharg(X1, A1),
  	 foreacharg(X2, A2),
	 %% vantagem da lista ... nao precisa declarar o tamanho
     foreach(P_cel, Lista_P_cel)
	 do
	     P_cel  #=  X1*X2 %%% ou  P_cel is X1*X2
     ),
      writeln("Lista de constraint em soma:"  :Lista_P_cel),
      Result #= sum(Lista_P_cel), %%%% SUM eh para LISTAS
      writeln("Um unico valor ... em um dominio -- se for o caso:"  :Result).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t21 :- A = [](3, 1, 5, 4, 2), B = [](1, 2, 4, 3, 5),
       prod_escalar_UDESC(A , B , Result), 
       writeln(" Resultado eh " : Result).
       %%%% resolvido	...	OK

prod_escalar_UDESC(A1, A2 , Sum_Array):-
	dim(A1,[N1]),  
	dim(A2,[N2]),
	% writeln(" ..." : A1),
	((N1 =\= N2) -> 
	    printf("\n ERRO ... tamanhos devem ser iguais");
		N is N1, 
        dim(Array_aux, [N]),
	    writeln(" Criou o Array_aux ..." : Array_aux)
	),
	(
	 foreacharg(X1, A1),
  	 foreacharg(X2, A2),
  	 foreacharg(P_cel, Array_aux)  %% aula
	 do
		 P_cel  #=  X1*X2 %%% ou  P_cel is X1*X2
	     %%%%% , write(P_cel)
      ),

      /* bloco for: faz a soma dos elementos do ARRAYS   
      	( for(I,1,N),
        fromto(0,In,Out,Sum_Array),
        param(Array_aux)
		 do
        Out #= In + Array_aux[I]
	  ),
     */
      /** O bloco acima eh melhorado/simplificado com algo do tipo :**/
      Sum_Array #= sum( Array_aux[1..N] ),
      
      writeln(" Array SOMA de constraints:" : Sum_Array).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* estudo sobre interatores */ 
 
t30 :-
       (fromto( [1,3,5,7], [ C | Resto ], Resto, [ ] ) 
	  do
		printf("  %d  --> Resto:  " , [C] ), %% apenas VAR simples
		writeln( Resto ) 
		%% na ultima linha nao vai ","
    ). 

/*
  1  --> Resto:  [3, 5, 7]
  3  --> Resto:  [5, 7]
  5  --> Resto:  [7]
  7  --> Resto:  []
*/


t40 :-
    (fromto( [], Resto ,  [ C | Resto ], [1,3,5,7] ) , 
      foreach(Aux, Lista)
	do
	  Aux = C , 
	  writeln( Resto ) 
   ),
     writeln( lista: Lista ) . 
     
/*  
[]
[_196]
[_206, _196]
[_216, _206, _196]
lista : [7, 5, 3, 1]
*/
   
inv_L(Lista,Inv) :-
   (fromto( [], Resto ,  [ C | Resto ], Inv ) , 
      foreach(Aux, Lista)
	do
	   %% C is Aux
	   %%  OU
	   C = Aux
    ),
     writeln( lista: Lista ),
     writeln( invertida: Inv ) . 

/*
inv_L([1,3,5,7],X)   
lista : [1, 3, 5, 7]
invertida : [7, 5, 3, 1]
*/

t50:-     
	 a(Array),  writeln("Array:"  :Array ),
	 Idx = 2,
	 %%% IMPORTANTE
	 subscript(Array , [Idx], Elem) ,
	 %% foreachelem(Lin_Array,Array_bidi,Idx),
	 writeln(" Elem ==>" : Elem).

%?- subscript([](3, 5, 7, 9), [2], X).
%X = 5
/* em LISTAS TEMOS:
?- element(Index, [3, 5, 7, 9], 9).
Index = 4
Yes (0.00s cpu)
?- element(3, [3, 5, 7, 9], Valor).
Valor = 7
Yes (0.00s cpu)
*/


t60:- matriz(Matrix),
		 dim(Matrix,[M,N]),
		 subscript(Matrix, [2,1..M], Row),
         subscript(Matrix, [1..N,2], Col),
         subscript(Matrix, [ 2..3, 1..3], Sub),
	         writeln(" Linha ==>" : Row),
	         writeln(" Coluna ==>" : Col),
	         writeln(" Pedacos da Matriz ==>" : Sub),
%%%	 printf(" %d %d %d", Row, Col, Sub),
		 writeln(" Onde a Matriz Original era " ),
	         imp(Matrix).

/* SAIDA: 
Linha ==> : [7, 8, 8, 4]
 Coluna ==> : [5, 8, 5, 5]
 Pedacos da Matriz ==> : [[7, 8, 8], [3, 5, 7]]
 Matriz Original 
Num de linhas : 4
Num de colunas : 4
  7  5  8  2
  7  8  8  4
  3  5  7  9
  5  5  6  7
*/

/*  ESTUDOS .....
    % flatten_array(A1, LA1),
	% writeln("Array:"  :A1),
	% writeln("Array CONVERTIDO para lista:"  : LA1),
*/

channel :- 
	A = [](3, 4, 2, 1, 5), 
	B = [](1, 2, 4, 3, 5, 8, 9),

	dim(A,[N1]),        
	dim(X, [N1]), %% cria um array
%       X :: 1 .. 2, %% vals do dominio para este array
        X :: 0 .. 1, %% vals do dominio para este array

	dim(B,[N2]),
    dim(Y, [N2]), %% cria um array
 %      Y :: -1 .. 2, %% vals do dominio para este array
        Y :: 0 .. 1, %% vals do dominio para este array

	%% feito em sala com os alunos
	prod_escalar_UDESC(A, X , K1),
	prod_escalar_UDESC(B, Y , K2),

	%% convertendo para LISTAS novamente por interesse no sum
    	flatten_array(K1, LX),
    	flatten_array(K2, LY),

%% convertendo para LISTAS novamente por interesse no sum
	sum(LX) #> 11, 
	sum(LX) #< 13, 
	sum(LY) #> 16,
    sum(LY) #< 18, 
	%%	sum(LX) #> sum(LY) ,    %%% OK com listas
	%% os dois arrays estao channeling
	%% ou diretamente nos  arrays ...
      	%% regra: quando o usar os arrays ... usar  os INDICES
   	%% sum( K1[1..N1] ) #> sum( K2[1..N2] ),
       %% em resumo ... os predicados de listas funcionam com ARRAYS
       %% se especificarmos os LIMITES dos arrays

	append(LX, LY, L_todas), %% necessario 
	labeling(L_todas),            %%% um unico labeling
	writeln("Array X:"  : X), /* array com 0 e 1 s do Dom */
	writeln("Array Y:"  : Y) , /* array com 0 e 1 s do Dom */
	writeln("Lista X:"  : LX),
	writeln("Lista Y:"  : LY),
	writeln("Array K1:"  : K1),
	writeln("Array K2:"  : K2),
	
	%% Imprimindo via Array
     imp_index_array("ArrA", A,X,N1),
	 imp_index_array("BrrB", B,Y,N2)
	 .

%% A: Array 
%% X: Solution
%% N: Size of A
%% Text ...
imp_index_array(Text, A, X, N):-
   (for( I, 1, N),
      param( A , X, Text  )
	  do
	   ( Termo1 is  X[I], 
	     %%% IF imprimir apenas X == 1 -- selecionados   
	   ( (Termo1 \== 0) ->
	     	%% THEN
                Termo2 is A[I],
	     	write(Text),
	     	printf(" [%d]=%d : " , [I, Termo2])
	     ; %% ELSE
	     write('') %% else
	   ) %% fim do if
      ) %% fim do do
    ) %% fim do for
   .

%%% X= [](3, 4, 2, 1, 5), XX is X[3], write( XX ).
%%% o uso do is eh obrigatorio
%% AMPLIAR IDEIA PARA BIDIMENSIONAL
%%  IGUAL: DOIS FORs


/* Exercicio: 
   Retomar os valores originais de A  e B onde tem valores .... 1, 
    interesse dos binarios?

	Varias maneiras, a mais simples eh:

	1. Procurar o indice do array/lista onde o valor eh diferente de 0 ou 1 em LISTA
        2. Construa uma lista de INDICE (feito em aula ou na prova) começando de 1 a N.
        3. Lembre array começa em 1 e vai ateh N
	4. Imprimir diretamente  Array baseado nesta Lista de Indice
             writeln(" ......" : array[Index])


       Isto so eh util soh quando se deseja separar um conjunto
    	A=[](-1, 1, 0, -1, -1, 0, -1), subscript(A, [2..4],X), write(X).
        [1, 0, -1]

	Isto serah util para saida dos pgms. 
        Hakan implementou isto com o fromto ... em varios pontos

**********************************************************************
The param's are needed because every do-loop has its own namespace for
 variables.  If you want a variable from outside a loop to be visible
 inside, you must "pass it in" as a param.  You forgot to pass the
 N into the 2nd loop, and the I into the 3rd loop, viz.

   (
     for(I,1,N),param(X,N) do
     (
       for(J,I,N),param(X,I,N) do
      (
         for(K,J+1,N),param(X,I,J) do

         X[K]-X[I]-X[J]#\=0
       )
      )
    ),
**********************************************************************


*/

index :-
(foreacharg(X, [](a,b,c,d,e) , Index) do writeln("x" : X), writeln("index" : Index)).


index(L, L_index) :-
	length(L, N),
	aux_index(L, 1,N,L_index).

aux_index([], N,N,[]).
	
aux_index([C|L], Aux, N,[Aux|Lindex]) :- 
		C == 1,
		New is Aux+1,
		aux_index( L, New , N, Lindex).
      
aux_index([C|L], Aux, N, Lindex) :- 
		C \== 1,
		New is Aux+1,
		aux_index( L, New , N, Lindex).

/* *************************************************/
