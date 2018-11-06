\begin{verbatim}
/* Labirinto */

x_maze :- path([entrada],Solucao), 
          reverse(Solucao,Sol_invertida), 
         /* reverse :: predicado interno */
		 write(Sol_invertida).

path([OldSpot|RestOfPath],Solution) :-
     connected_to(NewSpot,OldSpot),
     \+ member(NewSpot,RestOfPath), /* interno ao SWI */
     check_path([NewSpot,OldSpot|RestOfPath],Solution).

check_path([saida| Resto ],[saida| Resto ]).
check_path(Path,Solution):- path(Path,Solution).

connected_to(A,B) :- liga(A,B).
connected_to(A,B) :- liga(B,A).

/******************************
 * Conectividade do labirinto *
 ********************************/
liga(entrada,7).        liga(1,7).  liga(1,2).
liga(2,3).             liga(3,9).   liga(9,15).
liga(7,8).            liga(8,9).
liga(8,14).           liga(14,20).
liga(20,19).           liga(20,21).
liga(15,21).          liga(21,22).
liga(22,16).          liga(16,10).
liga(10,11).          liga(11,12).
liga(12,6).          liga(6,5).
liga(5,4).          liga(18,12).
liga(18,17).          liga(17,23).
liga(23,saida).        liga(18, saida).

/* para esata conectividade ... eis a resposta
?- x_maze.
[entrada, 7, 1, 2, 3, 9, 8, 14, 20, 21, 22, 16, 10, 11, 12, 18, 17, 23, saida]
Yes
?- 
\end{verbatim}
