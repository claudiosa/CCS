/* Ex 1 - Linguas e interpretes */
/* ALGUNS EXEMPLOS .... SEM COMENTARIOS */

include "globals.mzn";
int: n;
n  = 10; %% total de elementos: linguas e interpretes

array[1..n, 1..n] of int: m;
%vetor de decisao
array[1..n] of var 0..1 : x_decision;

m = array2d(1..n, 1..n,
  [
     1, 1, 0, 0, 0, 0, 0, 1, 0, 1,
     0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 1, 1, 0, 1, 0, 0, 0, 0,
     0, 0, 0, 1, 1, 0, 1, 0, 1, 0,
     1, 0, 0, 1, 0, 1, 0, 1, 1, 0,
     0, 0, 0, 1, 0, 0, 1, 0, 1, 0,
     1, 0, 0, 1, 0, 0, 0, 1, 1, 0,
     1, 1, 0, 1, 1, 0, 1, 0, 0, 1,
     0, 0, 0, 1, 0, 0, 1, 0, 0, 1,
     0, 1, 0, 1, 1, 1, 0, 0, 1, 0,
  ]
);

constraint
  forall(j in 1..n)(
    sum(i in 1..n) (x_decision[i]*m[i,j]) >= 1  
  )
;

solve satisfy;

output [
  "total minimo de interpretes: " ++ show(x_decision) ++"\n"
    ];

/* Saidas:
total minimo de interpretes: [0, 1, 1, 1, 0, 0, 1, 0, 1, 0]
----------
total minimo de interpretes: [0, 1, 1, 1, 0, 1, 1, 0, 1, 0]
----------
total minimo de interpretes: [1, 0, 1, 1, 0, 0, 0, 0, 0, 0]
----------
total minimo de interpretes: [1, 0, 1, 1, 0, 1, 0, 0, 0, 0]
----------
total minimo de interpretes: [1, 1, 1, 1, 0, 0, 0, 0, 0, 0]
----------
*/

/* Ex 2 - Postos de bombeiros */

include "globals.mzn"; 
% numero de vizinhancas
int: j = 11;
% vetor de decisao
array[1..j] of var 0..1: x;  

constraint x[1] + x[2] + x[3] + x[4] >= 1; 
constraint x[1] + x[2] + x[3] + x[5] >= 1; 
constraint x[1] + x[2] + x[3] + x[4] + x[5] + x[6] >= 1; 
constraint x[1] + x[3] + x[4] + x[6] + x[7] >= 1; 
constraint x[2] + x[3] + x[5] + x[6] + x[8] + x[9] >= 1; 
constraint x[3] + x[4] + x[5] + x[6] + x[7] + x[8] >= 1; 
constraint x[4] + x[6] + x[7] + x[8] >= 1; 
constraint x[5] + x[6] + x[7] + x[8] + x[9] + x[10] >= 1; 
constraint x[5] + x[8] + x[9] + x[10] + x[11] >= 1; 
constraint x[8] + x[9] + x[10] + x[11] >= 1; 
constraint x[9] + x[10] + x[11] >= 1; 

% minimize postos de bombeiros
solve minimize  sum( [x[i] | i in 1..j] ); 

output [ 
  "postos de bombeiros cobrindo a vizinhanca: " ++  show(x) ++ "\n"
];

/* Saidas:
postos de bombeiros cobrindo a vizinhanca: [0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0]
----------
*/

/* Ex 3 - Emparelhamento */
include "globals.mzn"; 
int: n;
n = 6;
var int: A; var int: B; var int: C; var int: D; var int: E; var int: F;

array[1..n] of var 1..n: S;
%var int: total_arestas;

constraint all_different([A,B,C,D,E,F]);
constraint element(A, [1,0,1,0,0,0], S[1]);
constraint element(B, [0,1,0,1,0,0], S[2]);
constraint element(C, [1,0,0,1,0,0], S[3]);
constraint element(D, [0,0,1,0,1,0], S[4]);
constraint element(E, [0,0,0,0,1,1], S[5]);
constraint element(F, [1,0,0,0,1,1], S[6]);


