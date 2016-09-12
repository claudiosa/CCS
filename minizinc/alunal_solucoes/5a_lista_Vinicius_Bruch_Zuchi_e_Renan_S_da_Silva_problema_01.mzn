/*
1 Será que Ele Avança?

Ranoberto e Ranubia são duas alegres rãs adolescentes que moram às margens do rio Cubatão,
na Serra Dona Francisca. Ranoberto observou as longas pernas saltadoras de Ranubia e
decidiu que quer conhecê-la melhor. Como ele é um pouco tı́mido e não sabe bem como
iniciar a conversa, pensou em convidá-la para um jogo divertido, o que pode facilitar esta
paquera. Ranubia gostou do estilo dele e aceitou o convite.

O jogo chama-se “Rã Saltadora”: a partir de posições iniciais eles vão saltar um sobre o
outro alternadamente. Ambos, Ranoberto e Ranubia, são capazes de saltar há uma distância
horizontal máxima de até 10 unidades, em cada salto simples.

Você recebeu uma lista de posições válidas onde Ranoberto e Ranubia podem se posicionar:
x 1 x 2 ...x n . Como Ranoberto é um cavalheiro deixará para Ranubia o primeiro salto. Ranubia
começa inicialmente na posição x 1 e Ranoberto começa inicialmente na posição x 2 ; o objetivo
deles é alcançar a posição x n . Determine o número mı́nimo de saltos necessários para que
cada um, Ranoberto ou Ranubia, alcance o objetivo. Aos dois jogadores não é permitido
permanecer na mesma posição ao mesmo tempo (afinal, eles ainda estão se conhecendo...), e
em cada salto, o jogador que estiver atrás deve pular por cima do jogador à frente.

Entrada
O arquivo de entrada contém múltiplos casos de teste. Cada linha é um caso de teste e contém
uma lista de inteiros x 1 x 2 ... x n , onde 0 ≤ x 1 < x 2 ... < x n ≤ 1000000 (aqui era o problema
original).

Saı́da
Para cada caso de teste de entrada, imprima o número total de saltos mı́nimo necessários
para que um dos jogadores, ou Ranoberto ou Ranubia, chegue ao destino. Caso nenhum
possa alcançar o destino, imprima -1.
*/

int : N; % Tamanho do array de posições válidas

array[1..N] of int : values; %  array de posições válidas

array[1..N] of var 0..1 : frog1; % array de variáveis de decisão da rã 1

array[1..N] of var 0..1 : frog2; % array de variáveis de decisão da rã 2

var 1..N : result; % Variável que armazenará a quantidade mínima de pulos necessários

constraint assert (forall (i in 2..N) (values[i] - values[i-1] <= 10), "-1"); % execução do algoritmo para caso seja impossível chegar à posição final

constraint frog1[1] == 1 /\
           frog2[2] == 1; % posições iniciais de cada sapo

constraint frog1[N] = 1 \/
           frog2[N] = 1; % Garantindo que pelo menos um dos dois chegará ao final

% As duas restrições abaixo impedem que as rãs pulem mais do que 10 unidades para a frente, cada restrição é para uma rã diferente
constraint forall (i,j in 1..N where frog1[i] == 1 /\ frog1[j] == 1 /\ j > i /\ sum (k in i..j) (frog1[k]) == 2) (values[j] - values[i] <= 10);
constraint forall (i,j in 1..N where frog2[i] == 1 /\ frog2[j] == 1 /\ j > i /\ sum (k in i..j) (frog2[k]) == 2) (values[j] - values[i] <= 10);

constraint forall (i in 1..N where frog1[i] == 1) (frog2[i] = 0); % Garantindo que as rãs não irão 
constraint forall (i in 1..N where frog2[i] == 1) (frog1[i] = 0); % pular na mesma posição

constraint abs (sum (i in 1..N) (frog1[i]) - sum (i in 1..N) (frog2[i])) <= 1; % Essa restrição garante que nenhuma das duas rãs ficará sem pular

% O resultado será o valor mínimo de qualquer uma das rãs que tenha conseguido chegar ao final primeiro
constraint result = max (sum (i in 1..N where frog1[i] == 1) (frog1[i]) , sum (i in 1..N where frog2[i] == 1) (frog2[i]) );

solve minimize result;

output [show(frog1),"\n",show(frog2),"\n",show(result - 1)];

/* output:

Entrada 1:
N = 6;

values = [3,5,9,12,15,17];

Saída 1: 
[1, 0, 1, 0, 0, 1]
[0, 1, 0, 0, 1, 0]
2
----------
==========

Entrada 2: 
N = 6;

values = [3,5,9,12,30,40];

Saída 2:
5a_lista_Vinicius_Bruch_Zuchi_e_Renan_S_da_Silva_problema_01/5a_lista_Vinicius_Bruch_Zuchi_e_Renan_S_da_Silva_problema_01.mzn:43:
  in call 'assert'
  Assertion failed: 
-1

Entrada 3:
N = 2;

values = [3,5];

Saída 3:
[1, 0]
[0, 1]
0
----------
==========

Entrada 4:
N = 7;

values = [0,1,7,8,11,15,19];

Saída 4:
[1, 0, 1, 0, 0, 0, 0]
[0, 1, 0, 0, 1, 0, 1]
2
----------
==========

Entrada 5:
N = 6;

values = [0,1,10,11,19,20];

Saída 5:
[1, 0, 1, 0, 0, 1]
[0, 1, 0, 1, 0, 0]
2
----------
==========

Entrada 6:
N = 6;

values = [0,1,10,12,19,20];

Saída 6:
=====UNSATISFIABLE=====

*/