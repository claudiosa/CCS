/*
[antonio,luiz,marcos,nuno,roberto].

[rock, samba,tango,salsa,valsa].

[amarelo, azul,vermelho,verde,marrom].
*/

alldifferent([]).
alldifferent([A|Cauda]) :- not(member(A,Cauda)), alldifferent(Cauda).

x :- solucao(X), write(X).

solucao([(ana,H1,D1,C1),(bia,H2,D2,C2),(paula,H3,D3,C3),(suzana,H4,D4,C4),(tania,H5,D5,C5)]) :-
	
	%%% atribuindo o nome dos HOMENS.... COM REDUCAO DE DOMINIO
	member(H1,[antonio,luiz,marcos,nuno,roberto]),
	delete([antonio,luiz,marcos,nuno,roberto], H1, New_Domain_2),
		
	member(H2, New_Domain_2 ),
	delete(New_Domain_2 , H2, New_Domain_3),
	
	member(H3, New_Domain_3 ),
	delete(New_Domain_3 , H3, New_Domain_4),
	
	member(H4, New_Domain_4 ),
	delete(New_Domain_4 , H4, New_Domain_5),
	
	member(H5, New_Domain_5 ),
	
	%%% atribuindo DANCA .... COM REDUCAO DE DOMINIO
	member(D1, [rock, samba,tango,salsa,valsa]),
	delete([rock, samba,tango,salsa,valsa], D1, D_Domain_2),
	
	member(D2, D_Domain_2 ),
	delete(D_Domain_2 , D2, D_Domain_3),
	
	member(D3, D_Domain_3 ),
	delete(D_Domain_3 , D3, D_Domain_4),
	
	member(D4, D_Domain_4 ),
	delete(D_Domain_4 , D4, D_Domain_5),
	
	member(D5, D_Domain_5),
	
	%%% COR .... COM REDUCAO DE DOMINIO
	member(C1, [amarelo, azul,vermelho,verde,marrom]),
	delete([amarelo, azul,vermelho,verde,marrom], C1, C_Domain_2),
	
	member(C2, C_Domain_2 ),
	delete(C_Domain_2 , C2, C_Domain_3),
	
	member(C3, C_Domain_3 ),
	delete(C_Domain_3 , C3, C_Domain_4),
	
	member(C4, C_Domain_4 ),
	delete(C_Domain_4 , C4, C_Domain_5),
	
	member(C5, C_Domain_5),
	
	/*	 DESNECESSARIO
	alldifferent([H1, H2, H3, H4, H5]), write('.'),
	alldifferent([C1, C2, C3, C4, C5]), write('*'),
	alldifferent([D1, D2, D3, D4, D5]), write('-'),
	*/
	
	D4==rock,
	((H1==marcos,C1==azul);(H2==marcos,C2==azul);(H3==marcos,C3==azul);(H4==marcos,C4==azul);(H5==marcos,C5==azul)),
	H1==nuno,
	((D1==salsa,C1==vermelho);(D2==salsa,C2==vermelho);(D3==salsa,C3==vermelho);(D4==salsa,C4==vermelho);(D5==salsa,C5==vermelho)),
	C2==marrom,
	((H1==antonio,D1==samba);(H2==antonio,D2==samba);(H3==antonio,D3==samba);(H4==antonio,D4==samba);(H5==antonio,D5==samba)),
	H3\==luiz,
	D3==tango,
	H5==roberto,
	D5\==salsa,
	((D1==valsa,C1\==amarelo);
	  (D2==valsa,C2\==amarelo);
	   (D3==valsa,C3\==amarelo);
	    (D4==valsa,C4\==amarelo);
	     (D5==valsa,C5\==amarelo)),
	 nl, write(' TEM RESPOSTA: '),nl.



