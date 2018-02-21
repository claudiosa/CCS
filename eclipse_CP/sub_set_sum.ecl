:- lib(ic).
%%:- lib(array).
%%:- lib(branch_and_bound).
 
casos_de_testes(
        [[](3, 1, 7, 7, 9, 4), 
        [](17, 30, -5, 40, 4),
        [](2,  3,  -4, 12),
        [](2, 4, 4, 5,  40, 3, 17)]
       ).

go :-
   	casos_de_testes(Lista_Testes),
	member( Array_Set , Lista_Testes),
	
	K is 17, %%% qualquer K

	modelo( Array_Set , K, LX_Solucao ),
    my_print( Array_Set, LX_Solucao,  K),  
    fail.
    
go.    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modelo(Matriz_Peso, K, L_Vars ) :-
    
    dim(Matriz_Peso, [N]),
    dim(V_Decisao, [N]), %% Vetor Decisao
    V_Decisao :: 0..1,
        
    %%  Encontrando a SOMA
     (for(I,1,N),
		param( Matriz_Peso , V_Decisao ),
		fromto( 0 , In , Out , SOMA) 
    	do
    		Out #= In + (Matriz_Peso[I] * V_Decisao[I])
    ),
    
    SOMA #= K, %%% RESTRICAO DO SUB SET SUM
   
    flatten_array(V_Decisao, L_Vars ), %%% VELHO
    %%% BUSCA
    search( L_Vars , 0, first_fail, indomain_min, complete, []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pretty_print(X) :-
        dim(X, [N]),
        ( for(I, 1, N), param(X, N) do
            ( for(J, 1, N), param(X, I) do
                XIJ is floor(X[I,J]),
                write(XIJ), write(" ")
            ),
            nl
        ).


my_print(P, LX_Sol , K):-
   	dim(P,[N]),
   	writeln( conjunto_Teste : P),
    list2array(LX_Sol, Array_Sol), %% LX_Sol ... formato lista
   	writeln( decision_Vector : Array_Sol ),
 	(for( I , 1 , N ),
	 param( Array_Sol  , P  )
	 do
	   ( XX_truque is Array_Sol[I], %% TAKE CARE  it is ARRAY
	     YY_truque is P[I], 
	     XX_truque == 1 -> printf(" Vector[%d] : %d " , [I, YY_truque]) ;
	     write(" . ")
	   )	   
    ),
    printf("\n Valor da soma era: %d ", K),
    printf(output, "\n======================================\n " , [] ).


 %%% contrario use este
list2array(L,A) :-
                length(L, Size),
                dim(A,[Size]),
                ( foreacharg(X,A),
		           foreach(X,L)
		           do
		           true).          
