%%% A - star: f = g + h
%%% BEST : f = g (heuristic to the END)
%%% IMPLEMENT BREADTH FIRST ALGORITHM
%%% Problem: find the best path
%%% swipl -q -t main -f maze_BREADTH_FS.pl 
%%% INITIAL CODE FROM https://stackoverflow.com/questions/16076778/prolog-maze-solving-algorithm
%%% good IDEA for a Maze or graphs problem

%%% THIS IDEA is cool
/*
w(0,0). w(1,0).
w(0,1). w(1,1). w(2,1). w(3,1). w(4,1). w(5,1).
        w(1,2).         w(3,2).         w(5,2).
        w(1,3).         w(3,3).         w(5,3).
w(0,4). w(1,4). w(2,4).         w(4,4). w(5,4).
                w(2,5). w(3,5). w(4,5). w(5,5).

%%% Add by CCS
start_point(0,0). %%% departure, initial ... 
end_point(4,5). %% arrival, exit, end ...

*/


%%% Bad enviroment
w(0,0). w(1,0). w(2,0). w(3,0). w(4,0). w(5,0). 
w(0,1).                                 w(5,1). 
w(0,2). w(1,2). w(2,2). w(3,2).         w(5,2).
w(0,3). w(1,3). w(2,3). w(3,3).         w(5,3).
w(0,4). w(1,4). w(2,4). w(3,4).         w(5,4).
w(0,5). w(1,5). w(2,5). w(3,5).         w(5,5).

%%% Add by CCS
start_point(0,5). %%% departure, initial ... 
end_point(5,5). %% arrival, exit, end ...


%%%% GREAT IDEA 
%%% there is conection if ... next_w ... and new w(X,Y) must be true or valid.
%%% failure in the rule .. not by tail.
d(X0,Y0,X,Y) :- next_w(X0,Y0,X,Y), w(X,Y).
%%% ONLY ALLOWED MOVEMENTS
next_w(X0,Y0,X0,Y) :- Y is Y0+1. %%% RIGHT 
next_w(X0,Y0,X,Y0) :- X is X0+1. %%% DOWN
next_w(X0,Y0,X0,Y) :- Y is Y0-1. %%% LEFT
next_w(X0,Y0,X,Y0) :- X is X0-1. %%% UP
%%% PERFORMANCE
 
 
%%% MY contribution and corrections    
main :- findall(X, one_solution(X), L),
        imp_lst(L).            

%%%  one_solution(Solution) :-    %%% uncomment to use the main

best_sol :-
          start_point(X0,Y0),
          %%%  NODE  OPEN CLOSE, SOL
          search_BREADTH_FS( [[ (X0,Y0) ]],  Path),
          %%% LIST OF LIST ... many possible paths will be explored
          reverse(Path, Solution),
          print(Solution),
          format("\n =============================").

%%% KERNEL of SEARCH
search_BREADTH_FS([ [(X,Y)| BEST_Path] | _ ] , [(X,Y) | BEST_Path ] ):-
        end_point(X,Y),
        format("\n FOUND A SOLUTION\n"), 
        !. %% 

%%% CURR_NODE --- a sequence of nodes ... by level
%%% [ CURR_NODE  | L_CLOSED ] = [ [ path1 ],[ path2 ],[ ],[ ],[path-n ]]
search_BREADTH_FS( [ CURR_NODE  | L_CLOSED ], SOL ) :-
    
    expand_current_node(  CURR_NODE , Expanded_NODE ),
%%% A queue here appended ... LISTS of LISTS ... many paths   
    append( L_CLOSED, Expanded_NODE, L_OPEN_NEW ),
%% NEIGHBOURG NEW
% format("\n CURR_NODE_L: ~w\t OPEN_NEW: \t ~w CLOSED: ~w \n", [ CURR_NODE , L_OPEN_NEW, L_CLOSED ]),
% format("\n LISTS_of_LISTS_OPEN_NEW: ~w ", [ L_OPEN_NEW ]),
    search_BREADTH_FS( L_OPEN_NEW , SOL).
 %%% a list of list with all possible paths in this transversal tree by level


expand_current_node( [ (X0,Y0) | L_CLOSE ], L_Expanded) :-
  findall(
       [(X1,Y1), (X0,Y0) | L_CLOSE ],
     ( 
       d(X0,Y0, X1,Y1) , %%% conection or next movement
       not( member( (X1,Y1) , [ (X0,Y0) | L_CLOSE ]) )
      ),
      L_Expanded
    )
    , 
    %%%% ultima linha do findall 
     format("\n [Xc,Yc]: [~w,~w]", [X0,Y0]),
     format("==> Expanded :: ~w", [L_Expanded ] )
     , 
    
     !. 
     
%%% expande e adiciona TODOS NAO VISITADOS AINDA
expand_current_node(_,[]):- !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% end of KERNEL 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imp_lst([]).
imp_lst([Cabeca|Cauda]):- 
         format("\n A SOLUTION is:\n ~w", [Cabeca]), 
         imp_lst(Cauda).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
