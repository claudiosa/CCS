/*
  Assignment problem from Winston "Operations Research.
  The swimming team example, page 398:
  """
  Doc Councillman is putting together a relay team for
  the 400-meter relay. Each swimmer must swin 100 meter
  of breaststroke, backstroke, butterfly or freestyle.
  Doc believes that each swimmer will attain the times
  given in table 51. To minimize the team's time for the race,
  which swimmer should swim which stroke.
  """

MATRIX:

             estilo 1  estilo 2   estilo 3  estilo 4
 nadador 1      t11       t12       ...        ... 
 nadador 2      ...        ....      ...        ... 
 nadador 3      ...        ....      ...        .... 
 nadador 4      ...        ...       ....        t44  

*/
tempo_nadadores =
				[|54, 54, 51, 53,  
				 |51, 57, 52, 52, 
				 |50, 53, 54, 56, 
				 |56, 54, 55, 53
				 |]
				;

int: rows;  %%% LINHAS
int: cols;  %%% COLUNAS
rows = 4;
cols = 4;


array[1..rows, 1..cols] of var 0..1: x; /* eh a variavel de decisao - matriz */
array[1..rows, 1..cols] of int :  tempo_nadadores ;

%%%%%%
var int: tempo_total_reveza;

constraint
tempo_total_reveza = sum(i in 1..rows, j in 1..cols) (x[i,j]*tempo_nadadores[i,j]);

%
% exatamente um nadador por estilo
%
constraint  
 forall(i in 1..rows) (
        sum(j in 1..cols) (x[i,j]) = 1
 )
;

% exatamente cada estilo sera nadado por um nadador
constraint   
 forall(j in 1..cols) (
        sum(i in 1..rows) (x[i,j]) = 1
  )
;


% minimize ou sem otimização
%%%solve satisfy;  
solve minimize tempo_total_reveza;

output [
  if i = 1 /\ j = 1 then
  "tempo_total: " ++ show(tempo_total_reveza) 
  else "  "  endif  ++
   if j = 1 then "\n" else " " endif ++
  show(x[i,j])  | i in 1..rows, j in 1..cols
   ] ++ ["\n"];
/* ****************************************** */
