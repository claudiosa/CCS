/*	Lógica Matemática 
	Jhonatan izidiroo
	
*/

solucao([(man1,CA1,CO1,NO1,PRO1,A1,ES1),
		 (man2,CA2,CO2,NO2,PRO2,A2,ES2),
		 (man3,CA3,CO3,NO3,PRO3,A3,ES3),
		 (man4,CA4,CO4,NO4,PRO4,A4,ES4),
		 (man5,CA5,CO5,NO5,PRO5,A5,ES5)]):-
		 
shirt(CA1), shirt(CA2), shirt(CA3), shirt(CA4), shirt(CA5), alldifferent([CA1, CA2, CA3, CA4, CA5]),
CA1==vermelha,
%CA2\==amarela,
CA3==verde,
CA4==branca,
CA5==azul,

bill(CO1), bill(CO2), bill(CO3), bill(CO4), bill(CO5), alldifferent([CO1, CO2, CO3, CO4, CO5]),
%CO1==aluguel,
CO2==celular,
CO3==luz,
CO4==agua,
CO5==telefone,

name(NO1), name(NO2), name(NO3), name(NO4), name(NO5), alldifferent([NO1, NO2, NO3, NO4, NO5]),
NO1==natan,
NO2==edson,
NO3==adilson,
NO4==jhon,
NO5==ricardo,

prof(PRO1), prof(PRO2), prof(PRO3), prof(PRO4), prof(PRO5), alldifferent([PRO1, PRO2, PRO3, PRO4, PRO5]),
PRO1==fotografo,
%PRO2==massagista,
PRO3==pesquisador,
PRO4==bombeiro,
PRO5==veterinario,

animal(A1), animal(A2), animal(A3), animal(A4), animal(A5), alldifferent([A1, A2, A3, A4, A5]),
A1==cachorro,
A2==peixe,
A3==passaro,
A4==tartaruga,
A5==gato,
	
sport(ES1), sport(ES2), sport(ES3), sport(ES4), sport(ES5), alldifferent([ES1, ES2, ES3, ES4, ES5]),
ES1==volei,
ES2==basquete,
ES3==natacao,
ES4==sinuca,
ES5==futebol.
/************************* BASE DE DADOS  *****************************/
shirt(amarela).
shirt(azul).
shirt(branca).
shirt(verde).
shirt(vermelha).

bill(agua).
bill(aluguel).
bill(celular).
bill(luz).
bill(telefone).

name(jhon).
name(natan).
name(ricardo).
name(edson).
name(adilson).

prof(bombeiro).
prof(fotografo).
prof(massagista).
prof(pesquisador).
prof(veterinario).

animal(cachorro).
animal(gato).
animal(passaro).
animal(peixe).
animal(tartaruga).

sport(basquete).
sport(futebol).
sport(sinuca).
sport(natacao).
sport(volei).

alldifferent([]). 
alldifferent([H|T]):- not(member(H,T)),alldifferent(T).


imprime_lista([]):- write('\n ....................... THE END \n  '). 
imprime_lista([H|T]):-  
    write('\n ....................... \n '), 
    write(H), 
    imprime_lista(T).
    
fila :- solucao(L),imprime_lista(L).


/*
?- fila.

 ....................... 
 man1,vermelha,aluguel,natan,fotografo,cachorro,volei
 ....................... 
 man2,amarela,celular,edson,massagista,peixe,basquete
 ....................... 
 man3,verde,luz,adilson,pesquisador,passaro,natacao
 ....................... 
 man4,branca,agua,jhon,bombeiro,tartaruga,sinuca
 ....................... 
 man5,azul,telefone,ricardo,veterinario,gato,futebol
 ....................... THE END 
  
true 
*/
