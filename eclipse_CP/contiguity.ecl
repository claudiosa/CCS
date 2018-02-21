/*

lists.eco  loaded in 0.01 seconds
[1, 1, 1, 1, 1, 0, 0, 0, 0, 0]
[0, 1, 1, 1, 1, 1, 0, 0, 0, 0]
[0, 0, 1, 1, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 1, 1, 0, 0]
[0, 0, 0, 0, 1, 1, 1, 1, 1, 0]
[0, 0, 0, 0, 0, 1, 1, 1, 1, 1]
*/
:-lib(ic).

/* pode usar o findall no lugar do fail 
   contudo todas as respostas virao em formato
   de lista
  */

go:-
  N is 10,
  dim( X, [N] ) ,   %% Criei um Vetor Decisao
  X :: 0 .. 1 ,     %% dominio
  %% writeln(" OK ..."),
  contiguity(X, 5),
  flatten_array(X,List),        
  labeling(List),
  writeln(List),
  fail.

/*************************************************************/
contiguity(X, Window_Size ):-

	dim(X,[N]),            %% Do Vetor Decisao
    INDEX :: 0 .. (N - Window_Size), %%% Uma var para constraint
    dim(AUX,[Window_Size]),
    AUX :: 0 .. 1 ,
    (for( I, 1, Window_Size ), param( AUX  ) do
		  (
		    AUX[I] #= 1
		    %%,writeln(" OK ...": I)
		  )
	  ),	  
	 %%% writeln(" OK ..."),
	sum( X[1 .. N] ) #= Window_Size ,
	%% writeln(" ... "),
	  labeling([INDEX]), %% Gera INDEX com 0, 1, 2 ....
	  %% instancia INDEX
	  
	  %%% Percorre o vetor AUX ...
	  (for(J, 1, Window_Size ), param( X, AUX, INDEX ) do
		 ( 
		   X[J+INDEX] #= AUX[J]
		 )
		%% ,
		
		%% writeln(" ...")
     
     ).

/*************************************************************/
