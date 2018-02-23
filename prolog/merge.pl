/*Marcio Antonio Scopel
Merge, duas listas ordenadas concatenadas gerando uma 
terceira lista Ordenada*/

merge([X|L1],[Y|L2],[X|L]) :- X < Y,merge(L1,[Y|L2],L). /*Compara cada elemento da Lista1 com primeiro da lista 2*/
merge([X|L1],[X|L2],[X|L]) :- merge(L1,L2,L). 
merge([X|L1],[Y|L2],[X|L]) :- X > Y, merge([X|L1],L2,L). 
/*Compara cada elemento da Lista2 com o primeiro da lista 1*/
merge([],L,L). 
merge(L,[],L) :- L \= []. 
