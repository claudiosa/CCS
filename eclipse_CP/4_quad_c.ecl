:- lib(ic).

quad_1 :-
    [X] :: 1..11,      %% Dominios
    [Y] :: 1..7,
    X #> 3,   	       %% Restricoes
    X #< 9,
    Y #> 2,
    Y #< 5,
    (X + Y) #>= 8,
    (X + Y) #=< 10,
    get_domain(X,Dx),
    get_domain(Y,Dy),
    write("\n Novo dominio de X = ") , write(Dx),
    write("\n Novo dominio de Y = ") , write(Dy),

    labeling([Y,X]), %% fase da propagacao e busca
    printf("\n\n Possiveis solucoes: X: %d  Y:%d", [X,Y])
    .
    %%% Um ponto ao termino da clausula 
    %%% Construa a arvore de busca para:
    % labeling([X , Y])
    % labeling([Y , X]) 
    % Conclua este conhecimento sobre o search acima. 
    %


/*

    get_domain(X,Dx),
    get_domain(Y,Dy),
    write("\n Novo dominio de X = ") , write(Dx),
    write("\n Novo dominio de Y = ") , write(Dy),
    X #>= 7,  %% Novas Restricoes
    Y #=< 3,  %% Novas Restricoes

*/
 
