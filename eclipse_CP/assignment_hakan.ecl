/*
   Assignment problems in ECLiPSe.

   Different assignments problem, both minimization and maximization. 
   Model created by Hakan Kjellerstrand, hakank@bonetmail.com
   See also my ECLiPSe page: http://www.hakank.org/eclipse/

   adaptacao e traducao para o PORTUGUES: claudio
*/

:-lib(ic).
% :-lib(ic_global).
:-lib(ic_search).
:-lib(branch_and_bound).
%:-lib(propia).

%% escolhi dois problemas do Hakan ::: de 6
go :-
        assignment(4),
        assignment(5).

%
% assignment(Numero_do_problema)
% 
assignment(Numero_do_problema) :-
        %%  Numero_do_problema
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

        % Postando as restricoes do problema, algo como:
  
        % R1: Cada linha deverah ter exatamente 1 valor escolhido
        % assim um valor por linha em qualquer coluna
        %
        ( for(I,1,Rows), 
			  param(X,Cols) %% X e Cols sao externos ao for
			  do
              sum(X[I,1..Cols]) #= 1
         ),

        %
        % R2: Nenhum ou um assignments por coluna
        %
        ( for(J,1,Cols), param(X,Rows) do
              sum(X[1..Rows,J]) #=< 1
        ),

        %
        % R3: Calculate TotalCost
        % 
        /*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        (for(I,1,Rows) * for(J,1,Cols), 
         fromto(0,In,Out,TotalCost2), %% I changed here 
         param(X,Cost) do 
             Out #= In + X[I,J]*Cost[I,J]
         ),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
*/
     ( for(I, 1, Rows),  %% EXTERNO
      param(Cols, Cost, X),
      fromto(0,In2,Out2,TotalCost2) do %% o acumulado estarah aqui
        ( for(J,1,Cols),   			   %% INTERNO
           fromto(0,In,Out,TotalCost), %% acumulado por linha 
           param(Cost,I, X) do
              Out #= In + X[I,J]*Cost[I,J]
          ),
          Out2 #= In2 + TotalCost 
      ),
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
/*       
you are right: the for() * for() loop ("cross product") is a
special constraint that mean - as you mentioned - two for loops

But the the cross product version is much easier to write and read,
isn't it?

For more about the cross product, see the documentation of
the do-lopps:
  http://www.eclipseclp.org//doc/bips/kernel/control/do-2.html
(search for "cross product").
    
        */
%%%%%%%%%% DETALHAR ISTO        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    	%%%
        % prepare for maximization (if needed)
          TotalCostNeg #= -TotalCost2,
      
        %
        % get the optimization mode
        %
        (
            Mode = minimize
        -> 
            writeln("EH um minimizacao"), OptValue #= TotalCost2 
        ; 
            writeln("EH uma maximizacao"), OptValue #= TotalCostNeg
        ),


        %
        % search
        % 
        flatten_array(X,XList),        
        minimize(search(XList,0,first_fail,indomain,complete,[]), OptValue),

        % search(XList,0,first_fail,indomain,complete,[]),

        %
        % get the assignments 
        %
        % note: this should be done _after_ labeling.
        %
        length(Assignments, Rows), %%% cria uma lista do tamanho do num de linhas
        (for(I,1,Rows), 
         fromto(Assignments, Out, In, []),
         param(X,Assignments,Cols) do
             ThisRow is X[I,1..Cols],
             element(K, ThisRow, 1),
             Out = [K|In]
        ),

        pretty_print(X),
        writeln(assignments: Assignments), %%%write(Assignments),
        writeln("Matriz custo inicial:"),
        pretty_print(Cost),
        writeln(total_cost: TotalCost2).



% pretty prints a matrix
pretty_print(X) :-
        dim(X, [Rows,Cols]),
        ( for(I, 1, Rows), param(X, Cols) do
            ( for(J, 1, Cols), param(X, I) do
                XX is X[I,J],
                printf("%2d", XX),
                write(" ")
            ),
            nl
        ).        


%
% cost(ProblemNumber, OptimizationMode, CostMatrix). 
%

% 
% " "
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


% From
%  "SAS OR 9.1 User's Guide Mathematical Programming"
% """
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
% 
% See http://www.hakank.org/minizinc/assignment5.mzn
% 
cost(5, minimize, []([](4, 1, 3, 5, 2),
                     [](2, 1, 3, 4, 5),
                     [](3, 2, 4, 1, 5),
                     [](2, 3, 4, 5, 1),
                     [](4, 2, 3, 1, 5))).



/*
Problema 4
lists.eco  loaded in 0.01 seconds
maximize
Found a solution with cost -20
Found a solution with cost -22
Found a solution with cost -30
Found no solution with cost -96.0 .. -31.0
 0  0  1  0 
 0  1  0  0 
 0  0  0  1 
 1  0  0  0 
assignments : [3, 2, 4, 1]
total_cost : 30

Problema 5
minimize
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
assignments : [2, 1, 4, 5, 3]
total_cost : 8

*/
