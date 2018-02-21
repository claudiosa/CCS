
%%%%  3-CNF SATISFATIBILITY
% As duas libs devem ser incluidas
% sintaxe e busca
:-lib(fd).    
:-lib(fd_search).
%:- use_module(library(fd)). 
%:- use_module(library(fd_search)). 

go :- model(L),
      busca(L),
      print_list_by_array(L),
      fail. %% for ALL SOLUTIONS
go. %% finish with true


go2 :- 
      model_2(L),
      busca(L),
      print_list_by_array(L),
      fail. %% for ALL SOLUTIONS
go2. %% finish with true
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Model
model(Vars):-
	Vars=[A,B,C,D],
	Vars #:: [0..1], 
	(#\+A #\/  #\+ B  #\/ #\+C ) , %% (not A or not B or not C) AND (.....) AND ....
    (A #\/ #\+B #\/   #\+D) ,
    (B #\/ C #\/  D) ,
    (#\+ B #\/  #\+C #\/ D)
     . %% END DA 3-CNF

%%% OR-EXCLUSIVE
model_2(Vars):-
	Vars=[A,B],
	Vars #:: [0..1], 
	(A  #\/ B) , 
    #\+( A #/\ B).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Explore
busca(L_Search) :-	
    search(L_Search, 0, anti_first_fail , indomain , complete,[]).
%   search(L_Search, 0, input_order , indomain , complete,[]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Print out
print_list_by_array(L_all):- 
   nl,
%% writeln( l_all  : L_all),
   list2array(L_all, Vetor),
   	dim(Vetor,[L]), 
	(for( I , 1 , L ),
	 param( Vetor  )
	 do
       (
	     XX_truque is Vetor[I], 
	     printf(" Vetor[%d]: %d " , [I, XX_truque]) 
        ) 
      ).
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AUXs
list2array(L,A) :-
                length(L, Size),
                dim(A,[Size]),
                (foreacharg(X,A),
		        foreach(X,L) do true). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AUXs
/*

[eclipse 7]: go.

 Vetor[1]: 0  Vetor[2]: 0  Vetor[3]: 0  Vetor[4]: 1 
 Vetor[1]: 0  Vetor[2]: 0  Vetor[3]: 1  Vetor[4]: 0 
 Vetor[1]: 0  Vetor[2]:[eclipse 4]: go.
lists.eco  loaded in 0.01 seconds

 Vetor[1]: 0  Vetor[2]: 0  Vetor[3]: 0  Vetor[4]: 1 
 Vetor[1]: 0  Vetor[2]: 0  Vetor[3]: 1  Vetor[4]: 0 
 Vetor[1]: 0  Vetor[2]: 0  Vetor[3]: 1  Vetor[4]: 1 
 Vetor[1]: 0  Vetor[2]: 1  Vetor[3]: 0  Vetor[4]: 0 
 Vetor[1]: 1  Vetor[2]: 0  Vetor[3]: 0  Vetor[4]: 1 
 Vetor[1]: 1  Vetor[2]: 0  Vetor[3]: 1  Vetor[4]: 0 
 Vetor[1]: 1  Vetor[2]: 0  Vetor[3]: 1  Vetor[4]: 1 
 Vetor[1]: 1  Vetor[2]: 1  Vetor[3]: 0  Vetor[4]: 0 
 Vetor[1]: 1  Vetor[2]: 1  Vetor[3]: 0  Vetor[4]: 1 
Yes (0.01s cpu)
[eclipse 5]: ['cnf-sat.ecl'].
cnf-sat.ecl compiled 9288 bytes in 0.02 seconds

Yes (0.02s cpu)
[eclipse 6]: go.

 Vetor[1]: 0  Vetor[2]: 1 
 Vetor[1]: 1  Vetor[2]: 0 
Yes (0.00s cpu)
*/
