:- lib(ic). 

w_b :- write('  ').

/* exemplo 4.6 do livro do Apt - b*/
exec :-
    /* VARIAVEIS E DOMINIOS */
        /* [X,Y] :: 1 .. 3,    ou  */
    [X] :: [1, 3], 
    [Y] :: [ 2, 3, 4], 
    [Z]  :: [3],
    get_domain(X,Dx),    get_domain(Y,Dy),
    get_domain(Z,Dz),    
    nl, write(Dx), w_b,    write(Dy), w_b, 
         write(Dz), w_b,    
    /* POSTANDO AS RESTRICOES */
     X  #= Y,
     Y  #\=  Z,
     X  #\=  Z,
    write(' ........................................... '),
    get_domain(X,Dx),    get_domain(Y,Dy),
    get_domain(Z,Dz),    
    nl, write(Dx), w_b,    write(Dy), w_b, 
         write(Dz), w_b,    

    /* PROPAGACAO E RAMIFICACAO */    
        labeling([X,Y,Z]),
        nl,  write(X), w_b,    write(Y), w_b, 
        write(Z).

/*
Saida:    
1 .. 3  [1, 2, 4]  [1, 2]  2
2  2  1  2
*/

