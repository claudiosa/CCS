:-lib(ic).

%%Array de casas para verificacao na restricao de pulo
places([](1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)).

%%É necessário enumerar todos os 76 movimentos possíveis no jogo (casaOrigem, casaIntermediaria, casaDestino)
enumMoves([]((1,2,4),(1,3,6),(2,4,7),(2,5,9),(3,5,8),(3,6,10),(4,7,11),(4,8,13),(4,5,6),(5,8,12),(5,9,14),(6,9,13),(6,10,15),(6,5,4),(6,3,1),(4,2,1),(7,4,2),
(7,8,9),(8,5,3),(8,9,10),(9,5,2),(9,8,7),(10,6,3),(10,9,8),(11,7,4),(11,12,13),(12,8,5),(12,13,14),(13,8,4),(13,9,6),(13,12,11),(13,14,15),(14,9,5),(14,13,12),
(15,14,13),(15,10,6)
)
).


exclude(0,Y,Y).
exclude(A,[A|Y], H) :- exclude(0,Y,H).
exclude(A,[X|Y],[X|H]) :- exclude(A,Y,H), !.

aux([X|_], X, I, I).
aux([_|T], E, I, R) :- I1 is I+1, aux(T, E, I1, R).

retornaElem(K, [X|_], K, X).
retornaElem(K, [_|T], I, R) :- I1 is I+1, retornaElem(K,T,I1,R).

concatenar([],L2,L2).
concatenar([X|T],L2,[X|L3]) :- concatenar(T,L2,L3).

getVazias(_,15,[]).
getVazias([0|T], S, [S|R]) :- S1 is S+1, getVazias(T,S1,R).
getVazias([_|T], S, R) :- S1 is S+1, getVazias(T,S1, R).

helpVazias(L,S,R) :- getVazias(L,S,R), !.

getMoves(_, _, 37, []).
getMoves(X, [(C1,C2,X)|H], I, [(C1,C2,X)|P]) :- I1 is I+1, getMoves(X,H,I1,P).
getMoves(X, [(_,_,_)|H], I, P) :- I1 is I+1, getMoves(X,H,I1,P).

ajudaGetMoves(A,C,D) :- enumMoves(Array),flatten_array(Array,B),getMoves(A,B,C,D).

pegarMoves([],[]).
pegarMoves([X|T], R1) :- ajudaGetMoves(X,1,F), pegarMoves(T, R), concatenar(F,R,R1), !. 

delMoves(_, [], []).
delMoves(X, [(X,_,_)|H], R) :- delMoves(X,H,R).
delMoves(X, [(_,X,_)|H], R) :- delMoves(X,H,R).
delMoves(X, [(C1,C2,C3)|H], [(C1,C2,C3)|R]) :- delMoves(X,H,R).

validarMoves([],R,R).
validarMoves([X|T],L,R2) :- delMoves(X,L,R1), validarMoves(T,R1,R2), !.

