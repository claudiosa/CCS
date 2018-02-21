/*Marcio Antonio Scopel
Inserir um elemento na N*/
inserir(X,1,Lista,[X|Lista])./*Condicao de parada*/
inserir(X,N,[Cabeca|Lista], [Cabeca|L]) :- N > 1, 
 N1 is (N-1),
 inserir(X,N1,Lista,L)./*Recursividade*/