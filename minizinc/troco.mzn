%%%% Sistema monetario {1, 3, 4}
%%% Problema do troco das moedas ....
%% Retornar o  menor numero de moedas  possivel 
%
%int: Valor = 6 ;
int: Valor = 17 ;

var 0 .. 300 : Qt;
var 0 .. 100 : M1;
var 0 .. 100 : M2;
var 0 .. 100 : M3;

constraint
    1 * M1 + 3 * M2 + 4 * M3 = Valor;

constraint
    Qt = M1 + M2 + M3;

solve minimize  Qt ;
    
%    solve satisfy;

output ["  M1:", show(M1), "  M2:", show(M2),
        "  M3:", show(M3) ++"\n" ];
/*
  M1:0  M2:3  M3:2
----------
==========
*/
