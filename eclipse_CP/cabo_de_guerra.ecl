
:-lib(ic).
:-lib(branch_and_bound).

%% problema classico do Cabo de Guerra .... N par
%% Valido para o sub-set sum
peso( [](3, 4, 7, 8, 2 , 1)  ).  %%% UNIDIMENSIONAL

/* *************************************************** */      

go :-
   %%% MELHORAR isto ... ver o problema da Mochila e o sub-set-sum
   model(P,V_D1,V_D2, L_Xearch, Diff),
   explore(L_Xearch, Diff),
   outputs(P,V_D1,V_D2, L_Xearch, Diff ).

/*******************************************/

model(P,V_D1,V_D2, L_Xearch, Diff):- 
  peso(P),
  dim(P, [N]),  
  dim(V_D1, [N]),  
  dim(V_D2, [N]),  
  V_D1 #:: [0 , 1], %%% OR
  V_D2 #:: 0 .. 1,
  
%% INT ... is div
  Middle is N div 2,
  writeln(middle : Middle),
  
%%  Constraints
  (for(I,1,N),
		param( P , V_D1 ),
		fromto( 0 , In , Out , TotalCost1) 
    	do
    		Out #= In + (P[I] * V_D1[I])
	),  	
%%  Constraints 
  (for(I,1,N),
		param( P , V_D2 ),
		fromto( 0 , In , Out , TotalCost2) %%% truque
    	do
    	Out #= In + (P[I] * V_D2[I])
	) ,

%%  Constraints
    (for(I,1,N),
		param( V_D1, V_D2 )
		do
    	V_D1[I] #\= V_D2[I]
	),
 %% sum is left - associative
 
 %%  Constraints
 Middle #= sum( V_D1[1..N] ) ,
 Middle #= sum( V_D2[1..N] ) ,
 %%POIS o original eh assim sum(Middle , V_Di[1..N] ) ,

   array_list(V_D1, LX1),        
   array_list(V_D2, LX2),

  %% sum works equally with lists or arrays
  % Middle #= sum( LX1 ) ,
  % Middle #= sum( LX2 ) ,
  	writeln(totalCost1 :TotalCost1),
	writeln(totalCost2 :TotalCost2),

%% objetive function	
   Diff #= abs(TotalCost1 - TotalCost2),
  %%writeln(diff : Diff),
   
  append(LX1, LX2, L_Xearch ).
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

explore(L_Xearch, Diff) :-
    %% vai minimizar Diff com base em L_Xearch
	minimize(search(L_Xearch,0,first_fail,indomain,complete,[]), Diff ).

/* *************************************************** */      

outputs(P,V_D1,V_D2, L_Xearch, Diff ):-

   printf(output, "\n OUTPUTS ...............\n", []),
   writeln( vetor_Pesos : P),
   writeln( diff_Branch_Bound : Diff),
   writeln(l_Xearch : L_Xearch),
   my_print(V_D1,P),
   my_print(V_D2,P).
    
/* *************************************************** */      
 
 my_print(V_X ,P):-
   
   printf(output, "\n" , [] ),
   	dim(P,[N]), 
   	writeln( decision_Vector : V_X), 
	(for( I , 1 , N ),
	 param( V_X , P  )
	 do
	   ( XX_truque is V_X[I], %% TAKE CARE 
	     YY_truque is P[I], 
	     XX_truque == 1 -> printf(" Vector[%d] : %d " , [I, YY_truque]) ;
	     write(" . ")
	   )	   
    ),
    printf(output, "\n ======================================" , [] ).
    
/* *************************************************** */      

print_list_by_array(L_all):-  
   list2array(L_all,Array),
   	dim(Array,[L]), 
	(for( I , 1 , L ),
	 param( Array  )
	 do
	   %% retorna a I esima linha do array
	   arg( I ,  Array ,  Array_I_Linha ),
	   writeln("Linha do array " : I : Array_I_Linha )
    ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AUXs
list2array(L,A) :-
                length(L, Size),
                dim(A,[Size]),
                (foreacharg(X,A),
		        foreach(X,L) do true). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AUXs
/*
 OUTPUTS ...............
vetor_Pesos : [](3, 4, 7, 8, 2, 1)
diff_Branch_Bound : 1
l_Xearch : [0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0]

decision_Vector : [](0, 1, 0, 1, 0, 1)
 .  Vector[2] : 4  .  Vector[4] : 8  .  Vector[6] : 1 
 ====================================== 
 
decision_Vector : [](1, 0, 1, 0, 1, 0)
 Vector[1] : 3  .  Vector[3] : 7  .  Vector[5] : 2  . 
 ====================================== 
*/
