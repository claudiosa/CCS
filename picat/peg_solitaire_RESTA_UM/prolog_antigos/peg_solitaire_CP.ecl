:-lib(ic).

%%Array de casas para verificacao na restricao de pulo
places([](1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)).

%%� necess�rio enumerar todos os 36 movimentos poss�veis no jogo (casaOrigem, casaIntermediaria, casaDestino)
enumMoves([]((1,2,4),(1,3,6),(2,4,7),(2,5,9),(3,5,8),(3,6,10),(4,7,11),(4,8,13),(4,5,6),(5,8,12),(5,9,14),(6,9,13),(6,10,15),(6,5,4),(6,3,1),(4,2,1),(7,4,2),
(7,8,9),(8,5,3),(8,9,10),(9,5,2),(9,8,7),(10,6,3),(10,9,8),(11,7,4),(11,12,13),(12,8,5),(12,13,14),(13,8,4),(13,9,6),(13,12,11),(13,14,15),(14,9,5),(14,13,12),
(15,14,13),(15,10,6))
).

exclude(0,Y,Y).
exclude(A,[A|Y], H) :- exclude(0,Y,H).
exclude(A,[X|Y],[X|H]) :- exclude(A,Y,H), !.

aux([X|T], X, I, I).
aux([X|T], E, I, R) :- I1 is I+1, aux(T, E, I1, R).

movPos((C1,C2,C3), R) :- enumMoves(Array), flatten_array(Array,List), aux(List,(C1,C2,C3), 1, R).
							
elemPos(Array, X, R) :- Line is Array[X,1..36],aux(Line, 1, 1, R).

retornaElem(K, [X|T], K, X).
retornaElem(K, [X|T], I, R) :- I1 is I+1, retornaElem(K,T,I1,R).

concatenar([],L2,L2).
concatenar([X|T],L2,[X|L3]) :- concatenar(T,L2,L3).

getVazias(_,16,[]).
getVazias([0|T], S, [S|R]) :- S1 is S+1, getVazias(T,S1,R).
getVazias([X|T], S, R) :- S1 is S+1, getVazias(T,S1, R).

helpVazias(L,S,R) :- getVazias(L,S,R), !.

getMoves(_, _, 37, []).
getMoves(X, [(C1,C2,X)|H], I, [(C1,C2,X)|P]) :- I1 is I+1, getMoves(X,H,I1,P).
getMoves(X, [(C1,C2,C3)|H], I, P) :- I1 is I+1, getMoves(X,H,I1,P).

ajudaGetMoves(A,C,D) :- enumMoves(Array),flatten_array(Array,B),getMoves(A,B,C,D).

pegarMoves([],[]).
pegarMoves([X|T], R1) :- ajudaGetMoves(X,1,F), pegarMoves(T, R), concatenar(F,R,R1), !. 

delMoves(_, [], []).
delMoves(X, [(X,C2,C3)|H], R) :- delMoves(X,H,R).
delMoves(X, [(C1,X,C3)|H], R) :- delMoves(X,H,R).
delMoves(X, [(C1,C2,C3)|H], [(C1,C2,C3)|R]) :- delMoves(X,H,R).

validarMoves([],R,R).
validarMoves([X|T],L,R2) :- delMoves(X,L,R1), validarMoves(T,R1,R2), !.

peg_solitaire :- 	
					dim(Board,[14,15]),
					Board :: 0 .. 1,
					
					(for(I,2,15),
					 param(Board)
					 do
						Board[1,I] #= 1
					),
					
					Board[1,1] #= 0,
					
					dim(Moves,[13,36]),
					Moves :: 0 .. 1,
					
					dim(Equal,[13,15]),
					Equal :: 0 .. 1,
					
					(for(T,1,13),
					 param(Moves)
					 do
						LineMoves is Moves[T,1..36],
						sum(LineMoves) #= 1
					),
					
					(for(T,1,14),
					 param(Board)
					 do
						LineBoard is Board[T,1..15],
						sum(LineBoard) #= 15-T
					),
					
					(for(A,1,13),
					 param(Equal,Board)
					 do
						A1 #= A+1,
						(for(B,1,15),
						 param(Equal,Board,A1,A)
						 do
							Equal[A,B] #= (Board[A,B] #= Board[A1,B])
						)
					),
					
					(for(T,1,13),
					 param(Board,Moves,Equal)
					 do
						
						LinBoard is Board[T,1..15],
						
						%%1- Pegar as casas vazias
						helpVazias(LinBoard,1,EmptyHouses),						
						
						%%2- De acordo com as casas vazias, pegar os movimentos poss�veis
						pegarMoves(EmptyHouses,PossibleMoves1),
						
						%%3- Exclui os movimentos que ainda s�o impossiveis (C1,C2,C3) com C1 ou C2 vazios
						validarMoves(EmptyHouses, PossibleMoves1,PossibleMoves),	
						
						%%4- Com a lista de movimentos poss�veis, basta escolher um deles 
						member((C1,C2,C3),PossibleMoves),
						
						%%5- Escolhido o movimento, pegar o index real no array Moves (array est� interno na fun��o, nao precisa passar por parametro)
						movPos((C1,C2,C3),M),
						Board[T+1,C1] #= 0,
						Board[T+1,C2] #= 0,
						Board[T+1,C3] #= 1,
						
						AUX1 #= Board[T,C1],
						AUX2 #\= Board[T+1,C1],
						AUX3 #= Board[T,C2],
						AUX4 #\=Board[T+1,C2],
						AUX5 #\= Board[T,C3],
						AUX6 #=Board[T+1,C3],
						
						AUX1 #= (AUX2 #= (AUX3 #= (AUX4 #= (AUX5 #= (AUX6 #= 1))))),
						
						Moves[T,M] #= AUX6,
						
						places(Array),
						flatten_array(Array,List),
						exclude(C1,List, List1),
						exclude(C2,List1, List2),
						exclude(C3,List2,List3),
						dim(Places, [12]),
						flatten_array(Places,List3),
						
						(for(L,1,12),
						 param(Places,Moves,Equal,M,T)
						 do
							arg(L,Places,P),
							Equal[T,P] #= (Moves[T,M] #= 1)
						)
						
					),
					
					flatten_array(Board,BList),
					flatten_array(Moves,MList),
					flatten_array(Equal,EList),
									
					concatenar(BList,MList,L1),
					concatenar(EList,L1,L),
					
					search(L, 0 , first_fail, indomain, complete, [backtrack(Backtracks)] ),
					
					enumMoves(Array),
					
					(for(X,1,13),
					 param(Moves,Array)
					 do
						elemPos(Moves,X,R),
						
						arg(R,Array,(K1,K2,K3)),
						writeln("PASSO " :X),
						writeln("Origem:" :K1 :"Intermediario:" :K2 :"Destino" :K3)
					).
