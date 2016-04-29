/*
Considere um domınio Dx = {2, 3, 4}, Dy = {3, 4, 5} 
construa fun ̧coes que faz a interpreta ̧cao logica das 
formulas abaixo:
(a) ∀x∃y(y < x)
(b) ∃x∀y(x < y)
(c) ∀x∃y(x^2 == y)
(d) ∃x∀y(x^2 != y)
*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Thiago e Andressa -- modificado por CCS
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%declarar variáveis

set of int: A = {2,3,4};
set of int: B = {3, 4, 5};
  
function bool: exemplo_A(set of int: x, set of int: y) = 
	(forall (i in x) ( exists (j in y) (j < i))); 

function bool: exemplo_B(set of int: x, set of int: y) = 
	exists (i in x) (forall (j in y) (i < j)); 

function bool: exemplo_C(set of int: x, set of int: y) = 
	forall (i in x) (exists (j in y) (pow(i,2) == j));

function bool: exemplo_D(set of int: x, set of int: y) = 
	exists (i in x) (forall (j in y) (pow(i,2) != j));

/*
%%% para o FUTURO
constraint exemplo_A(A, B);
constraint exemplo_B(A, B);
constraint exemplo_C(A, B);
constraint exemplo_D(A, B);
*/
solve satisfy;

output["\n Exemplo 01: "++ show(exemplo_A(A,B))++
       "\n Exemplo 02: "++ show(exemplo_B(A,B))++
       "\n Exemplo 03: "++ show(exemplo_C(A,B))++
       "\n Exemplo 04: "++ show(exemplo_D(A,B))
     ];