printBoard(L) :- write("- "), write("- "), retornaElem(26,L,1,AUX26),write(" "),write(AUX26),retornaElem(14,L,1,AUX14),write(" "),write(AUX14),retornaElem(27,L,1,AUX27),write(" "),write(AUX27),nl,
			write("- "), write("- "), retornaElem(18,L,1,AUX18),write(" "),write(AUX18),retornaElem(5,L,1,AUX5),write(" "),write(AUX5),retornaElem(19,L,1,AUX19),write(" "),write(AUX19),nl,
			retornaElem(33,L,1,AUX33),write(" "),write(AUX33),retornaElem(25,L,1,AUX25),write(" "),write(AUX25),retornaElem(1,L,1,AUX1),write(" "),write(AUX1),retornaElem(10,L,1,AUX10),write(" "),write(AUX10),retornaElem(2,L,1,AUX2),write(" "),write(AUX2),retornaElem(20,L,1,AUX20),write(" "),write(AUX20),retornaElem(28,L,1,AUX28),write(" "),write(AUX28),nl,
			retornaElem(17,L,1,AUX17),write(" "),write(AUX17),retornaElem(8,L,1,AUX8),write(" "),write(AUX8),retornaElem(9,L,1,AUX9),write(" "),write(AUX9),retornaElem(13,L,1,AUX13),write(" "),write(AUX13),retornaElem(11,L,1,AUX11),write(" "),write(AUX11),retornaElem(6,L,1,AUX6),write(" "),write(AUX6),retornaElem(15,L,1,AUX15),write(" "),write(AUX15),nl,
			retornaElem(32,L,1,AUX32),write(" "),write(AUX32),retornaElem(24,L,1,AUX24),write(" "),write(AUX24),retornaElem(4,L,1,AUX4),write(" "),write(AUX4),retornaElem(12,L,1,AUX12),write(" "),write(AUX12),retornaElem(3,L,1,AUX3),write(" "),write(AUX3),retornaElem(21,L,1,AUX21),write(" "),write(AUX21),retornaElem(29,L,1,AUX29),write(" "),write(AUX29),nl,
			write("- "), write("- "), retornaElem(23,L,1,AUX23),write(" "),write(AUX23),retornaElem(7,L,1,AUX7),write(" "),write(AUX7),retornaElem(22,L,1,AUX22),write(" "),write(AUX22),nl,
			write("- "), write("- "), retornaElem(31,L,1,AUX31),write(" "),write(AUX31),retornaElem(16,L,1,AUX16),write(" "),write(AUX16),retornaElem(30,L,1,AUX30),write(" "),write(AUX30),nl.


novo(LinBoard,C1,C2,C3,NewLinBoard) :- dim(NewLinBoardArray,[15]),  
					places(Array),				 
					flatten_array(Array,List),   
					exclude(C1,List, List1),	 
					exclude(C2,List1, List2),    
					exclude(C3,List2,List3),     
					dim(Places, [12]),			 
					flatten_array(Places,List3), 
					
					dim(LinBoardArray,[15]),				
					flatten_array(LinBoardArray, LinBoard),
					
					
					(for(T,1,12),
					 param(Places,LinBoardArray,NewLinBoardArray)
					 do
						arg(T,Places,Place),
						Aux is LinBoardArray[Place],
						X is NewLinBoardArray[Place],
						X is Aux
					),
										
					Q is NewLinBoardArray[C1],
					W is NewLinBoardArray[C2],
					E is NewLinBoardArray[C3],
					Q is 0,
					W is 0,
					E is 1,
					flatten_array(NewLinBoardArray,NewLinBoard).


inic :- 	
					N=15,
					length(LinBoard,N),
					LinBoard = [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
								
					busca(LinBoard, [LinBoard], [], L), writeln("Solucao":L),
					(foreach(Move,L)
					 do
						writeln("Move":Move)
					).

busca(LinBoard, [LinBoard|_], R, R) :- X is sum(LinBoard), X == 1. 

busca(LinBoard, [LinBoard|H], R, Sol) :- 	
					%%writeln(" "),
					%%Soma is 33-sum(LinBoard),
					%%writeln("RODADA":Soma),					
					%%printBoard(LinBoard),
					
					%%1- Pegar as casas vazias
					helpVazias(LinBoard,1,EmptyHouses),
					
					%%2- De acordo com as casas vazias, pegar os movimentos possíveis
					pegarMoves(EmptyHouses,PossibleMoves1),
					
					%%3- Exclui os movimentos que ainda são impossiveis (C1,C2,C3) com C1 ou C2 vazios
					validarMoves(EmptyHouses, PossibleMoves1,PossibleMoves),
					%%writeln("PossibleMoves 1":PossibleMoves),	

					%%4- Com a lista de movimentos possíveis, basta escolher um deles 
					member((C1,C2,C3),PossibleMoves),
					
					%%writeln("RODADA":Soma),
					%%writeln("PossibleMoves":PossibleMoves),	
					
					novo(LinBoard,C1,C2,C3,NewLinBoard),				
					
					%%writeln("Movimento:":C1:C2:C3),
					
					busca(NewLinBoard, [NewLinBoard,LinBoard|H], [(C1,C2,C3)|R],Sol)
					.
