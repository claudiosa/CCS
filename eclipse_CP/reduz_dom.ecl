

/* CUIDAR com Dx1 != Dx2 ...... Dxn */

mod1([X, Y, Z]) :-
    % Variaveis = [X,Y,Z],
	% Variaveis :: 0 .. 100,
    X :: 0 .. 100,
    Y :: 0 .. 100,
    Z :: 0 .. 100,
    
    X + Y + Z  #=< 8,
    
    nl,
    nl,
    write('after R1'),
    nl,    
    
    get_domain(X, Dx1), nl, write( dx_dominioDX: Dx1),
    get_domain(Y, Dy1), nl, write( dy_dominioDY: Dy1),
    get_domain(Z, Dz1), nl, write( dz_dominioDZ: Dz1),    

    X - Y + (2 * Z) #>= 2, 

    nl,
    nl,
    write('after R2'),
    nl,    

    get_domain(X, Dx2), nl, write( dx_dominioDX: Dx2),
    get_domain(Y, Dy2), nl, write( dy_dominioDY: Dy2),
    get_domain(Z, Dz2), nl, write( dz_dominioDZ: Dz2),
        
    X + (4 * Y) - Z #>= 16,

    nl,
    nl,
    write('after R3'),
    nl,    

    get_domain(X, Dx3), nl, write( dx_dominioDX: Dx3),
    get_domain(Y, Dy3), nl, write( dy_dominioDY: Dy3),
    get_domain(Z, Dz3), nl, write( dz_dominioDZ: Dz3),    
    
    ((-1) * X) + (4 * Y) - (4 * Z) #>= 3,
    
    nl,
    nl,
    write('after R4'),
    nl,        
    
    get_domain(X, Dx4), nl, write( dx_dominioDX: Dx4),
    get_domain(Y, Dy4), nl, write( dy_dominioDY: Dy4),
    get_domain(Z, Dz4), nl, write( dz_dominioDZ: Dz4),    
    
    (4 * X) - (3 * Y) + (8 * Z) #=< 16,

    nl,
    nl,
    write('after R5'),
    nl,        
    
    get_domain(X, Dx5), nl, write( dx_dominioDX: Dx5),
    get_domain(Y, Dy5), nl, write( dy_dominioDY: Dy5),
    get_domain(Z, Dz5), nl, write( dz_dominioDZ: Dz5),    
    
    nl,
    nl,
    search([X,Y,Z], 0, first_fail, indomain, complete, []),
    printf("X: %w Y: %w Z: %w \n", [X,Y,Z]).
 
/******************************************************/
