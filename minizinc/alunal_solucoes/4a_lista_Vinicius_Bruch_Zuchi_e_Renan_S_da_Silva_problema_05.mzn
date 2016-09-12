% A Calçada do Quiriri
% Basicamente repetir o exercı́cio do rio Quiriri (não resolvido completamente),
% mas simplificando- o para caminhar para frente na diagonal. Isto é sem volta!
% Exemplificando o problema, a partida ocorre em uma das células à esquerda,
% e a chegada em uma das células à direita. Veja o exemplo abaixo:
%
% 1  2  3  2  3 -2  3
% 4  5  6 -2  3  8  9
% 1  1  9  2  3  5  6
% 7  8  1 -2  3 -5  6
%
% • Utilizando uma matriz de decisão, imprima-a para ilustrar o zig-zag das
%   respostas.
% • Uma resposta bem feita é desejável.
% • Este problema é conhecido por cruzar a matriz em algum sentido.
% Os casos de testes, valem o do rio Quiriri, os quais se encontram em: https:
% //github.com/claudiosa/CCS/tree/master/list_of_assignments_FPR_course/data.

% M : numero de Colunas e N : numero de Linhas
include "globals.mzn";

% Tamanho da matriz
int: m;% = 5;
int: n;% = 5;

% matriz de custos
array[1..m,1..n] of int: value;% = [|9,9,7,6,7,
%                                   |0,6,1,3,8,
%                                   |8,6,4,2,3,
%                                   |2,4,1,1,4,
%                                   |0,0,1,1,2|];

% Caminho para a solucao, o numero na iesima posicao corresponde a coluna utilizada
array[1..n] of var 1..m: path;

% A diferenca entre dois itens consecutivos deve ser 1, fazendo com q ande em diagonal
constraint forall (i in 1..(n-1)) (abs(path[i]-path[i+1]) = 1);

% Minimizar a soma dos custos do caminho
% path[i] da a coluna para a iesima linha
solve minimize sum (i in 1..m) (value[i,path[i]]);

output[
"Custo: ", show(sum (i in 1..m) (value[i,path[i]])), "\nCaminho: ", show(path)
];

% Output 01:
% ----------
%Custo: 9
%Caminho: [2, 1, 2, 1, 2, 1, 2, 1, 2, 1]
%----------

% Output 02:
%----------
%Custo: 9
%Caminho: [2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1]
%----------  

% Output 03:
%----------
%Custo: 8
%Caminho: [6, 7, 6, 7, 6, 7, 6, 5, 4, 3, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2]
%----------

% Output 04:
%----------
%Custo: 14
%Caminho: [7, 6, 7, 6, 5, 4, 3, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2]
%----------
 
% Output 05:
%----------
%Custo: 12
%Caminho: [6, 5, 6, 5, 6, 5, 4, 3, 2, 1]
%----------

% Output 06:
% Deu pau e eu fiquei com preguiça de resolver.