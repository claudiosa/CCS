:-lib(ic).
:-lib(ic_global).

patterns([](
           [](1, 1, 1, 1, 0, 0, 0),  %% line 1
           [](0, 1, 1, 1, 1, 0, 0), 
           [](0, 0, 1, 1, 1, 1, 0), 
           [](0, 0, 0, 1, 1, 1, 1),
           [](0, 0, 0, 0, 0, 0, 0)   %% line 5
          )
        ).  

go:-
    patterns(Array),
    dim(Array, [Line, Col]),
    dim(X_sol, [Col]),
    X_sol :: 0..1,
    writeln("Array": Array),
    writeln("X_sol": X_sol),
    
    /*
     %%It's work
    (for(I, 1, Col),
      param(Array,X_sol) do
      (
        K is I,
        X_sol[K] #= Array[2, K]
       )
     ), 
     
     
      Something   like
      X_sol[1 .. Col] #= Array[1, 1 .. Col]
      or
      X_sol[1 .. Col] #= Array[2, 1 .. Col]
      or
      X_sol[1 .. Col] #= Array[3, 1 .. Col]
      or 
      .......
      X_sol[1 .. Col] #= Array[5, 1 .. Col]
     */   
      %% Imagine 1000 LINES
     (
       for(I, 1, Col),
       fromto(0, Prev, Curr, Expr), 
        param(Array,X_sol, Col) do
        ( K is I, 
          Curr #= (Prev or X_sol[1..Col] #= Array[K, 1..Col] ) 
         )
     ), 
     
    % length(Expr, N1),
    % writeln(n1: N1),
        
    %%table(X_sol, Array, Line),
      
    flatten_array( X_sol , L_X_sol),
    writeln("X_sol": L_X_sol),
    labeling(L_X_sol),
    writeln("L_X_sol": L_X_sol)
    .
    
    
% There is some Ix which is the index
% of Table and is X
%
table(X, Table,Ix) :-
        dim(Table,[_R,C]),
        dim(X, [Len]),
        Len = C,

        (for(I,1,Len), param(X,Table,Ix, C) do
             suspend(Table[Ix,I..C]  #=  X[I..C], 1 , Ix -> inst)
        ).
