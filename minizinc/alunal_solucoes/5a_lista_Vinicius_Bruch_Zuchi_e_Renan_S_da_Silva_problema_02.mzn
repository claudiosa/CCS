/* Consider the crossword puzzle:

        +---+---+---+---+
1       | 1 | 2 |   |   |
        +---+---+---+---+
2       | 3 |   |
    +---+---+---+---+---+
3   | 4 |   |   | 5 |   |
    +---+---+---+---+---+
4       |   | # |   |
        +---+---+---+---+
5       | 6 |   |   |   |
        +---+---+---+---+
6               |   |
                +---+
7               |   |
                +---+

The available words that can be used are:
at, eta, be, hat, he, her, it, him, on, one, desk, dance, usage, easy, dove, first,
else, loses, fuels, help, haste, given, kind, sense, soon, sound, this, think.

1. Inicialmente dê uma solução para o problema acima, implemente e tenha as respostas.
*/

set of int: alphabet = 1..27;

% Simulação de um Enum
int: A = 1;
int: B = 2;
int: C = 3;
int: D = 4;
int: E = 5;
int: F = 6;
int: G = 7;
int: H = 8;
int: I = 9;
int: J = 10;
int: K = 11;
int: L = 12;
int: M = 13;
int: N = 14;
int: O = 15;
int: P = 16;
int: Q = 17;
int: R = 18;
int: S = 19;
int: T = 20;
int: U = 21;
int: V = 22;
int: W = 23;
int: X = 24;
int: Y = 25;
int: Z = 26;
int: NI = 27;

array[alphabet] of string: letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0"];

% As possíveis posições das palavras:
var 1..10 :   E1;
var 19..23:   E2;
var 24..28:   E3;
var 1..10 :   E4;
var 1..10 :   E5;
var 11..18:   E6;

% Inteiro que representa a quantidade de palavras
int: size = 28;

% Array de entradas, a primeira dimensão representa a quantidade de palavras disponíveis, a segunda dimensão representa
% o tamanho máximo de uma palavra.
array[1..size,1..5] of alphabet: a;

% 5 = 1..10

% As palavras propriamente ditas...
% As palavras de tamanho 5 estão nas posições de 1..10
            % de tamanho 4 estão nas posições de 11..18
            % de tamanho 3 estão nas posições de 19..23
            % de tamanho 2 estão nas posições de 24..28
a = array2d(1..size, 1..5, [
  D,A,N,C,E,
  U,S,A,G,E,
  F,I,R,S,T,
  L,O,S,E,S,
  F,U,E,L,S,
  H,A,S,T,E,
  G,I,V,E,N,
  S,E,N,S,E,
  S,O,U,N,D,
  T,H,I,N,K,
  D,E,S,K,NI,
  E,A,S,Y,NI,
  D,O,V,E,NI,
  E,L,S,E,NI,
  H,E,L,P,NI,
  K,I,N,D,NI,
  S,O,O,N,NI,
  T,H,I,S,NI,
  E,T,A,NI,NI,
  H,A,T,NI,NI,
  H,E,R,NI,NI,
  H,I,M,NI,NI,
  O,N,E,NI,NI,
  A,T,NI,NI,NI,
  B,E,NI,NI,NI,
  H,E,NI,NI,NI,
  I,T,NI,NI,NI,
  O,N,NI,NI,NI
]);

% Restrição para as posições onde as palavras se crusam
constraint 
  a[E1,2] = a[E3,1] /\
  a[E1,5] = a[E6,1] /\
  a[E1,3] = a[E4,2] /\

  a[E4,4] = a[E5,1] /\

  a[E6,3] = a[E5,3]
;
  
solve satisfy;

output [
      "E1: ", show(E1), " ", show([letters[a[E1,i]] | i in 1..5]), "\n",
      "E2: ", show(E2), " ", show([letters[a[E2,i]] | i in 1..5]), "\n",
      "E3: ", show(E3), " ", show([letters[a[E3,i]] | i in 1..5]), "\n",
      "E4: ", show(E4), " ", show([letters[a[E4,i]] | i in 1..5]), "\n",
      "E5: ", show(E5), " ", show([letters[a[E5,i]] | i in 1..5]), "\n",
      "E6: ", show(E6), " ", show([letters[a[E6,i]] | i in 1..5]), "\n",
] ++ ["\n"]
;

