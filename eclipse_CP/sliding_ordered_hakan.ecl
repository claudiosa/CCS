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
:-lib(ic_global).


go1 :-

        N = 10,
        length(X, N),
        X :: 0..1,

        global_contiguity(X),
        
        labeling(X),
        writeln(X),
        fail.



go2 :-

        N = 10,
        dim(X,[N]),
        X :: 0..1,
	    %writeln(" OK1 ..."),
	    %%% TAKE CARE: eh ARRAY
        contiguity(X,5),
        
        labeling(X),
        writeln(X),
        fail. %%% FAZ SEMPRE FALHA ===> FALSO
        
        
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
go2. %% UM ULTIMO AI DAH YES

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
/* *********************

?- append([1], [3], X).
X = [1, 3]
Yes (0.00s cpu)

 

continuo_new(X, Naux):-
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
	
	flatten_array(X,LX),
	flatten_array(AUX,L_AUX),
	
	ou exclusivo e shiff



?- shift([0, 0, 0, 0, 1, 1, 1], X), shift(X, Y).
X = [0, 0, 0, 1, 1, 1, 0]
Y = [0, 0, 1, 1, 1, 0, 0]
Yes (0.00s cpu)

*/
t:- shift([1,1,1,0,0,0,0], X), write(X).

shift( [ Head | Tail ], Shifted ) :-
		append( Tail, [ Head ], Shifted ).


