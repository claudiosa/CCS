% 3 Jogos Olı́mpicos à Vista
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



int : n = 10;
int : m = 3;
array[1..m, 1..n] of int:  value;
%%% NOTAS DOS TECNICOS 
 value = 
    [| 4, 5, 6, 7, 2, 1, 0, 4, 5, 6      %% T1
     | 0, 5, 8, 7, 3, 2, 1, 5, 4, 7      %% T2
     | 5, 4, 5, 6, 3, 1, 0, 4, 6, 4      %% T3
     |];






array[      1..n] of var 1..m : times;
array[1..m      ] of var 1..n : sizes;
var int: result;

% Calcula o tamanho de cada time
constraint
    forall (i in 1..m) (
        sizes[i] = sum (j in 1..n where times[j] == i) (1)
    );

% Garante q a diferenca maxima eh 1 entre o tamanho das equipes em O(n^2)
constraint
    forall (i, j in 1..m) (
        abs (
            sizes[i] - sizes[j]
        ) <= 1
    );

% FUncao objetivo
constraint
    result = sum (j in 1..n) (value[times[j], j]);

% SELECT_VAR e DOMAIN_VAR sao modificados por um script black_magic.sh
%solve :: int_search(times, SELECT_VAR, DOMAIN_VAR, complete) maximize result;
solve  maximize result;
output [
    show(sizes) ++ " " ++ show(times) ++ " " ++ show(result)
];

% A saida esta nos arquivos
%   teamagain1_times.log
%   teamagain2_times.log
%   teamagain3_times.log
%   teamagain4_times.log
