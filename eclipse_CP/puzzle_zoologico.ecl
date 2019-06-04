/*	Lógica Matemática -- Turma B
	jhonatan izidoro*/
	

solucao([(girl1,M1,N1,S1,L1,A1,MT1),
		 (girl2,M2,N2,S2,L2,A2,MT2),
		 (girl3,M3,N3,S3,L3,A3,MT3),
		 (girl4,M4,N4,S4,L4,A4,MT4),
		 (girl5,M5,N5,S5,L5,A5,MT5)]):-
		 
bag(M1), bag(M2), bag(M3), bag(M4), bag(M5), 
alldifferent([M1, M2, M3, M4, M5]),
M1\==vermelho,
M2\==verde,
M3==amarelo,
M4==azul,
M5==branco,

name(N1), name(N2), name(N3),name(N4), name(N5), 
alldifferent([N1, N2, N3, N4, N5]),
N1==eliana,
N2\==marceli,
N3==maria,
N4==natalia,
N5\==taiz,

juice(S1), juice(S2), juice(S3), juice(S4),juice(S5), 
alldifferent([S1, S2, S3, S4, S5]),
S1\==laranja,
S2\==abacaxi,
S3\==morango,
S4==maracuja,
S5\==limao,

lunch(L1), lunch(L2), lunch(L3), lunch(L4), lunch(L5), 
alldifferent([L1, L2, L3, L4, L5]),
L1==banana,
L2==chocolate,
L3==salgadinho,
L4==maca,
L5==sanduiche,

animal(A1), animal(A2), animal(A3), animal(A4), animal(A5), 
alldifferent([A1, A2, A3, A4, A5]),
A1==elefante,
A2==arara,
A3==leao,
A4==girafa,
A5==macaco,

class(MT1), class(MT2), class(MT3), class(MT4), class(MT5), 
alldifferent([MT1, MT2, MT3, MT4, MT5]),
MT1==matematica,
MT2==historia,
MT3==geografia,
MT4==biologia,
MT5==portugues.

class(portugues).
class(historia).
class(geografia).
class(biologia).
class(matematica).

bag(verde).
bag(branco).
bag(amarelo).
bag(azul).
bag(vermelho).

name(eliana).
name(taiz).
name(natalia).
name(maria).
name(marceli).

juice(morango).
juice(laranja).
juice(limao).
juice(maracuja).
juice(abacaxi).

lunch(banana).
lunch(chocolate).
lunch(salgadinho).
lunch(sanduiche).
lunch(maca).

animal(macaco).
animal(girafa).
animal(leao).
animal(arara).
animal(elefante).

alldifferent([]). 
alldifferent([H|T]):- not(member(H,T)),
					  alldifferent(T).

imprime_lista([]):- write('\n ....................... THE END \n  '). 
imprime_lista([H|T]):-  
    write('\n ....................... \n '), 
    write(H), 
    imprime_lista(T).
    
amigas:-solucao(L),imprime_lista(L).


/*
?- amigas.

 ....................... 
 girl1,verde,eliana,morango,banana,elefante,matematica
 ....................... 
 girl2,vermelho,taiz,laranja,chocolate,arara,historia
 ....................... 
 girl3,amarelo,maria,limao,salgadinho,leao,geografia
 ....................... 
 girl4,azul,natalia,maracuja,maca,girafa,biologia
 ....................... 
 girl5,branco,marceli,abacaxi,sanduiche,macaco,portugues
 ....................... THE END 
  
true 

*/

