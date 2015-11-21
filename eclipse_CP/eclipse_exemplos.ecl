
%%:- use_module(library(clpfd)). 
%%%:- use_module(library(bounds)). 
:- lib(ic).
:- lib(branch_and_bound).

/* Escalonador ==> Robo :: ver enunciado livro */    
t1 :-
    cputime(T1),
    robo_clp( L_saida ), nl, 
    printf("\n Saida: %w ", [L_saida]),
    cputime(T2),
    Total is (T2 - T1),
    printf("\n Tempo de CPU foi de %6.3f segundos", [Total]).
    
robo_clp( [(a,A),(b,B),(c,C),(d,D),(e,E)] ) :-

   Variaveis = [A,B,C,D,E] ,  /* uma lista em Prolog  */
/* Dominio das Variaveis A, B e C */
   Variaveis :: [1 .. 4],
  
   /* Conjunto de Restricoes:: como ocorreu
   naturalmente no problema, e se modelou assim: */
   A #= D,  /* duas variaveis iguais */
   C #< D,
   E #< A,
   E #< B,
   E #< C,
   E #< D,
   B #\= 3,
   C #\= 2,
   A #\= B,
   B #\= C,
   B #\= D,
   labeling(Variaveis).
/*********************************************/    
t2 :- s2(X, Y), 
      printf("\n Saidas: X = %w \t Y = %w ", [X,Y]).
s2(X, Y)   :-   
%%   [ X, Y ] :: [1..10],
     [ X, Y ] :: 1 .. 10,
    Y #>= 5,
    X #> Y + 2,
    X #<  9.
    
/*********************************************/        
t3:- s3([X, Y, Z]), 
    write([X, Y, Z]),
  printf("\n Saidas: X = %d \t Y = %d \t Y = %d ", [X,Y,Z]). 

s3([X, Y, Z]) :- 
      [X, Y, Z] :: 1 .. 10, 
      X #> Y, 
      Y #> Z.
/*********************************************/        
dominios([X, Y]) :-
  X  :: [1 .. 1000000],  
  Y  :: [1 .. 3],
  X #< Y,           
  indomain(X),
  indomain(Y).

/*
?- dominios(X).
X = [1, 2]
Yes (0.00s cpu, solution 1, maybe more)
X = [1, 3]
Yes (0.03s cpu, solution 2, maybe more)
X = [2, 3]
Yes (0.03s cpu, solution 3)

*/

t4:- s4(X), write(X), nl.
s4(X) :-
     X :: [1 .. 10],
     indomain(X, min).      
/********************************************/
 t5:-  ( count( Var, 3, 7) do writeln(Var)). 
 
 t6 :- ( count( Var, 3, 7) do printf("\t %w", [Var])). 
/********************************************/ 

solucao:-
     fab( [A:T1,B:T2,C:T3] ), nl,
( 
  %% param(T1,T2,T3),
  count( T, 1, 3),
  foreach(X:Y , [A:T1,B:T2,C:T3]) 
  do
  printf("\n Trabalhador %w esta na tarefa/tipo: %w custo: %w", [T, X,Y])
), 
  Total is (T1 + T2 + T3),
  printf("\n Total: %w", [Total]).

fab( [A:T1,B:T2,C:T3] ) :-
/* 
  Dominios e Variaveis ... opcionais NESTE EXEMPLO, 
  pois está tudo declarado na lista member
       Indice_tarefa = [A,B,C], 
	   Indice_tarefa :: [1 .. 5],
	   T1 :: [ 5, 1, 3, 4, 6] ,
	   T2 :: [ 8, 8 , 5, 7, 3] ,
	   T3 :: [ 4, 9, 1, 5, 2], 
*/	   
	member( A:T1, [ 1:5, 2:1, 3:3, 4:4, 5:6] ),
	member( B:T2, [ 1:8, 2:8, 3:5, 4:7, 5:3] ),
	member( C:T3, [ 1:4, 2:9, 3:1, 4:5, 5:2] ),
    T1 + T2 + T3 #> 15,
	alldifferent([A,B,C]),
	labeling( [A, T1, B, T2, C, T3] ).


