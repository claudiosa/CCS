:- lib(ic).
%%% :- lib(branch_and_bound).
%% a) interadores atuam sobre listas e estruturas
%% b) alternativa a recursao
%% c) em geral tornam pgms mais simples
%% d) 


t1 :-
	(fromto( [1,3,5,7], [ C | Resto ], Resto, [ ] ) 
	  do
	   		printf("  %d       " , [C] ), %% apenas VAR simples
	   		writeln( Resto ) 
	   		%% na ultima linha nao vai ","
    ). 

/*
 1       [3, 5, 7]
 3       [5, 7]
 5       [7]
 7       []
*/


t2 :-
	(fromto( [], Resto ,  [ C | Resto ], [1,3,5,7] ) , 
	  foreach(Aux, Lista)
	  do
		    Aux = C , 
	   		writeln( Resto ) 
   ),
     writeln( lista: Lista ) . 
     
     
inv_L(Lista,Inv) :-
   (fromto( [], Resto ,  [ C | Resto ], Inv ) , 
	  foreach(Aux, Lista)
	  do
		   %% C is Aux
		   %%  OU
		   C = Aux
    ),
     writeln( lista: Lista ),
     writeln( invertida: Inv ) . 

/*
inv_L([1,3,5,7],X)   
lista : [1, 3, 5, 7]
invertida : [7, 5, 3, 1]
*/
