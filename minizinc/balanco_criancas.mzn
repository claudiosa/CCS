/*  
   Problem ...
   
   A: Abel -- 36 KG
   B: Beatriz -- 32 KG
   C: Carlos  -- 16 KG
   D1 = { 36, 32, 16}
   D2 = { -5, -4, .... 0 .... 4, 5}
   
   dist(|A-B|) >= 2
   dist(|C-B|) >= 2
   .........
   A \= 0,
   B \= 0,
   C \= 0,
   A*36 + B*32 + C*16 == 0
   
*/   
var -5  .. 5 : A;
var -5  .. 5 : B;
var -5  .. 5 : C;   

constraint
   A >  0    /\  %% Break simetry
   A <  5    /\  %% Filtering the domain
   A != 0;  
    
constraint
      B != 0  /\
      C != 0;
  
constraint
   abs(A-B) > 2   /\
   abs(A-C) > 2    /\
   abs(B-C) > 2;

constraint 
   36*A + 32*B + 16*C = 0;

 %%% INCLUIR ISTO 
solve satisfy;

output [    "   A: "  ,  show(A),"     B: ", show(B), "     C:  " , show(C) ,   "\n" ];



/* ****
ccs@gerzat:~/Dropbox/pesquisa/curso_ALL/pgms_slides$ minizinc --all-solutions balanco_criancas.mzn 
  A: 4    B: -4     C:  -1
----------
  A: 4    B: -5     C:  1
----------
  A: 4    B: -2     C:  -5
----------
==========

From ECLIPSE ... please ... see the Eclipse Model

1 .. 4
[4, -5, 1]
[4, -4, -1]
[4, -2, -5]
******** */
