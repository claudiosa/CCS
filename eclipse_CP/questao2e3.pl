/*   
   Assignment problems in ECLiPSe.
   Different assignments problem, both minimization and maximization. 
   Model created by Hakan Kjellerstrand, hakank@bonetmail.com
   See also my ECLiPSe page: http://www.hakank.org/eclipse/
   Original from:
   http://www.hakank.org/eclipse/assignment.ecl

   This model was adapted by Claudio Cesar de Sa
   the kernel was changed aiming legibility for my students
   specifically, constraint C3
   
  Basically, my motivation was the exclusion of  "fromto" predicate in this kernel
  The fromto is powerfull predicate but with some dificulty to understand it.

  By the way:  all credits goes to Hakan
*/

:-lib(ic).
% :-lib(ic_global).
:-lib(ic_search).
:-lib(branch_and_bound).
%:-lib(propia).

%% only two Hakan's problems from 6 
go :-
        assignment(4),
        assignment(5).

%
% assignment(Numero_do_problema)
% 
assignment(Numero_do_problema) :-
        %%  Numero_do_problema = problem number
        %% maximizacao ou minimizacao
        %% Cost: eh uma matriz de custo mesmo
        cost(Numero_do_problema, Mode, Cost),
        printf("\nProblema %d\n", [Numero_do_problema]),
        
       % obtendo as dimensoes do problema - veja formato da MATRIX
        dim(Cost,[Rows,Cols]),

        % Criando uma matriz com variaveis de decisao:  0..1 
        % do mesmo tamanho que a matrix Custo
        dim(X,[Rows,Cols]),
        X :: 0..1,
		
		dim(X1,[Rows,Cols]),
        X1 :: 0..1,

        % Posting the problems constraints:
  
        % C1: Cada linha deverah ter exatamente 1 valor escolhido
        % assim um valor por linha em qualquer coluna
        %
        ( for(I,1,Rows), 
			  param(X,Cols) %% X e Cols sao externos ao for
			  do
              sum(X[I,1..Cols]) #= 2;
			  sum(X[I,1..Cols]) #= 1
         ),

        %
        % C2: Nenhum ou um assignments por coluna
        %
        ( for(J,1,Cols), param(X,Rows) do
              sum(X[1..Rows,J]) #=< 2
        ),
		
		flatten_array(X,X_L),
		
		
		
		Aux = Cols div 2,
		Max = Cols + (Rows div 2),
		sum(X_L) #= Max,
	
		
        %
        % C3: Calculate TotalCost
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% % 
        % I changed from HERE ... remove a double for and fromto's predicate 
        dim(Temp,[Rows]), %%% An auxiliar array to sum the products by line
        %%    writeln("Debugging reasons OK"),
%%%%%
     ( for(I, 1, Rows),  %% EXTERNO nao esqueca da virgurla
      param( Cost, X, Temp)
        do
         arg(I,  Cost,  Array_I_Cost),
         % writeln("Debugging reasons" : Array_I_Cost),	
         arg(I,  X,  Array_I_X),
         % writeln("Debugging reasons" : Array_I_X),
		 prod_escalar_Array(Array_I_Cost, Array_I_X , Temp[I])
       ),
	   
	   %%writeln(Cost),
	   %%writeln(Temp),
	   
       %%writeln("An array of constraints from each line in Temp" : Temp),
       flatten_array(Temp, L_Temp),  %%% transform an array to a list
       %%writeln("A list of constraints from each line in L_Temp" : L_Temp),
       %%% summing all constraints in a list ... a global constraint of this problem
       TotalCost2  #= sum(L_Temp), %%% sum works just with lists, not for array
   
