/*
 Uma conta antiga de natal revela que setenta e dois (72) perús foram comprados por R\$ "\_67\_" reais. 
 O primeiro e o último algarismos desta conta estão ilegíveis. Sabendo que o preço de cada perú é um número inteiro 
 (na época nem tudo tinha os 99 centavos atrás do preço), 
 desenvolva um programa capaz de determinar o preço unitário de cada perú.
*/

%%% PROBLEMA DO PERU

var 0 .. 9 : X;
var 0 .. 9 : Y;
var 0 .. 99 : Valor;

constraint
   X*1000 + 670 + Y == 72 * Valor;


solve satisfy;
output [ show(X)," ", show(Y), " " , show(Valor) , "\n",
         "Total ",  show(fix(X*1000 + 670 + Y))
       ];
/*       
minizinc peru.mzn 
3 2 51
Total 3672
*/
