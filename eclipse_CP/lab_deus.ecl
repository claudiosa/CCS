% Comentario 
go1 :- homem(NOME), write(NOME), nl, fail.
go1 :- true.

% fatos: antonio ... sao homens
homem(antonio) .
homem(pedro) .
homem(joao) .

% adicionando fatos na historia*
deuses(zeus).
deuses(minerva).
/*
% fato com 2 argumentos
*/

idade(  antonio , 35).
idade(  pedro , 38).

cabelo(antonio , preto).
cabelo(pedro , loiro).


go2 :- mortal(NOME, IDADE, CABELO),
	   writeln("nome idade cabelo" : NOME : IDADE : CABELO),
	   fail.
go2:- true.



 	   
%% Determinar quem eh mortal
mortal(   X,Y,Z  )   :- 
     homem(X)   ,    /* F1 and */
     idade(X,Y) ,   /* F2 and */ 
     cabelo(X,Z)   /* F3 . */
     .  %%% termina aqui

/* Ilustrando o ou */	
ou(X,Y,1) :-
		(X == 1 ; Y == 1).
ou(X,Y,0) :-
		(X == 0 , Y == 0).
	
/* Ilustrando o ou-exclusivo */		
		
my_xor(X,Y,1) :- X \== Y  .
my_xor(X,X,0) .


/* homen(x) -> mortal(x) */

x(7).
x(5).
x(3).


par( Xpar ) :- 
	x(N1 ) , 
	x(N2) , 
	N1 =\= N2 , 
	Xpar is (N1+N2) , %% only for numbers
	write(N1) ,
	write( ' .... ' ) ,
	write(N2) ,
	write( ' .... ' ) ,
	write( Xpar ) ,
	nl,
	fail
	.
