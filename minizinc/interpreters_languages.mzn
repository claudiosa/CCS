%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Classical Covering Problem --  translators or interpreters x languages
%% MODEL CREATED by THIAGO ALEIXO
%% ADAPTED by CCS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%include "alldifferent.mzn";

int: rows;
int: cols;

rows = 4;
cols = 4;

% Tradutores -- LINHAS 
Weight_Graph
%         L1 L2 L3  L4     
      = [|1, 1, 1, 0,    % I1
         |0, 0, 1, 0,    % I2
         |1, 0, 0, 0,    % I3
         |0, 0, 1, 1     % I4
         |]
        ;
array[1..rows, 1..cols] of int:  Weight_Graph;

%%% DECISION VAR for INTERPRETERS one per row
array[1..rows] of var 0..1 : X_D_interpreters;

 %%% MATRIX DECISION for which interpreter speaks which language
array[1..rows, 1..cols] of var 0..1:  D; %%% NOT NECESSARY

var int: total_interp; %% needs for minimization

%%% at least one interpreter
constraint
   sum(i in 1..rows) ( X_D_interpreters[i] ) >= 1;

constraint  
% the interpreter selected must be speak at least a language
   forall(j in 1..cols) (
        sum(i in 1..rows) (X_D_interpreters[i] * Weight_Graph[i,j]) >=1 
        );

%%% Minimizing the interpreters numbers
constraint
   total_interp = sum(i in 1..rows) ( X_D_interpreters[i] );

solve minimize total_interp;


output [  
        "Interprete "++ show(i) ++ " = "  ++  
        show(X_D_interpreters[i]) ++ "\n" | i in 1..rows]
        ++ [ "TOTAL: " ++ show(total_interp) ++ "\n" ] 
        ++ [ "\n Covering Matrix \n " ] ++  
        [ if j = 1 then "\n" else " " endif ++
         show(X_D_interpreters[i]*Weight_Graph[i,j])
         | i in 1..rows , j in 1..cols
        ] ++ ["\n"];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
