:- lib(ic). 

w_b :- write('  ').

/* exemplo 4.6 do livro do Apt */
exec :-
    /* VARIAVEIS E DOMINIOS */
        /* [X,Y] :: 1 .. 3,    ou  */
    [X] :: [1 .. 3], 
    [Y] :: [1, 2, 4], 
    [Z]  :: [1, 2],
    [U]  :: [2],
    get_domain(X,Dx),    get_domain(Y,Dy),
    get_domain(Z,Dz),    get_domain(U,Du),
    nl, write(Dx), w_b,    write(Dy), w_b, 
         write(Dz), w_b,     write(Du),
    /* POSTANDO AS RESTRICOES */
     X  #= Y,
     Y  #\=  Z,
     U  #\=  Z,
 /* 
    get_domain(X,Dx),    get_domain(Y,Dy),
    get_domain(Z,Dz),    get_domain(U,Du),
    nl, write(Dx), w_b,    write(Dy), w_b, 
         write(Dz), w_b,     write(Du),
*/
    /* PROPAGACAO E RAMIFICACAO */    
        labeling([X,Y,Z,U]),
        nl,  write(X), w_b,    write(Y), w_b, 
        write(Z), w_b,     write(U).

/*
Saida:    
1 .. 3  [1, 2, 4]  [1, 2]  2
2  2  1  2
*/

