/*
\item [Latin Square Problem]
The Latin Square Problem aims at colouring each of the 
positions of an $N \times N$ square board with $N$ 
distinct colours such that no two 
positions in the same row or in the same columns
have the same colour. Model the problem, and analyse the 
efficiency of its execution, for several values of $N$, using:

\begin{enumerate}
%\item Binary disequality constraints ($\=$) alone;
\item Restrição de desigualdade binária: $!=$ 
(arco de consistência local), e 
\item  With global constraint \texttt{all\_different}.
\end{enumerate}
*/


include "globals.mzn";
include "alldifferent.mzn";

int: n = 5;

array[1..n, 1..n] of var 1..n: quadrado;

constraint
    forall(i in 1..n, j in 1..n) (
      alldifferent([quadrado[i,j] | i in 1..n]) /\
      alldifferent([quadrado[i,j] | j in 1..n])
    );

%%% ATTENTION HERE
solve:: int_search([quadrado[i,j] | i,j in 1..n], first_fail, indomain_min, complete) satisfy;

%solve satisfy;

output[ if j = 1 then "\n" else " " endif ++ 
        show(quadrado[i,j])| i,j in 1..n] ++ ["\n"];

/*******************************************************
Finished in 44msec
Compiling latin_square.mzn
Running latin_square.mzn

1 2 3 4 5
2 5 1 3 4
3 1 4 5 2
4 3 5 2 1
5 4 2 1 3
----------
Finished in 20msec
********************************************************/
