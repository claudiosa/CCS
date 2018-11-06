dim(10,10).

/*tab([robo(a,2/1), robo(b,1/1), robo(c, 4/1), robo(d,6/1)]).*/

caminho(Nodo_inicial, Solucao):-
        busca([Nodo_inicial] ,   Tabuleiro_inicial,  Solucao),!.
caminho(_,_) :- nl, write('Sem solução ... caminho não encontrado!').

busca( [ No_final | Caminho] , Tabuleiro_corrente,  [No_final|Caminho]):-
           condicao de termino...,No_final !. %% termina a busca...
   
	   
busca( [Nodo|Caminho],  Tabuleiro_corrente, Solucao):-
         movimentos.... 
         not( member(Novo_nodo,[Nodo|Caminho])),
         busca( [Novo_nodo , Nodo | Caminho ] , Tabuleiro_corrente,  Solucao).


mov ... :- direita ...!.
mov ... :- esquerda ..!.
mov ... :- cima ..!.
mov ... :- baixo ..!.
mov ... :- erro...encurraldo.


direita(robo(N,X/Y) , robo(N,Xn/Y)):-
	dim(Tx , _),
	X \== Tx,
	vizinho_direita(X/Y , [robo(a,2/1), robo(b,1/1), robo(c, 4/1), robo(d,6/1)] , []),
	busca_direita(X/Y, [robo(a,2/1), robo(b,1/1), robo(c, 4/1), robo(d,6/1)] , Lx),
	minx(Lx , Xn).
	
direita(robo(N,X/Y) , robo(N,Xn/Y)):-
	dim(Tx , _),
	........
	X \== Tx,
	vizinho_direita(X/Y , [robo(a,2/1), robo(b,1/1), robo(c, 4/1), robo(d,6/1)] , []),
	busca_direita(X/Y, [robo(a,2/1), robo(b,1/1), robo(c, 4/1), robo(d,6/1)] , Lx),
	minx(Lx , Xn).
		
vizinho_direita(X/Y , [robo(N1,X1/Y1)|L] , robo(Nv,Xv/Yv)):- 
	Y == Y1,
	K is (X1-1),
	X == K,
	Nv is N1,
	Xv is X1,
	Yv is Y1,!.
vizinho_direita( X/Y , [_ | L] , Vizinho):- vizinho_direita( X/Y, L, Vizinho).
 
/* busca_direita -> nao concluido*/

busca_direita(X/Y , [robo(N1,X1/Y1)|L] , robo(N1,X1/Y1)):- 
	Y == Y1,
	K is (X1-2),
	X <= K,!.
busca_direita( X/Y , [_ | L] , Direita):- busca_direita( X/Y, L, Direita).

minx(X/Y , [] , 0) :- !.
minx(X/Y , [robo(_,X1/Y1)] , X1 ) :- Y == Y1, !.
minx(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2)], X1  ) :- Y == Y1, Y == Y2, X1 < X2 , !.
minx(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2)], X2 ) :- Y == Y1, Y == Y2, X1 > X2 , !.
minx(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2) | L] , M):- Y == Y1, Y == Y2, X1 < X2,  minx(X/Y , [robo(R1,X1/Y1) | R] , M).
minx(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2) | L] , M):- Y == Y1, Y == Y2, minx(X/Y , [robo(R2,X2/Y2) | R ] , M).

esquerda(robo(N,X/Y) , robo(N,Xn/Y)):-
	tab(W),
	X \== 1,
	vizinho_esquerda(X/Y , W , []),
	busca_esquerda(X/Y, W , Lx),
	maxx(Lx , Xn).

vizinho_esquerda(_ , [], []).
vizinho_esquerda(X/Y , [robo(N1,X1/Y1)|L] , robo(Nv,Xv/Yv)):- 
	Y == Y1,
	K is (X1+1),
	X == K,
	Nv is N1,
	Xv is X1,
	Yv is Y1,!.
vizinho_esquerda( X/Y , [_ | L] , Vizinho):- vizinho_esquerda( X/Y, L, Vizinho).
 

/* busca_esquerda -> nao concluido*/

