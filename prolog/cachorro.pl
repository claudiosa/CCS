

nome([N,_,_,_],N).
raca([_,R,_,_],R).
servico([_,_,S,_],S).
dia([_,_,_,D],D).

depois([_,_,_,D1],[_,_,_,D2]):- D1 > D2.
antes([_,_,_,D1],[_,_,_,D2]):- D1 < D2.	

apos_1dia([_,_,_,D1],[_,_,_,D2]):- D1 =:= D2+1.

diferente([]).
diferente([X|R]):- not(member(X,R)),diferente(R).

cliente(S):- 
	N1 = garboso,
	N2 = soneca,
	N3 = sultao,
	N4 = totó,
	N5 = vigilante,

permutation([R1,R2,R3,R4,R5],[afghan, boxer, bulldog, collie, poodle]),
permutation([S1,S2,S3,S4,S5],[orelhas, pulgas, unhas, dentes, banho]),
permutation([D1,D2,D3,D4,D5],[2, 3, 4, 5, 6]),
S = [[N1,R1,S1,D1],[N2,R2,S2,D2],[N3,R3,S3,D3],[N4,R4,S4,D4],[N5,R5,S5,D5]],

/*Dica 1 */
member(COLLIE,S),
raca(COLLIE,collie),
member(SONECA,S),
nome(SONECA,soneca),
member(SEGUNDA,S),
dia(SEGUNDA,2),
diferente([SONECA,SEGUNDA]),
depois(COLLIE,SONECA),
member(DENTE,S),
servico(DENTE,dentes),
diferente([SONECA,DENTE]),

/* dica 2 */
member(BULLDOG,S),
raca(BULLDOG,bulldog),
/*
diferente([BULLDOG,SEGUNDA]),
*/
member(SULTAO,S),
nome(SULTAO,sultao),
apos_1dia(BULLDOG,SULTAO),
member(PULGAS,S),
servico(PULGAS,pulgas),
apos_1dia(PULGAS,BULLDOG), /*PULGAS foi um dia depois de BULLDOG */

/*dica 3*/

VIGILANTE = [vigilante,R5,S5,D5],
member(POODLE,S),
raca(POODLE,poodle),
member(SEXTA,S),
dia(SEXTA,6),
diferente([VIGILANTE,DENTE,POODLE,SEGUNDA,SEXTA]),

/*dica 4*/

member(AFGHAN,S),
raca(AFGHAN,afghan),
diferente([AFGHAN,SULTAO]),
member(BANHO,S),
servico(BANHO,banho),
member(ORELHA,S),
servico(ORELHA,orelhas),
diferente([AFGHAN,BANHO,ORELHA]),
GARBOSO = [garboso,R1,S1,D1],
diferente([ORELHA,GARBOSO]),


/* dica 5 */

member(BOXER,S),
raca(BOXER,boxer),
member(TOTO,S),
nome(TOTO,totó),
apos_1dia(BOXER,TOTO).














