/*
Exercise 1.2
Consider the following Boolean constraints (see also Slide 22 in Chapter 2):
i1 ∧ o2 = y1
i2 ∧ o1 = y2
¬y1 = o1
¬y2 = o2
For the above constraints show a successful derivation using the Boolean constraint propagation rules given on Slide 23. For each derivation step you should underline the selected constraint and give the
used rule. The initial CSP is:
i1 ∧ o2 = y1 , i2 ∧ o1 = y2 , ¬y1 = o1 , ¬y2 = o2 ; o2 = 1, i1 = 1
*/

:- lib(ic).

go :- %% DOMINIO
	[I1,I2,O1,O2,Y1,Y2] #:: 0..1,

%% RESTRIÇOES com and or etc pode SIM
%% Contudo seu uso eh diretamente sobre RESTRICOES
%% /*
Exercise 1.2
Consider the following Boolean constraints (see also Slide 22 in Chapter 2):
i1 ∧ o2 = y1
i2 ∧ o1 = y2
¬y1 = o1
¬y2 = o2
For the above constraints show a successful derivation using the Boolean constraint propagation rules given on Slide 23. For each derivation step you should underline the selected constraint and give the
used rule. The initial CSP is:
i1 ∧ o2 = y1 , i2 ∧ o1 = y2 , ¬y1 = o1 , ¬y2 = o2 ; o2 = 1, i1 = 1
*/

:- lib(ic).

go :- %% DOMINIO
	[I1,I2,O1,O2,Y1,Y2] #:: 0..1,

%% RESTRIÇOES com and or etc pode SIM
%% Contudo seu uso eh diretamente sobre RESTRICOES
%% nos casos abaixo as virgulas  podem serem trocadas por "and"
%%% mas, perde-se a legibilidade usando  "and" nestes casos

I1 #=1,
O2 #=1,
(Y2 #\= O2), 
Y1 #\= O1,
Y1 #= (I1 and O2),
I2 #= (O1 and Y2),

search([I1,I2,O1,O2,Y1,Y2], 0, anti_first_fail, indomain_middle, complete, []),
writeln([I1,I2,O1,O2,Y1,Y2]).


%% ANALISE
/*
?- go.
Yes (0.01s cpu, solution 1, maybe more)
No (0.03s cpu)

[1, 0, 0, 1, 1, 0]
*/

%%% mas, perde-se a legibilidade usando  "and" nestes casos

I1 #=1,
O2 #=1,
(Y2 #\= O2), 
Y1 #\= O1,
Y1 #= (I1 and O2),
I2 #= (O1 and Y2),

search([I1,I2,O1,O2,Y1,Y2], 0, anti_first_fail, indomain_middle, complete, []),
writeln([I1,I2,O1,O2,Y1,Y2]).


%% ANALISE
/*
?- go.
Yes (0.01s cpu, solution 1, maybe more)
No (0.03s cpu)

[1, 0, 0, 1, 1, 0]
*/





