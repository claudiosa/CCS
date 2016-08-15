include "alldifferent.mzn";
%% GOLOMB mas n itens a serem escolhidos e repetidos
int: n = 3;  %% NUM de PEDACOS
int: m = 6 ; %% TAMANHO 0 .. 6

array[1..n] of var 0..m : regua; %% TAMANHO dos PEDACOS
array[1..(n+1)] of var 0..m : regua_SAIDA; %% APENAS para OUT

constraint  %% pedacos maior que 0
    forall(i in 1 .. n) ( regua[i] > 0 );       

%% Diferentes PEDACOS/medidas entre si
constraint 
  alldifferent ( regua  );

%% Diferentes medidas/PEDACOS entre TODOS os CORTES
constraint
    forall(i in 1 .. n-2 ) ( 
      forall(j in i+1 .. n ) (regua[ i ] != regua[ j ]) );

constraint  %% CRITERIO DE REGUA OTIMA 
       sum([regua[i] | i in 1..n] ) == m;       

constraint %% formatando uma saida
    regua_SAIDA[1] == 0 /\ 
    forall(i in 1 .. n)  ( 
    regua_SAIDA[i+1] == regua_SAIDA[i] + regua[i]
    );

% minimize ou maximize ALGO
solve  satisfy;

output 
[" Tamanho dos cortes: "]++[show(regua[i])++" | "|i in 1 .. n]++
[" A REGUA: "]++[show(regua_SAIDA[j] ) ++" | " | j in 1 .. n+1 ];
 