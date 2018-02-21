:- lib(ic).

solucao:-
     fab( [A:T1,B:T2,C:T3] ), nl,
    ( 
        count( T, 1, 3),
    
        foreach(X:Y , [A:T1,B:T2,C:T3]) do
            printf("\n Trabalhador %w esta na tarefa/tipo: %w custo: %w", [T, X,Y])
    ), 
  
    Total is (T1 + T2 + T3),
    printf("\n Total: %w", [Total]).

fab( [A:T1,B:T2,C:T3] ) :-
	member( A:T1, [ 1:5, 2:1, 3:3, 4:4, 5:6] ),
	member( B:T2, [ 1:8, 2:8, 3:5, 4:7, 5:3] ),
	member( C:T3, [ 1:4, 2:9, 3:1, 4:5, 5:2] ),
    T1 + T2 + T3 #> 15,
	alldifferent([A,B,C]),
	labeling( [A, T1, B, T2, C, T3] ).
