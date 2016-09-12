% 4 As Cadeiras no Cinema (nova versão)
% No cinema, todos sabem como é desagrádavel sentar atrás de uma pessoa mais que voce.
% Ou seja, ou voce tem que entortar a cabeça ou se levantar para assistir o filme. O primeiro
% cinema de Quixeramobim tinha apenas 40 lugares, em quatro fileiras de 10. Contudo, o
% pessoal esperto pensou: vamos colocar as fileiras desencontradas.
% Assim, o pessoal da fileira X1 vai ver o filme entre duas pessoas da fileira X2.
% Faça um programa que resolva este problema para essas quatro fileiras de 10 pessoas
% em cada uma. As alturas das pessoas seguem do domı́nio de 150 a 200 1 , medida em
% centı́metros.

include "alldifferent.mzn";

int: M = 4; % número de fileiras
int: N = 10; % tamanho de cada fileira

array[1..M,1..N] of var 150..200 : places; % matriz de lugares

constraint alldifferent ([places[i,j] | i in 1..M , j in 1..N where i == j]);

constraint alldifferent ([places[i,j] | i in 1..M , j in 1..N where i+j = N+1]);

constraint forall (i in 1..M) (alldifferent (row(places,i)));

constraint forall (i in 1..N) (alldifferent (col(places,i)));


constraint forall (i in 1..M-1, j in 1..N) (places[i,j] > places[i+1,j]); % Garantindo que as pessoas mais baixas sentarão sempre nas fileiras de baixo

constraint forall (i in 1..M, j in 2..N-1) (places[i,j] > places[i,j-1] \/ places[i,j] > places[i,j+1]); % Garantindo que as pessoas de tamanhos alternados sentem uma ao lado da outra

solve maximize sum (i in 1..M, j in 1..N) (places[i,j]);

output[show(places[i,j]) ++ if j == N then "\n" else " " endif | i in 1..M, j in 1..N];

/* output: (O programa demoraria demasiada quantidade de tempo para imprimir todas as soluções ou a solução ótima)

161 199 200 198 197 196 195 194 193 192
159 162 199 163 161 160 158 157 156 152
158 159 160 161 157 156 155 154 152 151
157 158 159 156 155 154 153 152 151 150

*/