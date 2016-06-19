%  Jogos Olı́mpicos à Vista
% Com as proximidades dos Jogos Olı́mpicos temos a dificuldade dos capitães escolherem os
% atletas de uma dada modalidade. Assim cada capitão (m) terá que escolher um valor k de
% atletas de seu plantel, que contém n atletas a serem escolhidos.
% Assim, cada capitão deve ter o seu próprio time, tendo dado uma nota sobre o rendimento
% de cada atleta. Logo, cada técnico deve escolher k atletas, onde no máximo podem diferir
% por um atleta.
% Por exemplo, se tivermos 10 atletas e 3 técnicos, um time pode conter 4 atletas e dois
% outros com 3 atletas. Não é possı́vel um time com 5, um com 4 e outro com 3.
% Assim, admita a seguinte estrutura de dados:
% n = <number of athletes>;
% m = <number of captains>;
% array[1..m,1..n] of int: nota;
% %nota[c,p] eh o valor/nota dada pelo capitao c para o atleta p
% Voce deve encontrar um valor máximo como objetivo para uma dada distribuição entre
% entre os n atletas para os m capitães. Observe que o plantel é único. Veja o exemplo abaixo:
% n = 10;
% m = 3;
% nota = [| 4, 5, 6, 7, 2, 1, 0, 4, 5, 6
% | 0, 5, 8, 7, 3, 2, 1, 5, 4, 7
% | 5, 4, 5, 6, 3, 1, 0, 4, 6, 4 |];
% Veja, o coitado do atleta 7 está mal cotado pelos técnicos 1 e 3, tomou um zero por ambos
% os técnicos! Provavelmente, este coitado não deve ser selecionado pelo por estes dois técnicos.
% Já os atletas 3 e 4 estão bem cotados por todos os técnicos, com boas notas.
% Assim, a saı́da para este caso é dada por:
% obj = 48;
% times = [3, 1, 2, 1, 3, 2, 2, 2, 3, 1];
% Explicando: onde o time 1 (técnico 1) ficou com os seguintes atletas: {2, 4, 10}. Quanto
% ao time 2 (do técnico 2) ficou com os seguintes atletas: {3, 6, 7, 8}. O infeliz do atleta 7 ficou
% mesmo no time 2. Finalmente, o o time 3 (técnico 3) ficou com os seguintes atletas: {1, 5, 9}.
% Ou seja, a saı́da acima é reflexiva aos n atletas onde cada posição indica o atleta em questão.
% Claro, que nenhum atleta pode ser selecionado por dois técnicos simultaneamente.

%%include "alldifferent.mzn";

int : n = 10; %% jogadores
int : m = 3;  %% tecnicos 
array[1..m, 1..n] of int:  notas;
%%% NOTAS DOS TECNICOS 
notas = 
    [| 4, 5, 6, 7, 2, 1, 0, 4, 5, 6      %% T1
     | 0, 5, 8, 7, 3, 2, 1, 5, 4, 7      %% T2
     | 5, 4, 5, 6, 3, 1, 0, 4, 6, 4      %% T3
     |];

%% De cada um dos N jogadores serah selecionado por um dos M tecnicos
array[ 1 .. n ] of var 1..m : Dec_Matrix;

%% M times ...de 1 ate n jogadores .... todos em um time so
array[ 1 .. m ] of var 1..n : sizes; %%% Vini e Renan
 %% NOTAS PARCIAIS DOS TIMES
array[ 1 .. m ] of var int : Sum_of_Teams;

%%% Funcao objetivo ::: faca o desenho
var int: result ;  


%%% Calcula o tamanho de cada time ... 
constraint  
 forall(i in 1..m) ( 
%  sizes[i]  =  sum(j in 1..n) (Dec_Matrix[j] == i) EQUIVALENTE A
   sizes[i]  =  sum([bool2int(Dec_Matrix[j] == i) | j in 1..n] ) 
       );

% Garante que a diferenca maxima eh 1 entre o tamanho das equipes em O(n^2)
%% By Renan and Vini 
constraint
    forall (i , j in 1..m) (
        abs (sizes[i] - sizes[j])  <= 1
    );
%% todos com todos ... pode ser melhorado...

%%% parciais dos coaches/tecnicos ... AINDA eficiente  ... tem que relacionar SIZE
constraint
    forall( i in 1 .. m ) (
  % Sum_of_Teams[i] = sum([notas[Dec_Matrix[j], j] | j in 1 .. n where Dec_Matrix[j] == i])  %%% Equivalente a
  Sum_of_Teams[i] = sum([notas[Dec_Matrix[j], j] * bool2int(Dec_Matrix[j] == i) | j in 1..n])
  );

%% objetivo
constraint
     result = sum(i in 1..m) (Sum_of_Teams[i]) ;


% SELECT_VAR e DOMAIN_VAR sao modificados por um script black_magic.sh
%solve :: int_search(Dec_Matrix, SELECT_VAR, DOMAIN_VAR, complete) maximize result;

solve  maximize result;

output 
  [
  "Best: " ++ show(result) ++ " \t Sizes: " ++ show(sizes) ++
  "\t Times: "++ show(fix(Dec_Matrix)) 
  %% ++ "\t Parcial: " ++ show(fix(Sum_of_Teams)) %%% DEMORANDO WHY ????
  ] ++ 
   ["\n"] ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%