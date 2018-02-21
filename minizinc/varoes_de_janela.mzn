
/*
Problema dos VAROES DE CORTINAS DE JANELAS
Criado por CCS
Resolvido por CCS em dez/2015

Tem-se N varoes (paus que suportam a cortina) de medidas diversas
Tem-se M janelas  de medidas diversas, que precisam
ser cobertas pelos N varoes.
Os varões precisam ou podem ser cortados se necessários.
Objetivo: Minimizar o número de cortes e/ou
Maximimizar o maior numero de varoes sem cortes
(conflitantes)

Solucao como saida MATRIX ( m x n)

Varoes  ---> 1    ............   n
Uso dos 
varoes (1/0)  ---> 1/0 ............... 1/0 ... usado ou nao
Jan 1   --->  0/1(houve corte) .........  0/1(houve corte)
isto é 0 Nao foi selecionada ou nao precisou de corte num ponto do varao j
...............................................................
..................................................................
Jan m   --->  0/corte .........  0/corte
isto é 0 Nao foi selecionada ou nao precisou de corte no ponto  do varao j
..................................................................

Logo, uma saida matricial indicando quais os varoes serao cortados
e onde cada um serah cortado: 1 -> corte, onde?
Janela  1 i ateh M
Varaà   1 i ateh N
*/

%include "alldifferent.mzn";

%% FENCE  ... mas n itens a serem escolhidos e repetidos
int: n = 3; %% sides of polygon
int: m = 3 ; %% fences availble

array[1..n] of int : varoes; %% availble or allowed  COLUNAS
array[1..m] of int : janelas; %% to be covered  LINHAS

varoes =  [4, 5, 4];
janelas = [2, 3, 3];

array[1..m , 1..n] of var 0..1 : x_solution;
array[1..m] of var 0..1 : x_QUAIS_VAROES_USADOS;
var   int:  num_varoes_usados;


constraint
%% todas as janelas deverao ser selecionadas = todas linha = 1
%% em todas colunas
       forall(i in 1..m )(
          sum( j in 1..n ) (x_solution[i,j]) == 1
          );


constraint
%% a soma de todas as janelas cobertas pelo varoes j
%% devem somar no maximo o tamanho do varoes
%% ou seja, a soma de cada COLUNA em todas janelas selecionadas
%% devem ser menor ou igual ao tamanho do varoes

  forall(j in 1..n )(
     (sum( i in 1..m ) (x_solution[i,j] * janelas[i] )) <= varoes[j]
     );


constraint
%%% construindo a funcao minimizadora em QUAIS sao os VAROES USADOS
  forall(j in 1..n )(
     if 
       (sum( i in 1..m ) (x_solution[i,j])) >= 1
       then
       x_QUAIS_VAROES_USADOS[j]==1
       else
       x_QUAIS_VAROES_USADOS[j]==0
       endif
     );

constraint
%%% construindo a funcao minimizadora em NUM DE VAROES USADOS
    num_varoes_usados = sum( j in 1..m ) (x_QUAIS_VAROES_USADOS[j])
    ;

solve minimize num_varoes_usados;
%solve  satisfy;
%solve maximize total_VALOR;

output["Sticks Availbles: " ++ show( varoes ) ++ "\n" ++
       "Windows Sizes: " ++ show( janelas ) ++"\n" ++
       "X_decision from fences array: " ++ show( x_solution ) 
       ++"\n"++
       "Varoes DECISION: " ++ show( x_QUAIS_VAROES_USADOS ) 
       ++ "\n" ++   
       "num_varoes_usados: " ++ show( num_varoes_usados ) 
       ++ "\n"    
       ] ++
       ["\n  :"] ++
       [" " ++ show(j) |  j in 1..n] 
       ++ ["\n"] ++
       [if j == 1 then show(i) ++ " : " else "" endif ++
        show( x_solution[i,j] ) 
        ++ 
        if j = n then " .... janela " ++ show(i)++ "\n" else " " endif
        | i in 1..m, j in 1..n
       ] ++
       [" \n "] ;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%
/*
OK
Finished in 740msec
Compiling curtain_cut.mzn
Running curtain_cut.mzn
Sticks Availbles: [4, 5, 4]
Windows Sizes: [2, 3, 3]
X_decision from fences array: [0, 1, 0, 0, 1, 0, 1, 0, 0]
Varoes DECISION: [1, 1, 0]
num_varoes_usados: 2

  : 1 2 3
1 : 0 1 0 .... janela 1
2 : 0 1 0 .... janela 2
3 : 1 0 0 .... janela 3
 
 
----------
==========
*/