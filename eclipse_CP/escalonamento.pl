% Data: 3/05/2008
:- use_module(library(clpfd)). 
 
%%:- use_module(library(simplex)). 

fab([A,B,C]) :-
		  Variaveis = [A,B,C],
		  Variaveis ins 1 .. 5, 
		  all_different(Variaveis),
		  tuples_in([[A, T1]],[[1, 5],[2,1],[3,3],[4,4],[5,6]]), 
		  tuples_in([[B, T2]], [[1,8], [2,8], [3,5], [4,7], [5,3]]),
		  tuples_in([[C, T3]],[[1,4],[2, 9], [3,1],[4, 5], [5,2]]),

		  %% T1 + T2 + T3 #>= 15, %% OK ou
		  sum([T1,T2,T3], #>=, 15).


parte_1([A,B,C]) :- fab([A,B,C]), labeling([ff],  [A,B,C]). %%%, nl, write([A,B,C]).
/*
?- parte_1(X).
X = [1, 3, 2] ;
X = [1, 4, 2] ;
X = [1, 5, 2] ;
X = [1, 2, 4] ;
*/

parte_2([A,B,C]) :-  
			Variaveis = [A,B,C],
			Variaveis ins 1 .. 5, 
			all_different(Variaveis),
			tuples_in([[A, T1]],[[1, 5],[2,1],[3,3],[4,4],[5,6]]), 
			tuples_in([[B, T2]], [[1,8], [2,8], [3,5], [4,7], [5,3]]),
			tuples_in([[C, T3]],[[1,4],[2, 9], [3,1],[4, 5], [5,2]]),

			%% T1 + T2 + T3 #>= 15, %% OK ou
			sum([T1,T2,T3], #>=, 15),
			labeling([max(T1 + T2 + T3)],  [A,B,C]). %%, nl, write([A,B,C]).
/*
?- parte_2(X).
X = [5, 1, 2] ;
X = [5, 4, 2] ;
X = [1, 4, 2] ;
.................
*/
