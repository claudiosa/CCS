/*

  Global constraint global contiguity in ECLiPSe.

  From Global constraint catalog
  http://www.emn.fr/x-info/sdemasse/gccat/Cglobal_contiguity.html
  """
  Enforce all variables of the VARIABLES collection to be assigned to 
  0 or 1. In addition, all variables assigned to value 1 appear contiguously.
  """

  The implementation of global contiguity below was inspired by 
  Toby Walsh's presentation "Sliding Constraints"
     http://www.cse.unsw.edu.au/~tw/samos/slide.ppt
  where he defines it in terms of the global constraint slide.

  Compare with the following models:
  * MiniZinc: http://www.hakank.org/minizinc/global_contiguity.mzn
  * Comet   : http://www.hakank.org/comet/global_contiguity.co


  Model created by Hakan Kjellerstrand, hakank@bonetmail.com
  See also my ECLiPSe page: http://www.hakank.org/eclipse/

*/

:-lib(ic).
:- lib(branch_and_bound).






go1 :-

        N = 10,
        length(X, N),
        X :: 0..1,

        global_contiguity(X),
        
        labeling(X),
        writeln(X),
        fail.



go2 :-

V_unidim = []( 60, 60, 60, 25, 30, 47, 65, 55, 71, 95 ,
		28, 27, 82, 83, 74, 93, 35, 63, 85, 46 ,
		74, 97, 71, 96, 70, 10, 73, 13, 43, 96 ,
		2, 55, 3, 69, 61, 1, 5, 73, 59, 56 ,
		46, 96, 59, 83, 4, 42, 22, 29, 67, 59 ,
		42, 22, 29, 67, 59, 46, 96, 59, 83, 4 ,
		1, 5, 73, 59, 56, 2, 55, 73, 69, 61 ,
		10, 73, 13, 43, 96, 74, 97, 71, 96, 70,
		93, 35, 63, 85, 46, 28, 27, 82, 83, 74,
		47, 65, 55, 71, 95, 20, 24, 11, 25, 300 ),

        N = 100,
        dim(X,[N]),
        X :: 0..1,
		dim(AUX,[N]),
	    %%writeln(" OK1 ..."),
	    %%% TAKE CARE: eh ARRAY
		
		
			
        %%contiguity(X,5),	
		
		%%writeln(X),
		
		N2 is N-5,
		
		(for( I, 1, N2), param(X) do
		  (
		     K1 is (I+1),
		     K2 is (I+2),
		     K3 is (I+3),
		     K4 is (I+4),
		     
		    (X[I] == 1 -> X[K1] #= 1,X[K2] #= 1,X[K3] #= 1,X[K4] #= 1,
		        X[K1] +X[K2] + X[K3] + X[K4] #= 4 );
			 write(' x')
		  )
	    ),
		
			
		
		(for( I, 1, N), param( V_unidim, X , AUX) do
		  (
		    AUX[I] #= V_unidim[I] * X[I]
		    %%writeln(" OK ...": AUX)
		  )
	    ),
		
		 
		
		Z #= sum(AUX[1..N]),
		
		Zneg #= Z,
		
		flatten_array(X , L_X),
		sum(L_X) #= 5,
		
		
		 
		
		
		
				
		%%bb_min(L_X), Zneg, 0).
		 minimize(search(L_X,0,first_fail,indomain,complete,[]),Zneg),
		 
		 (foreach(S1,L_X) do
			write(S1)
			),
		 
		 
		 writeln(L_X).
		/*
		 Options = bb_options{strategy:continue},
		bb_min(custo_menor((X),Zneg),ZNeg,Options)
		*/
		
	
	
		
		
		/*
		
		usando o fail
		
		
		Found a solution with cost -150
[1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Desktop/prova.pl compiled 3760 bytes in 0.02 seconds
Found a solution with cost -235
[1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -222
[0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -227
[0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -222
[0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -268
[0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -333
[0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -314
[0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -276
[0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -303
[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -315
[0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, ...]
Found a solution with cost -294
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, ...]
Found a solution with cost -359
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, ...]
Found a solution with cost -367
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, ...]
Found a solution with cost -348
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, ...]
Found a solution with cost -350
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, ...]
Found a solution with cost -322
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, ...]
Found a solution with cost -303
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, ...]
Found a solution with cost -365
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, ...]
Found a solution with cost -373
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, ...]
Found a solution with cost -384
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -408
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -344
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -320
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -262
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -209
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -235
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -227
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -209
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -199
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -225
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -190
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -189
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -139
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -209
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -199
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -194
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -239
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -330
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -316
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -340
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -288
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -284
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -210
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -180
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -164
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -219
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -219
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -219
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -219
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -219
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -219
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -223
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]
Found a solution with cost -297
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...]


	*/
		
		
        %%writeln(AUX).
		%% %%% FAZ SEMPRE FALHA ===> FALSO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% UM ULTIMO AI DAH YES

%
% contiguity: all variables assigned to value 1 appear contiguously.
%
global_contiguity(X) :-

        length(X, Len),
        length(Y, Len),
        Y :: 0..2,
         
        ordered(=<, Y),
        (foreach(XVal,X),
         foreach(YVal,Y) do
             (XVal #= 1) #= (YVal #= 1)
        ).
/* **********************************************/
contiguity(X, Naux):-

    % writeln(" OK2 ..." : X),
    dim(X,[N]),            %% Do Vetor Decisao
	%%writeln("....." : N),
	INDEX :: 0 .. (N-Naux), %% uma variavel que vai de 0 a (N-Naux)
    
    dim(AUX,[Naux]), %% criado um array AUX de tamanho Naux
    AUX :: 0 .. 1 ,
      
    (for( I, 1, Naux ), param( AUX  ) do
		  (
		    AUX[I] #= 1
		    %%%% , writeln(" OK ...": I)
		  )
	  ),	  
	   
	%%% writeln(" OK ..."),
	
	sum( X[1 .. N] ) #= Naux ,
	%%writeln(" ... "),
	  labeling([INDEX]),
	  (for(J, 1, Naux ), param( X, AUX, INDEX ) do
		 ( 
		   X[J+INDEX] #= AUX[J]
		 )
		%% ,
		%% writeln(" ...")
     
     ).
		
		
/* **********************************************/     
