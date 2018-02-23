:- lib(ic_global).

:-lib(ic).
%:-lib(ic_global).
%:-lib(ic_search).
:-lib(branch_and_bound).
%:-lib(suspend).


go1 :-
  N is 10,
  dim( X, [N] ) , %% Criei um Vetor Decisao
  X :: 0 .. 1 , %% dominio
  contiguity(X, 3),
  flatten_array(X,List),        
  labeling(List),
  writeln(List).%%,fail.


dim(X,[N]),       %% Criei um Vetor Decisao
    X :: 0 .. 1 , %% dominio
    dim(AUX,[Naux]),
    AUX :: 0 .. 1 ,
    (for( I, 1, Naux ), param( AUX  ) do
		  (
		    AUX[I] #= 1,
		    writeln(" OK ...": I)
		  )
	  ),	  
	   
	writeln(" OK ..."),
	
	%%sum( X[1 .. N] ) #= Naux ,
	writeln(" ..."),
	
	(for(I, 0 , N - Naux ), param( X, AUX, Naux  ) do
	  (for(J, 1, Naux ), param( X, AUX, I ) do
		 ( 
		   X[J+I] = AUX[J]
		 ),
		     
		 writeln(" ...")
		%% X[J+1] #= 1
       )
     ).


/*
contiguity(X, N1):-

	dim(X,[N])      , %% Criei um Vetor Decisao
    X :: 0 .. 1 , %% dominio
	writeln(" ..."),
	/* it's works
	   X[3] #= 1 , 
	  X[3] #=  X[3+1]  , 
	  X[3+1] #=  X[3+2]  ,
	 */    
	sum( X[1 .. N] ) #= N1 ,
	writeln(" ..."),
	(for(J, 1, N - 2 ),
		param( X  )
		do
		 ( 
		   (X[J] = 0 ->
		    X[J+1] #=  X[J]+1 , 
		    X[J+1] #=  X[J+2] ,
		    X[J+2] #=  X[J+3] ;
		    writeln(" ELSE ...")
		   ) 
		 ) ,
		     
		 writeln(" ...")
		%% X[J+1] #= 1
       )
       .
 */  
  
/*

contiguity(X, N1):-

	dim(X,[N])      , %% Criei um Vetor Decisao
    %%% X :: 0 .. 1 , %% dominio
	sum( X[1 .. N] ) #= N1 ,
	(for(J, 0, N -1 ),
		param( X  )
		do
		 ( X[J+1] = 1 ->
		     supend( X[J+2] #= 1 ) ;
		     writeln(" ...")
		 ) ,
		     
		 writeln(" ...")
		%% X[J+1] #= 1
       )
       .


  dim(X,[N]), %% Criei um Vetor Decisao
    %%% X :: 0 .. 1, %% dominio
   K is (N-N1+1),
  writeln(" ..."),
 
    
	(for(I, 1, K),
	
	  param( X,  N1 )
		do
		 %%%writeln(" ..... %%"),
		 (for(J, 0, N1-1 ),
			param( X, I )
			do
			X[I+J] #= 1
		  )
	),
	write( X).
	
	%%writeln("D ..... %%", X)
*/	
	
	   	
			

/*

%% array custo UMA dim
custo(1, [](210,11,23,35,38,200)   ).

go2 :- 
    custo(1,Custo), %% Tudo em Custo
    dim(Custo,[N]), %%  Retorna N 
    dim(V_Dec,[N]), %% Criei um Vetor Decisao
    V_Dec :: 0 .. 1, %% dominio
 
 /* FOR sobre o ARRAY */   
	(for(I,1,N),
		param( Custo , V_Dec ),
		fromto( 0 , In , Out , TotalCost) %%% truque
    	do
    	
		Out #= In + (Custo[I] * V_Dec[I])
	),
 
 %% writeln(Out),
 %% writeln(TotalCost),
        
    sum( V_Dec[1 .. N] ) #= 3, 
    %% um valor escolhido de 3 grande
    % prepare for maximization (if needed)
      TotalCostNeg #= -TotalCost,
  
% search
% 
        
   flatten_array(V_Dec,V_Dec_List),        
   minimize(search(V_Dec_List,0,first_fail,indomain,complete,[]), TotalCostNeg),
   writeln(V_Dec).

*/	



% pretty prints a matrix
pretty_print(X) :-
        dim(X, [Rows,Cols]),
        ( for(I, 1, Rows), param(X, Cols) do
            ( for(J, 1, Cols), param(X, I) do
                XX is X[I,J],
                printf("%3d", XX),
                write("  ")
            ),
            nl
        ).        