fab_2( [I:T1, J:T2, K:T3]) :-    
     [I,J,K] :: [1 .. 5],
     M1 =  []( 5, 1, 3, 4, 6) ,
	 M2 =  [](8, 8 , 5, 7, 3),
	 M3 = [](4, 9, 1, 5, 2), 
       % dim(M1, [1,5]),
       % dim(M2, [1,5]),
       % dim(M3, [1,5]),
     labeling( [ I, J, K]),
     alldifferent([I,J,K]),
	 subscript(M1, [I], T1),
	 subscript(M2, [J], T2),
	 subscript(M3, [K], T3),
	 %% OU  T1 + T2 + T3 #> 15.
	 M1[I] + M2[J] + M3[K] #> 15.

/*******************************************************/

fab_3( [I:M1, J:M2, K:M3] ) :-    
     [I,J,K] :: [1 .. 5],
     M1 =  [](5, 1, 3, 4, 6) ,
	 M2 =  [](8, 8 , 5, 7, 3),
	 M3 =  [](4, 9, 1, 5, 2), 
     labeling( [ I, J, K]),
     alldifferent([I,J,K]),
	 M1[I] + M2[J] + M3[K] #> 15.
	

imp_fab_3:-
fab_3( [I:M1, J:M2, K:M3] ),
W1 is M1[I], W2 is M2[J], W3 is M3[K],
printf("\n Trabalhador 1 esta na tarefa/tipo: %w custo: %w", [I,W1]),
printf("\n Trabalhador 2 esta na tarefa/tipo: %w custo: %w", [J,W2]),
printf("\n Trabalhador 3 esta na tarefa/tipo: %w custo: %w", [K,W3]),
Total is (W1 + W2 + W3),
printf("\n Total: %w", [Total]).      

/*******************************************************/      	 
      
/*
aprendendo matriz...

M1 =  []( 5, 1, 3, 4, 6) , subscript(M1, [2], X), write(X).
M1 =  []( 5, 1, 3, 4, 6) , X is (M1[2]) , write(X).
fab_3( [I:M1, J:M2, K:M3]), W is M1[I], write(W).
*/

t10 :- herman([A:T1,B:T2,C:T3] ),
	( count( T, 1, 3),
	  foreach(X:Y , [A:T1,B:T2,C:T3]) 
	  do
	  printf("\n Trabalhador %w esta na tarefa/tipo: %w custo: %w", [T, X, Y])
	).
      
herman([T1:X1, T2:X2, T3:X3]) :-
	W1 = [](5,1,3,4,6),
	W2 = [](8,8,5,7,3),
	W3 = [](4,9,1,5,2),
	T1 :: 1..5,
	T2 :: 1..5,
	T3 :: 1..5,
	%%%  ou  simplesmente [T1,T2,T3] :: [1 .. 5],
	alldifferent([](T1,T2,T3)),
	labeling([](T1,T2,T3)),
	subscript(W1,[T1],X1),
	subscript(W2,[T2],X2),
	subscript(W3,[T3],X3),
	X1 + X2 + X3 #> 15.

ismael(Tarefa) :-
   Custo = [[5, 1, 3, 4, 6],
            [8, 8, 5, 7, 3],
            [4, 9, 1, 5, 2]],
   Tarefa = [T1, T2, T3],
   Tarefa :: 1..5,
   Custo = [Row1, Row2, Row3],
   element(T1, Row1, CostRow1),
   element(T2, Row2, CostRow2),
   element(T3, Row3, CostRow3),
   Valor #= CostRow1 + CostRow2 + CostRow3,
   Valor #>= 15,
   NegValor #= (-1) * Valor, 
   %%%Para maximizar
   minimize(labeling(Tarefa), NegValor).

   

t7 :- (  foreach( _:Y, [1:33, 2:44]) 
          do
          (Y > 35 ->  printf("\n Uma resp: %w",[Y]) ; 
                      printf("\n NAO ",[])
          )            
      ).    




t8(X) :- 
    X :: [30..40],
   (foreach( _:Y, [1:33, 2:44]) ,
      param(X)
      do
     Y #> X 
     ).    


t9( [A:T1,B:T2,C:T3] ) :-
		Variaveis = [A,B,C],
		Variaveis :: [1 .. 5],
		T1 :: [ 5, 1, 3, 4, 6] ,
	   	T2 :: [ 8, 8 , 5, 7, 3] ,
	    T3 :: [ 4, 9, 1, 5, 2],  
		 
		alldifferent([A,B,C]),
		T1 + T2 + T3 #>= 15.
		

 

