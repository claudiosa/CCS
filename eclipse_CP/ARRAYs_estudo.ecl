:-lib(ic).
:-lib(lists).
/*  Arrays:
1. Uma estrutura "quase" igual a lista
2. Há alguns predicados dirigidos a arrays
3. Há como converter array -- > lista
           flatten_array(Array, Lista),
4. Array tem acesso indexado = Vantagem
5. Array: tem tamanho limitado = desvantagem
6. MOTIVACAO search([ tem que ser lista aqui ], 0, anti_first_fail, indomain_middle, complete, []),
7. Problemas = array ... melhor que lista
http://eclipseclp.org/doc/bips/kernel/control/do-2.html
*/


% NOTACAO
a(  [](3, 5, 7, 9)  ).  %%% UNIDIMENSIONAL

b([]([](7, 5, 8, 2),
     [](7, 8, 6, 4),   %% 2a linha
     [](3, 5, 7, 9),
     [](5, 5, 6, 7)
    )
  ). /* matrix bidimensional */
  
%% 2a REPRESENTACAO          
matriz(X) :-  
      X = [](
             [](7, 5, 8, 2),
             [](7, 8, 8, 4),
             [](3, 5, 7, 9),
             [](5, 5, 6, 7)
            ).
        % X recebe esta MATRIZ
/*        
      ?- matriz(X).
X = []([](7, 5, 8, 2), [](7, 8, 8, 4), [](3, 5, 7, 9), [](5, 5, 6, 7))   
  */      

ex_vetor_size1 :- 
       a(X),
       b(Y),
       dim(X, [DimA]),
       dim(Y, [Linha,Coluna]), 
       writeln(size_Array_1: DimA),
       writeln( b_Linha:  Linha ),
       writeln( b_Coluna:  Coluna).

%% Para que ser a dimensao?
%% R: FOR em vetores/arrays

%% preenchemos um vetor com o predicado subscript
ex_vetor_size2 :- 
       dim(X, [5]),
       subscript(X, [3] , 77),
       subscript(X, [4] , 88),
       writeln( x_Vetor:  X).

/*       
?- a(X), subscript(X, [3], Quem_3).
X = [](3, 5, 7, 9)
Quem_3 = 7
Yes (0.00s cpu)
*/
/* flatten ... ACHATA 
?- b(X), flatten_array(X, LX), nl, write(LX).
X = []([](7, 5, 8, 2), [](7, 8, 6, 4), [](3, 5, 7, 9), [](5, 5, 6, 7))
LX = [7, 5, 8, 2, 7, 8, 6, 4, 3, 5, 7, 9, 5, 5, 6, 7]
Yes (0.00s cpu)

ACHAR O PREDICADO que faz o contrario
CUIDAR: O ARRAY tem dimensao a lista NAO!
*/

imp_b(X) :- 
	dim(X,[L,C]), 
	writeln("Num de linhas" : L),
	writeln("Num de colunas" : C),
	(for( I , 1 , L ),
	 param( X  )      %%% PARAMETRO DO BLOCO
	 do                  %% UM FOR => DO 
	   %% arg:retorna a I esima linha do array
	   %% um novo predicado arg ... argumento
	   arg( I ,  X ,  Array_I_Linha ),
	   writeln("Linha da matriz " :Array_I_Linha )
     ).

% USO: b(X), imp_b(X).


imp_b2(X) :- 
    dim(X,[L,C]), 
    (for( I , 1 , L ),
	 param( X , C )    %% X e C sao externos
	  do
        (for( J , 1 , C ),
	     param( I, X ) %% X e I sao externo
	     do
	       X_TERMO is X[I,J],
	       printf("%3d", X_TERMO)
	   %%print(" %d", X[I ,J]) %% formato errado
	   %%write(X[I,J])  %% formato errado
	     ),
	  nl 
     ).

exerc1(N) :-
     dim(X,[N]), %% ANTES DO DOMINIO
     X #:: [88, 99, 44, 55, 66, 77],
 %%  X #:: 1 .. 1000,
     %  alldifferent(X),
     %% CLASSICO e RUDIMENTAR
     %X[1] #< X[2],
     %X[2] #< X[3],
     %X[3] #< X[4],
     %%% generica e elegante
     (
       for( I , 2 , N ),
		  param( X )    
	      do
          %X[I-1] #< X[I]  %%OU
          X[I] #> X[I-1]
     ),
     
     flatten_array(X, LX), %%
     search( LX, 0, first_fail, indomain_min, complete, []),
     writeln( x: X). %% VETOR X
     %% Em resumo fizemos o predicado sorted
     
%% CONTINUANDO ITERADORES     
%foreacharg(X,StructOrArray) iterate Goals with X ranging over all arguments of 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p_escalar1 :- A = [](3, 1, 5, 4, 2), 
              B = [](1, 2, 4, 3, 5),
             %prod_escalar_UDESC(A , B , Result), 
             prod_escalar_Array(A , B , Result), 
             writeln(" Resultado eh " : Result).
             %%%% resolvido	...	OK

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prod_escalar_Array(A1, A2 , Result):-
	(
	 foreacharg(X1, A1), %% EH UM FOR
  	 foreacharg(X2, A2),   %% A tanto lista ou ARRAY
	 %% vantagem da lista ... nao precisa declarar o tamanho
     foreach(P_cel, Lista_P_cel)
	 do
	     P_cel  #=  X1*X2 %%% ou  P_cel is X1*X2
        ),
      writeln("Lista de constraint em soma:"  :Lista_P_cel),
      Result #= sum(Lista_P_cel), %%%% SUM eh para LISTAS
      writeln("Um unico valor ... em um dominio -- se for o caso:"  :Result).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% USO: a(X),  soma(X) .
soma(X) :-
      writeln("Vetor :":X),
      dim(X,[N]),
	  (for(I,1,N),
        fromto(0,In,Out, SUM_END),
        param(X)
		 do
        Out #= In + X[I],
        writeln("Valor :":In :Out: X[I])
	  ),
	  writeln(" sum" : SUM_END)
	 . 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Dada uma matriz MxN qualquer ... faça um predicado que some a diagonal desta MATRIZ desigual (MxN).

diagonal:-
        X = [](
        [](1, 2, 3, 7),
        [](4, 1, 6, 7),
        [](7, 8, 9, 7),
        [](11, 20, 10, 7)
        ),
		dim(X,[ _ ,C]),
	    
    	(for(I , 1 , C),
	  	 param(X),
	   	 fromto( 0 , In , Out , Soma)
	   	do

	      Out #= In + (X[I,I])
	   ),
	writeln(Soma).
