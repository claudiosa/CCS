
eh_UM_triang(X,Y,Z) :-
		(X>0, Y >0, Z>0),
        (        
        ( X+Y >= Z  ,  Z >= X  ,  Z >= Y    );
        (X+Z >= Y  ,   Y >= X  ,  Y >= Z    );
        (Z+Y >= X  ,   X >= Y  ,  X >= Z    )
        ),
		write("TRIANG VALIDO").
eh_UM_triang( _, _,_ ) :-
 write("NAO FORMA UM TRIANGULO").
/* eh um triang,
    eh escaleno OU
    eh isoceles OU
    eh equilatero
*/    
tipo(X,Y,Z) :-
       eh_UM_triang(X,Y,Z),
		(
		  ( X \== Y,
		    X \== Z,
		    Y \== Z ,
		    write("ESCALENO")
		    );
		(((X == Y,  X \== Z ) ;
		    (X == Z, X \== Y) ;
		    (Y == Z, X \== Y))
		   ,
		   write("ISOSCELES")
		  );
		 ( X == Y,
		    X == Z,
		    write("EQUILATERO")
		   )
		  ).

tipo( _, _,_ ). %% RETORNA COM TRUE

x :- resultado(X,Y),
       writeln("xX yY" : X : Y).
aluno(ignacio,3.5).
aluno(newton,7.5).
aluno(einstein, 8.0).
aluno(dilma, 2.0).
resultado(X,aprovado) :- aluno(X,Y),
                                            Y >= 7 .
resultado(X,reprovado) :- aluno(X,Y),
                                             Y < 3 .
resultado(X,exame) :- aluno(X,Y),
                                     Y >= 3 ,
                                      Y < 7 .		
