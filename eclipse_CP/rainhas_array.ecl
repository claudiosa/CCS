:- lib(ic).

go1 :-  %% UMA SOL
	       N = 40, %% tamanho do tabuleiro:rainhas ou opcao via lista  
           exec_1(N).
  
exec_1(N) :-
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
	member(N,[ 5 , 10 ]), %%% pode ir aumentando o numero de rainhas 
	queen_array(Solution, N , Back), 
    writeln("Usando arrays" :Solution),
    writeln("Num Backtrackings" :Back),
     
        cputime(T1),   
        T is (T1 - T0),
        writeln([T, 'seconds']),
        fail.
        
go:-    writeln("fim da simulacao com OK").


queen_array(Sol,N, Num_Back) :-
  
    %%% Ex Queen_Array = [X1, X2, ..... X7, X8],
	dim(Queen_Array, [N]),
    %%% ERRO 1 ... esquececemos que INICIALIZAR O VETOR CORRETAMENTE
    Queen_Array[1..N] :: 1 .. N, %% dominio 

%%%% INICIA AQUI
      (for(I ,1, N-1),
        param(Queen_Array, N)
	    do
	      ( for(J, (I+1), N), %%% vejam os index de J
           param(Queen_Array, I)
	       do
	 	    Queen_Array[I]   #\=      Queen_Array[J], 
         
        %%%% OK os 2 abaixo
		%	Queen_Array[I]   #\=      Queen_Array[J]+(J-I),
        %   Queen_Array[I]   #\=      Queen_Array[J]+(I-J),
        %%%% COMO FOI FEITO NO LABORATORIO e estava OK
%            abs(Queen_Array[I]-Queen_Array[J]) #\= abs(J-I),
%            abs(Queen_Array[I]-Queen_Array[J]) #\= abs(I-J)
        %%%% E COMO pode ainda ser pois I < J
            (Queen_Array[I] - Queen_Array[J]) #\= (J-I),
            (Queen_Array[I] - Queen_Array[J]) #\= (I-J)
        
        )
      ) ,

    flatten_array( Queen_Array , Sol), 
    search(Sol,0, occurrence , indomain, complete,[backtrack(Num_Back)]).
%%%anti_first_fail, first_fail 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* AUXLILIAR   versao com array .. */
%% convertendo LISTA para ARRAY
list2array(L,A) :-
                length(L, Size),
                dim(A,[Size]),
                (foreacharg(X,A),
		        foreach(X,L) do true). 
%%% ou com o construtor  =..  ::  Lista =.. [_|Array]


/*

*/