busca_esquerda(X/Y , [robo(N1,X1/Y1)|L] , robo(N1,X1/Y1)):- 
	Y == Y1,
	K is (X1+2),
	X >= K,!.
busca_esquerda( X/Y , [_ | L] , Esquerda):- busca_esquerda( X/Y, L, Esquerda).


maxx(X/Y , [] , 0) :- !.
maxx(X/Y , [robo(_,X1/Y1)] , X1 ) :- Y == Y1, !.
maxx(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2)] , X1  ) :- Y == Y1, Y == Y2, X1 > X2, !.
maxx(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2)] , X2 ) :- Y == Y2, Y == Y2, X1 < X2, !.
maxx(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2) | L] , M):- Y ==1, Y == Y2, X1 > X2,  maxx(X/Y , [robo(R1,X1/Y1) | R] , M).
maxx(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2) | L] , M):- maxx(X/Y , [robo(R2,X2/Y2) | R ] , M).

sobe(robo(N,X/Y) , robo(N,X/Yn)):-
	dim(_ , TY),
	X \== TY,
	vizinho_superior(X/Y , TC , []),
	busca_superior(X/Y, TC , Ly),
	miny(Ly , Yn).

vizinho_superior(_ , [], []).	
vizinho_superior(X/Y , [robo(N1,X1/Y1)|L] , robo(Nv,Xv/Yv)):- 
	X == Y1,
	K is (Y1-1),
	Y == K,
	Nv = N1,
	Xv = X1,
	Yv = Y1,!.
vizinho_superior( X/Y , [_ | L] , Vizinho):- vizinho_superior( X/Y, L, Vizinho).
 
/* busca_superior -> nao concluido*/

busca_superior(X/Y , [robo(N1,X1/Y1)|L] , Ly):- 
	X == X1,
	K is (Y1-2),
	Y == K,
	adiciona(robo(N1,X1/Y1), Ly),!.

miny(X/Y , [] , 0) :- !.
miny(X/Y , [robo(_,X1/Y1)] , Y1 ) :- X == X1, !.
miny(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2)], Y1  ) :- X == X1, X == X2, Y1 < Y2 , !.
miny(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2)], Y2 ) :- X == X1, X == X2, Y1 > Y2 , !.
miny(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2) | L] , M):- X == X1, X == X2, Y1 < Y2,  miny(X/Y , [robo(R1,X1/Y1) | R] , M).
miny(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2) | L] , M):- X == X1, X == X2, miny(X/Y , [robo(R2,X2/Y2) | R ] , M).

desce(robo(N,X/Y) , robo(N,X/Yn)):-
	Y \== 1,
	vizinho_inferior(X/Y , TC , []),
	busca_inferior(X/Y, TC , Ly),
	maxy(Ly , Yn).

/* busca_inferior -> nao concluido*/

busca_inferior(X/Y , [robo(N1,X1/Y1)|L] , Ly):- 
	X == X1,
	K is (Y1+2),
	Y == K,
	adiciona(robo(N1,X1/Y1), Ly),!.

vizinho_inferior(_ , [], []).	
vizinho_inferior(X/Y , [robo(N1,X1/Y1)|L] , robo(Nv,Xv/Yv)):- 
	X == Y1,
	K is (Y1+11),
	Y == K,
	Nv = N1,
	Xv = X1,
	Yv = Y1,!.
vizinho_inferior( X/Y , [_ | L] , Vizinho):- vizinho_inferior( X/Y, L, Vizinho).

maxy(X/Y , [] , 0) :- !.
maxy(X/Y , [robo(_,X1/Y1)] , Y1 ) :- X == X1, !.
maxy(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2)] , Y1  ) :- X == X1, X == X2, Y1 > Y2, !.
maxy(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2)] , Y2 ) :- X == X2, X == X2, Y1 < Y2, !.
maxy(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2) | L] , M):- X == X1, X == X2, Y1 > Y2,  maxy(X/Y , [robo(R1,X1/Y1) | R] , M).
maxy(X/Y , [robo(R1,X1/Y1) , robo(R2,X2/Y2) | L] , M):- maxy(X/Y , [robo(R2,X2/Y2) | R ], M).
