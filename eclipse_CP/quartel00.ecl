:-lib(ic).

quartel:-
	modelo([NO, N, NE, E, SE, S, SO, O] ) ,
   /* write([NO, N, NE, E, SE, S, SO, O] ). */
	printf("\n %d   %d   %d " , [NO, N, NE] ),
	printf("\n %d       %d"   , [O, E] ),
	printf("\n %d   %d   %d " , [SO, S, SE ]). 


modelo([NO, N, NE, E, SE, S, SO, O]) :-
	/* Declarando as variaveis */
	L_VAR = [NO, N, NE, E, SE, S, SO, O],
	L_VAR :: 1..3,
	/* POSTAR as RESTRICOES  PASSIVAS */
 	 NO #>= 1,
	 N #>= 1,
	 NE  #= 3,  %%% quebra de simetria
	 E  #>= 1, 
	 SE  #>= 1, 
	 S  #>= 1, 
	 SO  #= 3,   %%%% quebra de simetria
	 O #>= 1,
	 (NO + N + NE) #>= 5,
	 (SE + S + SO) #>= 5,
	 (NE + E  +  SE) #>= 5,
	 (SO + O + NO) #>= 5,
	 %%%% (NO + N + NE+ SE + S + SO + O + E) #=< 12, 
	 %%%% Equivalente a:
	 sum([NO, N, NE, E, SE, S, SO, O]) #=< 12,
	
	/* BUSCA + EXPANSAO */
	 search(L_VAR, 0 , first_fail, indomain, complete, []).
	 %%%% Equivalente a:
%%%  labeling([NO, N, NE, E, SE, S, SO, O]).
 	 




 	
	
	
	
	
	
