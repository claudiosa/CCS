%%%% CABO DE GUERRA

int: n; %% total de pessoas

%% Quantos em cada lado
var int: NA;
var int: NB;

%%% qtidade de pessoas e seu peso
n = 4; 
peso = [ 77, 9, 100, 15];
array[1..n] of int : peso;

%% var de decisao BINARIA
array[1..n] of var 0..1 : x_decision;

var int: PESO_TOTAL;
var int: PA;
var int: PB;

%%% ilustrando uma funcao
function var int: metade( int: n) = n div 2 ;

%% quantos em cada lado
constraint
   NA = metade(n)
   /\
   NB = (n - NA);


constraint
   PESO_TOTAL = sum( i in 1..n ) (peso[i]);

constraint
  NA = sum( i in 1..n ) ( x_decision[i] );

constraint
  PA = sum( i in 1..n ) ( x_decision[i]*peso[i] );

constraint
  PB = (PESO_TOTAL - PA);

% minimizar a diferenca
solve minimize abs(PA-PB);

output [
  "Total: " ++ show(PESO_TOTAL) ++"\n"++
  "PA : " ++ show( PA ) ++"\n"++
  "PB : " ++ show( PB ) ++"\n"++
  "TIME A: " ++ show( x_decision ) ++ "\n" ];


/*
Resposta:
Total: 201
PA : 109
PB : 92
TIME A: [0, 1, 1, 0]
*/