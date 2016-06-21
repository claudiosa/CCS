/*

Fonte https://www.dropbox.com/s/rzfa5e1o51jxvk6/nonlinear1.pdf?dl=0
Exemplo 2
*/

%var float : x1;
%var float : x2;
/* LIMITAR O DOMINIO DOS REAIS ... roda com o GECODE */
var -10.0 .. 10.0 : x1;
var -10.0 .. 10.0 : x2;

%% f objetivo
var float: z ; %% =   3.0*x1 + 5.0*x2 ;

constraint 
    z =  3.0*x1 + 5.0*x2 ;

constraint 
        x1 <= 4.0
	   /\
        9.0*pow(x1,2)  +  5.0*pow(x2,2)  <= 216.0
    %%% OU 9.0*x1*x1  +  5.0*x2*x2  <= 216.0
	  /\
        x1  >= 0.0 %% os limites inferiores nao sao calculados
	  /\
        x2  >= 0.0
    ;

solve :: float_search([x1,x2], 1.5 , input_order, indomain_split, complete) maximize z;

%%% o 2o. parametro acima eh a precisao .... 0.001 eh melhor 
output
/*[
 "x1:" ++ show(x1)  ++ "\t" ++
 "x2:" ++ show(x2)  ++ "\t" 
 ++  "Max z:" ++ show(z)  ++ "\n"
];*/     

[
 "x1:" ++ show_float(6,2,x1)  ++ "\t" ++
 "x2:" ++ show_float(6,2,x2)  ++ "\t" 
 ++  "Max z:" ++ show_float(6,2,z)  ++ "\n"
];
