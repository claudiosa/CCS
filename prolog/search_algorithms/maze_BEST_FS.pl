%%% A - star: f = g + h
%%% BEST : f = g (heuristic to the END)
%%% IMPLEMENT BEST FIRST ALGORITHM
%%% $ swipl -q -f hello.pl -t main
%%% swipl -q -t main -f maze_BEST_FS.pl 
%%% INITIAL CODE FROM https://stackoverflow.com/questions/16076778/prolog-maze-solving-algorithm
%%% good IDEA for a Maze or graphs problem

%%% THIS IDEA is cool
w(0,0).
w(0,1). w(1,1). w(2,1). w(3,1). w(4,1). w(5,1).
        w(1,2).         w(3,2).         w(5,2).
        w(1,3).         w(3,3).         w(5,3).
w(0,4). w(1,4). w(2,4).         w(4,4). w(5,4).
                w(2,5). w(3,5). w(4,5). w(5,5).

%%% Add by CCS
start_point(0,0). %%% departure, initial ... 
end_point(4,5). %% arrival, exit, end ...


%%%% GREAT IDEA 
d(X0,Y0,X,Y) :- next_w(X0,Y0,X,Y), w(X,Y).
%%% ONLY ALLOWED MOVEMENTS
next_w(X0,Y0,X0,Y) :- Y is Y0+1. %%% RIGHT 
next_w(X0,Y0,X,Y0) :- X is X0+1. %%% DOWN
next_w(X0,Y0,X0,Y) :- Y is Y0-1. %%% LEFT
next_w(X0,Y0,X,Y0) :- X is X0-1. %%% UP
%%% PERFORMANCE

%%% KERNEL of SEARCH
search_BEST_FS(X,Y,Path,Path) :-
           end_point(X,Y).
           %
           % format("\n FOUND A SOLUTION\n").

search_BEST_FS(X0,Y0, PATH_TEMP, Path) :-
    
    expand_current_node(X0,Y0,L),
    heuristic_evalution(L, L_H),
    choice_the_best(L_H, (X1,Y1)),
    \+ member(  (X1,Y1) , PATH_TEMP ),
    search_BEST_FS(X1,Y1,[ (X1,Y1)|PATH_TEMP],Path).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% end of KERNEL 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% expanding for immediate neighbours 
expand_current_node(X0,Y0,L):-
     findall((X1,Y1), d(X0,Y0,X1,Y1), L).

%%% evalution functions -- Manhathan distance         
heuristic_evalution( [], [] ).   
heuristic_evalution([(X1,Y1)|L], [(X1,Y1)/H1 | L_H ]) :-
        
        end_point(X_d,Y_d),
        H1 is abs(X_d - X1) +    abs(Y_d - Y1),
        heuristic_evalution( L, L_H ).  
             

choice_the_best(L_H, (X_best,Y_best)) :-
      min_value(L_H, (X_best,Y_best) ).


%%% FINDING THE MINIMAL HEURISTIC VALUE      
min_value([ (X,Y)/_ ], (X,Y) ):- !. %% RETURNING HERE THE MINIMAL VALUE

min_value([(X1,Y1)/H1 , (X2,Y2)/H2 | L_H ], MIN_UNKNOW ) :- 
      H1 =< H2, 
      min_value([(X1,Y1)/H1 | L_H ], MIN_UNKNOW ). 
      
min_value([(X1,Y1)/H1 , (X2,Y2)/H2 | L_H ], MIN_UNKNOW ) :- 
      H1 > H2, 
      min_value([(X2,Y2)/H1 | L_H ], MIN_UNKNOW ).
 
 
%%% MY contribution and corrections    
%%% one_solution(Solution) :-
 main :-    
          start_point(X0,Y0),
          search_BEST_FS(X0,Y0, [(X0,Y0)],Path),
          reverse(Path, Solution),
          print(Solution),
          heuristic_sum(Solution, S),
          format("\n LOWEST SUM is: ~d", S) 
          .

%
% main :- findall(X, one_solution(X), L),
%         imp_lst(L).            
    


imp_lst([]).
imp_lst([Cabeca|Cauda]):- 
         format("\n A SOLUTION is:\n ~w", [Cabeca]), 
         imp_lst(Cauda).

%%% SUM of a PATH
heuristic_sum( [], 0 ).   
heuristic_sum([(X1,Y1)|L], S) :-
        end_point(X_d,Y_d),
        H1 is abs(X_d - X1) +    abs(Y_d - Y1),
        heuristic_sum( L, Partial ),
        S is H1 + Partial       
        .  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
%% STUDIES
%%%%%%%%%%
my_min_test([],_ ) :- print("\n empty list"). 
my_min_test([X] , X ):- !.
my_min_test([H1 , H2 | L_H ], Min ) :-
    H1 =< H2,
    my_min_test([H1 | L_H ], Min ).

my_min_test([H1 , H2 | L_H ], Min ) :- 
      H1 > H2, 
      my_min_test([H2 | L_H ], Min).

go :-my_min_test([3,4,1,6], X), print("\n X"), write(X).

/*
$ swipl -q -t main -f maze_DFS.pl 
A SOLUTION is:
 [ (0,0), (0,1), (1,1), (1,2), (1,3), (1,4), (2,4), (2,5), (3,5), (4,5)]
 A SOLUTION is:
 [ (0,0), (0,1), (1,1), (2,1), (3,1), (4,1), (5,1), (5,2), (5,3), (5,4), (5,5), (4,5)]
 A SOLUTION is:
 [ (0,0), (0,1), (1,1), (2,1), (3,1), (4,1), (5,1), (5,2), (5,3), (5,4), (4,4), (4,5)]
*/

go2 :- heuristic_sum( [ (0,0), (0,1), (1,1), (1,2), (1,3), (1,4), (2,4), (2,5), (3,5), (4,5)]
, S1 ),
   
heuristic_sum([(0,0), (0,1), (1,1), (2,1), (3,1), (4,1), (5,1), (5,2), (5,3), (5,4), (5,5), (4,5)]  
, S2 ),

heuristic_sum( [ (0,0), (0,1), (1,1), (2,1), (3,1), (4,1), (5,1), (5,2), (5,3), (5,4), (4,4), (4,5)]
, S3 ),
format("\n S1: ~d ", S1),
format("\n S2: ~d", S2),
format("\n S3: ~d", S3).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
