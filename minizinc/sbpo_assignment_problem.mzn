int: linhas = 4;     int: cols = 5;

%%%% m_PESO =  MATRIZ DEFINIDA  NO FINAL do arquivo

array[1..linhas, 1..cols] of int:  m_PESO;
array[1..linhas, 1..cols] of var 0..1: x; %% x: MATRIZ DE DECISAO
var int:  f_CUSTO;

constraint  %% exatamente UMA escolha por  linha 
 forall(i in 1..linhas) (
        sum(j in 1..cols) (x[i,j]) == 1 );

constraint  %% exatamente 0 ou UMA escolha por coluna
  forall(j in 1..cols) (
        sum(i in 1..linhas) (x[i,j]) <= 1 );

constraint  %% Uma funcao CUSTO ou  objetivo
  f_CUSTO = sum(i in 1..linhas, j in 1..cols) (x[i,j]*m_PESO[i,j]);
 
solve maximize f_CUSTO;

output ["f_custo: ", show(f_CUSTO ), "\n", show2d(x)];
/*****************************************************************/

m_PESO = 
[|14,  5, 8,  7, 15,
 | 2, 12, 6,  5,  3,
 | 7,  8, 3,  9,  7,
 | 2,  4, 6, 10,  1  |];