/* Output :

E1: 9 ["S", "O", "U", "N", "D"]
E2: 19 ["E", "T", "A", "0", "0"]
E3: 28 ["O", "N", "0", "0", "0"]
E4: 5 ["F", "U", "E", "L", "S"]
E5: 4 ["L", "O", "S", "E", "S"]
E6: 11 ["D", "E", "S", "K", "0"]

----------
E1: 9 ["S", "O", "U", "N", "D"]
E2: 20 ["H", "A", "T", "0", "0"]
E3: 28 ["O", "N", "0", "0", "0"]
E4: 5 ["F", "U", "E", "L", "S"]
E5: 4 ["L", "O", "S", "E", "S"]
E6: 11 ["D", "E", "S", "K", "0"]

----------
E1: 9 ["S", "O", "U", "N", "D"]
E2: 21 ["H", "E", "R", "0", "0"]
E3: 28 ["O", "N", "0", "0", "0"]
E4: 5 ["F", "U", "E", "L", "S"]
E5: 4 ["L", "O", "S", "E", "S"]
E6: 11 ["D", "E", "S", "K", "0"]

----------
E1: 9 ["S", "O", "U", "N", "D"]
E2: 22 ["H", "I", "M", "0", "0"]
E3: 28 ["O", "N", "0", "0", "0"]
E4: 5 ["F", "U", "E", "L", "S"]
E5: 4 ["L", "O", "S", "E", "S"]
E6: 11 ["D", "E", "S", "K", "0"]

----------
E1: 9 ["S", "O", "U", "N", "D"]
E2: 23 ["O", "N", "E", "0", "0"]
E3: 28 ["O", "N", "0", "0", "0"]
E4: 5 ["F", "U", "E", "L", "S"]
E5: 4 ["L", "O", "S", "E", "S"]
E6: 11 ["D", "E", "S", "K", "0"]

----------
E1: 10 ["T", "H", "I", "N", "K"]
E2: 19 ["E", "T", "A", "0", "0"]
E3: 26 ["H", "E", "0", "0", "0"]
E4: 3 ["F", "I", "R", "S", "T"]
E5: 8 ["S", "E", "N", "S", "E"]
E6: 16 ["K", "I", "N", "D", "0"]

----------
E1: 10 ["T", "H", "I", "N", "K"]
E2: 20 ["H", "A", "T", "0", "0"]
E3: 26 ["H", "E", "0", "0", "0"]
E4: 3 ["F", "I", "R", "S", "T"]
E5: 8 ["S", "E", "N", "S", "E"]
E6: 16 ["K", "I", "N", "D", "0"]

----------
E1: 10 ["T", "H", "I", "N", "K"]
E2: 21 ["H", "E", "R", "0", "0"]
E3: 26 ["H", "E", "0", "0", "0"]
E4: 3 ["F", "I", "R", "S", "T"]
E5: 8 ["S", "E", "N", "S", "E"]
E6: 16 ["K", "I", "N", "D", "0"]

----------
E1: 10 ["T", "H", "I", "N", "K"]
E2: 22 ["H", "I", "M", "0", "0"]
E3: 26 ["H", "E", "0", "0", "0"]
E4: 3 ["F", "I", "R", "S", "T"]
E5: 8 ["S", "E", "N", "S", "E"]
E6: 16 ["K", "I", "N", "D", "0"]

----------
E1: 10 ["T", "H", "I", "N", "K"]
E2: 23 ["O", "N", "E", "0", "0"]
E3: 26 ["H", "E", "0", "0", "0"]
E4: 3 ["F", "I", "R", "S", "T"]
E5: 8 ["S", "E", "N", "S", "E"]
E6: 16 ["K", "I", "N", "D", "0"]

----------
==========
%%  runtime:       0.000 (0.692 ms)
%%  solvetime:     0.000 (0.278 ms)
%%  solutions:     10
%%  variables:     11
%%  propagators:   10
%%  propagations:  109
%%  nodes:         21
%%  failures:      1
%%  restarts:      0
%%  peak depth:    5
Finished in 13msec

*/

