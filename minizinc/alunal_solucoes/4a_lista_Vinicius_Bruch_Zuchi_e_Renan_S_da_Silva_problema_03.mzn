% 3 Guarda-Chuvaville
% O arquivo de entrada contém vários casos de testes. Cada caso de teste é iniciado por um
% inteiro n (0 ≤ n ≤ 100), que indica a dimensão da cidade. Em seguida, tem-se n linhas com n
% colunas, as quais descrevem o quadrante ou matriz que representa a cidade.
% A saı́da será um único inteiro por linha. Este valor representa uma soma de valores que estão
% dentro de uma área da cobertura, que maximize a satisfação da população, dada na matriz
% original.

int: N; % Dimensão da matriz

array[1..N,1..N] of int : matrix; % matriz de valores

var 1..N : x1; % limitante inferior do eixo x
var 1..N : x2; % limitante superior do eixo x
var 1..N : y; % limitante superior do eixo y
var int : result; % variável para armazenar o somatório

result = sum (i in x1..x2, j in 1..y) (matrix[i,j]); % Maximizar os valores da janela, considerando que a janela será sempre quadrada ou retangular 

solve maximize result;

output[show(result)];

/* output 1: 

100
----------
==========

   output 2:

194
----------
==========

   output 3: 

780
----------
==========

*/