%%% Ending of my  changings... the constraint 1, 2 and 3 is the kernel model's
 
        %%writeln(" TotalCost2 constraint is given as" : TotalCost2),
    	%%%
        % prepare for maximization (if needed)
          TotalCostNeg #= -TotalCost2,
      
        %
        % get the optimization mode
        %
        (
            Mode = minimize
        -> 
            writeln("Eh um minimizacao"), OptValue #= TotalCost2 
        ; 
            writeln("Eh uma maximizacao"), OptValue #= TotalCostNeg
        ),

        %
        % search
        % 
        % converting the X array to X in  format type list
        flatten_array(X, XList),        
        minimize(search(XList ,0,first_fail,indomain,complete,[]), OptValue),
     
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Final Printings:
        pretty_pretty_print(X),
       % writeln("Assignments" : Assignments),
        writeln("Cost Matrix:"),
        pretty_print(Cost),
        writeln(total_cost: TotalCost2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Scalar product of two array 
prod_escalar_Array( A1, A2 , Result):-
	(
	 foreacharg(X1, A1),
  	 foreacharg(X2, A2),
     foreach(P_cel, Lista_P_cel) %%% must be a list
	 do
	     P_cel  #=  X1*X2 %% not instanced, so it is a constraint
       ),
     %%% writeln("A list of constraints from each line in:"  :Lista_P_cel),
     Result #= sum(Lista_P_cel) .  % sum predicate accepts ONLY in List format
     %%% writeln("An array of constraints from each line in:"  :Result).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pretty_print(X) :-
        dim(X, [Rows,Cols]),
        ( for(I, 1, Rows), param(X, Cols) do
            ( for(J, 1, Cols), param( X, I) do
                XX is X[I,J],
                printf("%2d", XX),
                write(" ")
            ),
            nl
        ).   

% RAFAEL .... pretty prints a matrix
pretty_pretty_print(X) :-
        dim(X, [Rows,Cols]),
        ( for(I, 1, Rows), param(X, Cols) do
            ( for(J, 1, Cols), param( X, I) do
                XX is X[I,J],
                (XX == 1 -> printf(output,"%n O trabalhador %d estah alocado a tarefa %d",[I,J]) ; write(" "))   
            )
            
        ),
		nl.        

		
		
prettyprettyprint(Assigments):-
		list2array(Assigments,A),
		dim(A,[N]),
		( for(I,1,N),param(A) do
			element(I,A,Y),
			R1 is I,
			R2 is Y,
			printf(output,"%n O trabalhador %d estah alocado a tarefa %d",[R1,R2])
		).

%
% cost(ProblemNumber, OptimizationMode, CostMatrix). 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% PROBLEM -- 4
% Tom Cruise, Freddy Prinze Jr, Harrison Ford, and Matt LeBlanc
% are marooned on a desert island with Jennifer Anniston,
% Courtney Cos, Gwynneth Paltrow, and Julia Roberts.
% The 'compatibility matrix' in Table 52 indicate how much happiness
% each couple would experience if the spend all their time toghether.
% The happiness earned by a couple is proportional to the fraction 
% of time the spend toghether. 
% ...
% The optimal solution requires that that each person send all their
% time with one person of the opposite sex, so this result is often
% referred to as the Marriage Theorem.
% """
%

% males:
% 1 "Tom Cruise"
% 2 "Freddie Prinz Jr"
% 3 "Harrison Ford"
% 4 "Mark LeBlanc"
%
% females:
% 1 "Jennifer Anniston"
% 2 "Courtney Cox"
% 3 "Gwynneth Paltrow"
% 4 "Julia Roberts"
cost(4, maximize, [](
                        [](7, 5, 8, 2),
                        [](7, 8, 8, 4),
                        [](3, 5, 7, 9),
                        [](5, 5, 6, 7))).
%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROBLEM -- 5 --  Marriage Theorem
% From  "SAS OR 9.1 User's Guide Mathematical Programming"
% 
% Consider assigning five programmers to five programming jobs. Each
% programmer prefers specific programming job over others. [...] 
% Suppose you ask each programmer to rank the jobs according to preference
% (using 1 for the most preferred job and 5 for the least preffered job).
% PROC ASSIGN maximizes the total preference of the group by minimizing the
% sum of the preferences. 
% 
%    PROGRAMMER     JOB1 JOB2 JOB3 JOB4 JOB5
%    PROGRAMMER1    4    1    3    5    2
%              2    2    1    3    4    5
%              3    3    2    4    1    5
%              4    2    3    4    5    1
%              5    4    2    3    1    5
% 
% """
% % See http://www.hakank.org/minizinc/assignment5.mzn
% 
cost(5, minimize, []([](4, 1, 3, 5, 2),
                     [](2, 1, 3, 4, 5),
                     [](3, 2, 4, 1, 5),
                     [](2, 3, 4, 5, 1),
                     [](4, 2, 3, 1, 5))).



/*Novos resultados com a sobrecarga questao 2 e arrumando os prints 



NOVOS RESULTADOS COM % DE SOBRECARGA


Problema 4
Eh uma maximizacao
Found no solution with cost -96.0 .. -0.0
Eh uma maximizacao
Found no solution with cost -96.0 .. -0.0
Eh uma maximizacao
Found no solution with cost -96.0 .. -0.0
Eh uma maximizacao
Found a solution with cost -32
Found a solution with cost -34
Found a solution with cost -40
Found a solution with cost -45
Found a solution with cost -47
Found no solution with cost -96.0 .. -48.0
 1  0  1  0 
 0  1  1  0 
 0  0  0  1 
 0  0  0  1 
Assignments : [_12145{[1, 3]}, _12424{[2, 3]}, 4, 4]
Cost Matrix:
 7  5  8  2 
 7  8  8  4 
 3  5  7  9 
 5  5  6  7 
total_cost : 47

Problema 5
Eh um minimizacao
Found no solution with cost 0.0 .. 75.0
Eh um minimizacao
Found no solution with cost 0.0 .. 75.0
Eh um minimizacao
Found no solution with cost 0.0 .. 75.0
Eh um minimizacao
Found no solution with cost 0.0 .. 75.0
Eh um minimizacao
Found no solution with cost 0.0 .. 75.0
Eh um minimizacao
Found no solution with cost 0.0 .. 75.0
Eh um minimizacao
Found no solution with cost 0.0 .. 75.0
Eh um minimizacao
Found a solution with cost 26
Found a solution with cost 25
Found a solution with cost 24
Found a solution with cost 23
Found a solution with cost 22
Found a solution with cost 21
Found a solution with cost 20
Found a solution with cost 19
Found a solution with cost 18
Found a solution with cost 16
Found a solution with cost 15
Found a solution with cost 14
Found a solution with cost 12
Found a solution with cost 11
Found a solution with cost 10
Found a solution with cost 9
Found no solution with cost 0.0 .. 8.0
 0  1  0  0  1 
 1  1  0  0  0 
 0  0  0  1  0 
 0  0  0  0  1 
 0  0  0  1  0 
Assignments : [_30432{[2, 5]}, _30724{[1, 2]}, 4, 5, 4]
Cost Matrix:
 4  1  3  5  2 
 2  1  3  4  5 
 3  2  4  1  5 
 2  3  4  5  1 
 4  2  3  1  5 
total_cost : 9


RESULTADOS
Problema 4
An array of constraints from each line in Temp : [](_4296{0 .. 22}, _5650{0 .. 27}, _7004{0 .. 24}, _8358{0 .. 23})
An array of constraints from each line in L_Temp : [_4296{0 .. 22}, _5650{0 .. 27}, _7004{0 .. 24}, _8358{0 .. 23}]
 TotalCost2 constraint is given as : _8719{0 .. 96}
Eh uma maximizacao
Found a solution with cost -20
Found a solution with cost -22
Found a solution with cost -30
Found no solution with cost -96.0 .. -31.0
 0  0  1  0 
 0  1  0  0 
 0  0  0  1 
 1  0  0  0 
Assignments : [3, 2, 4, 1]
Matriz custo inicial:
 7  5  8  2 
 7  8  8  4 
 3  5  7  9 
 5  5  6  7 
total_cost : 30

Problema 5
An array of constraints from each line in Temp : [](_16107{0 .. 15}, _17752{0 .. 15}, _19397{0 .. 15}, _21042{0 .. 15}, _22687{0 .. 15})
An array of constraints from each line in L_Temp : [_16107{0 .. 15}, _17752{0 .. 15}, _19397{0 .. 15}, _21042{0 .. 15}, _22687{0 .. 15}]
 TotalCost2 constraint is given as : _23087{0 .. 75}
Eh um minimizacao
Found a solution with cost 17
Found a solution with cost 14
Found a solution with cost 13
Found a solution with cost 10
Found a solution with cost 9
Found a solution with cost 8
Found no solution with cost 0.0 .. 7.0
 0  1  0  0  0 
 1  0  0  0  0 
 0  0  0  1  0 
 0  0  0  0  1 
 0  0  1  0  0 
Assignments : [2, 1, 4, 5, 3]
Matriz custo inicial:
 4  1  3  5  2 
 2  1  3  4  5 
 3  2  4  1  5 
 2  3  4  5  1 
 4  2  3  1  5 
total_cost : 8
*/
