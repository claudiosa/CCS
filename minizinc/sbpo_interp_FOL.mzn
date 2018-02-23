%%Declarando dominio das  variaveis
set of int: A = {2, 3, 4};   %% X eh um conjunto do tipo int
set of int: B = {3, 4, 5};   %% inicializado com {2, 3, 4}

function bool: exemplo_01(set of int: x, set of int: y) = 
                forall (i in x) 
                 (exists (j in y) 
                   (j < i)); 

function bool: exemplo_02(set of int: x, set of int: y) = 
                exists (i in x) 
                 (forall (j in y) 
                  (i < j)); 

function bool: exemplo_03(set of int: x, set of int: y) = 
                forall (i in x) 
                 (exists (j in y) 
                   pow(i,2) == j));

function bool: exemplo_04(set of int: x, set of int: y) = 
                 exists (i in x) 
                  (forall (j in y) 
                    (pow(i,2) != j));

solve satisfy;

output["\n Exemplo 01: "++ show(exemplo_01(A,B))++
       "\n Exemplo 02: "++ show(exemplo_02(A,B))++
       "\n Exemplo 03: "++ show(exemplo_03(A,B))++
       "\n Exemplo 04: "++ show(exemplo_04(A,B))];
