
:- lib(ic).

or_exc(X,Y,0) :- X #= Y.
or_exc(X,Y,1) :- X #\= Y.


go1 :-
    X #:: [1 .. 10], %% 4 ele
    get_domain(X, Dx1), 
    writeln( "dx_dominioDX" : Dx1), 
    
    X #< 8,
    get_domain(X, Dx2), 
    writeln( "dx_dominioDX" : Dx2), 
    
    X #> 2,
    get_domain(X, Dx3), 
    writeln( "dx_dominioDX" : Dx3), 
    %%%% CUIDAR Dx1 ... dar nomes diferentes devido o matching PROLOG
    
    search([X], 0, first_fail, indomain, complete, []),
    printf("X: %w ", [X]).


go2 :-
    X #:: [1 .. 4],  %% 4 ele
    Y #:: [3 , 4],   %% 2 ele
    Z #:: [2 .. 4],  %% 3 ele
    %X #< Y and X #< Z,
    get_domain(X, D1), 
    writeln("1 dx_dominioDX" : D1),
    X #< Y ,
    X #< Z ,
    get_domain(X, D2),  
    write( "2 dx_dominioDX" : D2), 
    %% Escolha da VAR
    %% Como pega o valor NO dom
    search([X,Y,Z], 0, first_fail, indomain, complete, []),
    printf("X: %w Y: %w Z: %w \n", [X,Y,Z]).
    
    /* 2a semana ...
x < y, x < z; x ∈ {1, 2, 3, 4}, y ∈ {3, 4}, z ∈ {2, 3, 4}

X: 1 Y: 3 Z: 2X: 1 Y: 3 Z: 3ex_reduz_dom.ecl compiled 1912 bytes in 0.00 seconds

first_fail
X: 1 Y: 3 Z: 2 
X: 1 Y: 3 Z: 3 
X: 1 Y: 3 Z: 4 
X: 2 Y: 3 Z: 3 
X: 2 Y: 3 Z: 4 
X: 1 Y: 4 Z: 2 
X: 1 Y: 4 Z: 3 
X: 1 Y: 4 Z: 4 
X: 2 Y: 4 Z: 3 
X: 2 Y: 4 Z: 4 
X: 3 Y: 4 Z: 4 
Y < X < Z

anti_first_fail
X: 1 Y: 3 Z: 2 
X: 1 Y: 4 Z: 2 
X: 1 Y: 3 Z: 3 
X: 1 Y: 4 Z: 3 
X: 1 Y: 3 Z: 4 
X: 1 Y: 4 Z: 4 
X: 2 Y: 3 Z: 3 
X: 2 Y: 3 Z: 4 
X: 2 Y: 4 Z: 3 
X: 2 Y: 4 Z: 4 
X: 3 Y: 4 Z: 4 
X < Z < Y
*/
