:- lib(ic).
:- lib(branch_and_bound).

quartel :-
	modelo( [A,B,C,D,E,F] ) ,
   	printf("\n     %d   " , [ D ] ),
	printf("\n %d        %d" , [C, E] ),
	printf("\n %d        %d" , [B, F] ),
	printf("\n     %d \n  " , [ A ] ). 


/*        Estrela de Davi 
     D
C         E

B         F
     A
*/


modelo([A,B,C,D,E,F]) :-
	Variaveis = [A,B,C,D,E,F] ,  
	%% Variaveis ins 1..6 , 
	Variaveis :: [1..4],
	%%D #>= 2,             %%% quebrando uma simetria
	A + B #>= 3,
	A + F #>= 3,
	B + C #>= 3,
	C + D #>= 3,
	D + E #>= 3,
	E + F #>= 3,
	A+B+C+D+E+F #= FUNCAO_CUSTO,
	minimize(labeling(Variaveis), FUNCAO_CUSTO).
	%%labeling(Variaveis).

/*

     3   
 1        1
 3        3
     1  
     
     2   
 2        2
 2        2
     2 

%%% com MINIMIZACAO
Found a solution with cost 9
Found no solution with cost 6.0 .. 8.0

     2   
 1        1
 2        2
     1 

*/     