%total_arestas = S[1]+S[2]+S[3]+S[4]+S[5]+S[6];

solve satisfy;

output [
  %"total minimo de arestas: " ++ show(total_arestas) ++ "\n" ++
    "S: " ++ show(S) ++ "\n" ++
"indices: " ++ show(A) ++ "-" ++ show(B) ++ "-" ++ show(C) ++ "-"++ show(D) ++ "-" ++ show(E) ++ "-"++show(F)
];

/* Saidas:
S: [1, 1, 1, 1, 1, 1]
indices: 1-2-4-3-5-6
----------
S: [1, 1, 1, 1, 1, 1]
indices: 1-2-4-3-6-5
----------
S: [1, 1, 1, 1, 1, 1]
indices: 3-2-4-5-6-1
----------
*/


/* Ex 5 - Tias excentricas */

include "globals.mzn"; 
int: n = 5; % quantidade de tias

array[1..n] of var 1..5: tia; %1-Hortencia 2-Eugenia 3-Honoria 4-Leticia 5-?
array[1..n] of var 70..79: idade;
array[1..n] of var 1..5: habito; % 1-tequila 2-cachimbo 3-vodka 4-ovos 5-?
array[1..n] of var 1..5: hobby; % 1-colec lata 2-programacao 3-musculacao 4-pesca 5-cria piranhas

constraint alldifferent(tia);
constraint alldifferent(hobby);
constraint alldifferent(habito);

%premissa 1 - Hortensia, que bebe tequila, eh dois anos mais velha 
%que a tia que coleciona latas de cerveja. 
constraint 
  exists(i in 1..n)(idade[1] = idade[hobby[i]] + 2) /\
  habito[1] = 1;
%premissa 2 - A tia que resolve problemas de logica, enquanto treina para maratona 
%das Olimpiadas de Londres, nao eh Eugenia.
constraint 
  exists(i in 1..n)(hobby[tia[i]] != 2);
%premissa 3 - A tia Honoria, que tem 74 anos, nao fuma cachimbo.
%premissa 6 - A tia que bebe vodka nao eh a Honoria.
constraint 
  idade[3] = 74 /\ habito[3] != 2 /\ habito[3] != 3;
%premissa 4 - A tia Leticia, que cria piranhas, nao eh a tia mais velha de Xexeu.
constraint 
  hobby[4] = 5 /\ idade[4] < ub_array(idade);
%premissa 5 - A tia que come dois ovos crus por dia, 
%eh dois anos mais nova que a tia que levanta pesos.
constraint 
  exists(i in 1..n,j in 1..n)(idade[habito[i]] = idade[hobby[j]] - 2);
%premissa 7 - A tia que pesca tilapia tem 77 anos.
constraint 
  exists(i in 1..n)(idade[hobby[i]] = 77);

solve satisfy;

output [
  "tia: " ++ show(tia) ++"\n" ++
  "idade: " ++ show(idade) ++"\n" ++
  "habito: " ++ show(habito) ++"\n" ++
  "hobby: " ++ show(hobby) ++"\n"
];

/* Saidas:
tia: [4, 5, 3, 2, 1]
idade: [72, 70, 74, 77, 70]
habito: [1, 4, 5, 3, 2]
hobby: [1, 4, 3, 5, 2]
----------
tia: [5, 4, 3, 2, 1]
idade: [72, 70, 74, 77, 70]
habito: [1, 4, 5, 3, 2]
hobby: [1, 4, 3, 5, 2]
----------
tia: [3, 5, 4, 2, 1]
idade: [72, 70, 74, 77, 70]
habito: [1, 4, 5, 3, 2]
hobby: [1, 4, 3, 5, 2]
----------
tia: [5, 3, 4, 2, 1]
idade: [72, 70, 74, 77, 70]
habito: [1, 4, 5, 3, 2]
hobby: [1, 4, 3, 5, 2]
----------
tia: [4, 3, 5, 2, 1]
idade: [72, 70, 74, 77, 70]
habito: [1, 4, 5, 3, 2]
hobby: [1, 4, 3, 5, 2]
----------

*/
