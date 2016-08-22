set of int : Index = 1 .. 4;

array[Index] of string: 
            Estacoes = ["Verao", "Outono", "Inverno", "Primavera"];
var Index : x;
 
constraint
     x >= 2;

solve satisfy;
output [ Estacoes[ fix (x) ], "\n", show(Estacoes) ];
