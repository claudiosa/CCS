:- lib(ic).

uma_sol :- 
	      N = 80, %% tamanho do tabuleiro:rainhas ou opcao via lista  
              exec_1(N),
              exec_2(N).

exec_1(N) :-
      cputime(T0),
      rainhas(Solution, N, Back) ,   
      writeln("Usando listas" :Solution),
      writeln("Num Backtrackings" :Back),
      cputime(T1),   
      T is (T1 - T0),
      writeln([T, 'seconds via listas']).
     

exec_2(N) :-
      cputime(T0),
      queen_array(Solution, N , Back), 
      writeln("Usando arrays" :Solution),
      writeln("Num Backtrackings" :Back),
      cputime(T1),   
      T is (T1 - T0),
      writeln([ T , 'seconds via arrays']).
     


go :-
	cputime(T0),
	%%%N = 4, %% tamanho do tabuleiro:rainhas ou opcao via lista
	member(N,[ 4 , 6 ]), %%% podes ir pondo o numero de rainhas 
	%% que desejares para o teste
        rainhas(Solution, N, Back) ,   
        writeln("Usando listas" :Solution),
        writeln("Num Backtrackings" :Back),
     
      queen_array(Solution, N , Back), 
      writeln("Usando arrays" :Solution),
      writeln("Num Backtrackings" :Back),
      
        cputime(T1),   
        T is (T1 - T0),
        writeln([T, 'seconds']),
        fail.
        
go:-    writeln("fim da simulacao com OK").

%%%% Simulacao INDIVIDUAL ::: metodo lista com PR
g1 :- rainhas(Sol,7, Back)   ,   
      writeln("Usando LISTAS" : Sol),
      writeln("Num Backtrackings" :Back). 

rainhas(Vars,N, Num_Back) :-
    %%% criando uma lista de N variaveis
    length( Vars, N),
    %%% Ex. Vars = [X1, X2, ..... X7, X8],
	Vars :: 1 .. N, %% dominio 
		
    % Problem restricoes
	alldifferent(Vars),
	postar_restricoes(Vars),
	search(Vars,0,first_fail,indomain, complete,[backtrack(Num_Back)]).
  
%	writeln(" Lista Sol" :Vars). 

%% postar constraint de X1 a Xn ... veja grafo
postar_restricoes([_]).
postar_restricoes([C|L]) :-
	seguro(C,L,1),
	postar_restricoes(L).
%% construa o grafo de restricoes aqui

%% idem aqui a arvore
seguro(_, [], _).       
seguro(C, [H|L], Desl) :-
	C  #\= H,
	C  #\= H+Desl,
	C  #\= H - Desl ,
	Novo is (Desl +1),
	seguro(C, L, Novo).


/*  versao com array .. */
%% convertendo LISTA para ARRAY
list2array(L,A) :-
                length(L, Size),
                dim(A,[Size]),
                (foreacharg(X,A),
		  foreach(X,L) do true). 
%%% ou com o construtor  =..  Lista =.. [_|Array]

%%%% Simulacao INDIVIDUAL :: usando arrays
g2 :- queen_array(Sol,7, Back) , 
	  writeln("Usando ARRAYS" : Sol),
      writeln("Num Backtrackings" :Back). 

queen_array(Sol,N, Num_Back) :-
    %%% criando uma lista de N variaveis
    length( Vars, N),
    %%% Ex Vars = [X1, X2, ..... X7, X8],
	Vars :: 1 .. N, %% dominio 
%%  dim(Array, [N]),
%   writeln("Vars N"  :Vars :N),
    list2array(Vars,Array),

%%%% INICIA AQUI
      ( for(I ,1, N-1),
         param(Array, N)
	 do
	%% write('1..'),
       ( for(J, (I+1), N),
           param(Array, I)
	       do
	   %%  write('2..'),
		Desl is (J-I),
	    Array[I]   #\=  Array[J],
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	        ( for(Desl, I, N-1),	 
%		   param(Array, I, J)
%			do
%			write('3..'),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			Array[I]   #\=  Array[J]+Desl,
			Array[I]   #\=  Array[J]-Desl
                  %%%%% for do Desl)
             )
       	 ) ,
%   writeln("Array"  :Array :N),  
    flatten_array( Array , Sol), 
    search(Sol,0,first_fail,indomain, complete,[backtrack(Num_Back)]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
:-go.
rainhas_cc.ecl compiled 8592 bytes in 0.02 seconds
Usando listas : [2, 4, 1, 3]
Num Backtrackings : 1
Usando listas : [3, 1, 4, 2]
Num Backtrackings : 2
Usando arrays : [2, 4, 1, 3]
Num Backtrackings : 1
Usando arrays : [3, 1, 4, 2]
Num Backtrackings : 2
[0.0, seconds]
*/
