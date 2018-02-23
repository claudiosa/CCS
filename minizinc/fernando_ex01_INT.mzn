/*
Exemplo 1
Implementacao IMEDIATA
*/

var int : x1;
var int : x2;
/* LIMITAR O DOMINIO DOS REAIS ... roda com o GECODE */
%var -5.0 .. 4.5 : x1;
%var -5.0 .. 4.5 : x2;

%% f objetivo
var int: z ; %% =   3.0*x1 + 5.0*x2 ;

constraint 
    z =  3.0*x1 + 5.0*x2 ;

constraint 
       x1 <= 4.0
	   /\
        9.0*pow(x1,2)  +  5.0*pow(x2,2)  >= 216.0
    %%%  9.0*x1*x1  +  5.0*x2*x2  >= 216.0
	  /\
        x1  >= 0.0 %% os limites inferiores nao sao calculados
	  /\
        x2  >= 0.0
    ;

%   solve minimize z;
%% solve satisfy;
solve maximize z;

output
[
 "x1:" ++ show(x1)  ++ "\n" ++
 "x2:" ++ show(x2)  ++ "\n" 
 ++  "Lucro z:" ++ show(z)  ++ "\n"
];
