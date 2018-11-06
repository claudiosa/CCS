/*Marcio Antonio Scopel
Ordenar Vetor de Elementos.*/

bolha(L, Lordenada) :- trocar(L, L1), !, bolha(L1, Lordenada).
bolha(Lordenada, Lordenada). 
trocar([A,B|Cauda], [B,A|Cauda]):- A > B.
/*Se elemento 1 for maior que elemento 2 entao troca elementos*/ 
trocar([C|L2], [C|L3]):-trocar(L2, L3). 
/*Recursividade para fazer a troca até o ultimo elemento*/
