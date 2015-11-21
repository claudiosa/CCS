:- lib(ic). 

w_b :- write('  ').

/* exemplo 4.6 do livro do Apt - c ou III */
exec :-
    /* VARIAVEIS E DOMINIOS */
        /* [X,Y] :: 1 .. 3,    ou  */
    [X] :: [1, 2, 3], 
    [Y] :: [1, 2, 4], 
    [Z]  :: [3],
    get_domain(X,Dx),    get_domain(Y,Dy),
    get_domain(Z,Dz),    
    nl, write(Dx), w_b,    write(Dy), w_b, 
         write(Dz), w_b,    
    /* POSTANDO AS RESTRICOES */
     X  #= Y,
     Y  #\=  Z,
     X  #\=  Z,
     /* PROPAGACAO E RAMIFICACAO */    
        labeling([X,Y,Z]),
        nl,  write(X), w_b,  write(Y), w_b,  write(Z), 
       write('\n ........................................... ').
       
/*
Saida:    
?- exec, fail.
1 .. 3  [1, 2, 4]  3  
1  1  3
 ........................................... 
2  2  3
 ........................................... 

*/

