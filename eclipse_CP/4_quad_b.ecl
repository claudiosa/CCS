:- lib(ic).

quad_2 :-
    [X] :: 1..11,
    [Y] :: 1..7,
    X #> 3,
    X #< 9,
    Y #> 2,
    Y #< 5,
    get_domain(X,Dx),
    get_domain(Y,Dy),
    get_min(X, MENOR),
    get_max(X, MAIOR),
    write("\n O dominio de X = "), write(Dx),
    write("\n O dominio de Y = "), write(Dy),
    write("\n O menor do novo dominio de X = "), write(MENOR),
    write("\n O maior do novo dominio de X = "), write(MAIOR).
