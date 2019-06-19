

%%% INITIAL CODE FROM https://stackoverflow.com/questions/16076778/prolog-maze-solving-algorithm
%%% good IDEA for a Maze or graphs problem

w(0,0).
w(0,1). w(1,1). w(2,1). w(3,1). w(4,1). w(5,1).
        w(1,2).         w(3,2).         w(5,2).
        w(1,3).         w(3,3).         w(5,3).
w(0,4). w(1,4). w(2,4).         w(4,4). w(5,4).
                w(2,5). w(3,5). w(4,5). w(5,5).

%%% Add by CCS
start_point(0,0). %%% departure 
end_point(4,5). %% arrival


%%%% GREAT IDEA 
d(X0,Y0,X,Y) :- next_w(X0,Y0,X,Y), w(X,Y).
%%% ONLY ALLOWED MOVEMENTS
next_w(X0,Y0,X0,Y) :- Y is Y0+1. %%% RIGHT 
next_w(X0,Y0,X,Y0) :- X is X0+1. %%% DOWN
next_w(X0,Y0,X0,Y) :- Y is Y0-1. %%% LEFT
next_w(X0,Y0,X,Y0) :- X is X0-1. %%% UP
%%% PERFORMANCE

%search_DFS(X,Y,X,Y,Path,Path).
search_DFS(X,Y,Path,Path) :-
           end_point(X,Y).
           %,
           %format("\n FOUND A SOLUTION\n").

search_DFS(X0,Y0,SoFar,Path) :-
    d(X0,Y0,X1,Y1),
    \+ member(  (X1,Y1) , SoFar ),
    search_DFS(X1,Y1,[ (X1,Y1)|SoFar],Path).
    
%%% MY contribution and corrections    
one_solution(Solution) :-
    
          start_point(X0,Y0),
          search_DFS(X0,Y0, [(X0,Y0)],Path),
          reverse(Path, Solution).
          %,   write(Solution).

 main :- findall(X, one_solution(X), L),
         imp_lst(L).            
    


imp_lst([]).
imp_lst([Cabeca|Cauda]):- 
         format("\n A SOLUTION is:\n ~w", [Cabeca]), 
         imp_lst(Cauda).

%%%%%%%%%%%%          
