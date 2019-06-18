

%%% INITIAL CODE FROM https://stackoverflow.com/questions/16076778/prolog-maze-solving-algorithm
w(0,0).
w(0,1). w(1,1). w(2,1). w(3,1). w(4,1). w(5,1).
        w(1,2).         w(3,2).         w(5,2).
        w(1,3).         w(3,3).         w(5,3).
w(0,4). w(1,4). w(2,4).         w(4,4). w(5,4).
                w(2,5). w(3,5). w(4,5).

d(X0,Y0,X,Y) :- next_w(X0,Y0,X,Y), w(X,Y).
next_w(X0,Y0,X0,Y) :- Y is Y0+1.
next_w(X0,Y0,X,Y0) :- X is X0+1.
next_w(X0,Y0,X0,Y) :- Y is Y0-1.
next_w(X0,Y0,X,Y0) :- X is X0-1.

go(X,Y,X,Y,Path,Path).
go(X0,Y0,X,Y,SoFar,Path) :-
    d(X0,Y0,X1,Y1),
    \+ member( w(X1,Y1), SoFar ),
    go(X1,Y1,X,Y,[w(X1,Y1)|SoFar],Path).
    
%%% MY contribution and corrections    
    main :-
    
          start(X,Y0),
          finish
          TO BE ENDED
%%%%%%%%%%%%          
