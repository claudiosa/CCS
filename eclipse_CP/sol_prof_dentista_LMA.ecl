
go1 :-
	modelo([X1,X2,X3,X4,X5]),
	writeln('\nX1':X1),
	writeln('X2':X2),
	writeln('X3':X3),
	writeln('X3':X4),
	writeln('X4':X5).

go2 :-   modelo(L),
         imprime_lista(L). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MODELO PRINCIPAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modelo([(primeiro,M1,R1,D1,H1,P1,C1),
		(segundo,M2,R2,D2,H2,P2,C2),
		(terceiro,M3,R3,D3,H3,P3,C3),
		(quarto,M4,R4,D4,H4,P4,C4),
		(quinto,M5,R5,D5,H5,P5,C5)]):-
		
	motivo(M1),motivo(M2),motivo(M3),motivo(M4),motivo(M5),
	/* precisa ser melhorado AQUI */
	M1\==restauracao,
	M1\==obturacao,
	M1\==aparelho,
	M2\==restauracao,
	M5\==aparelho,
	M5\==restauracao,
	M5\==canal,
	alldifferent([M1,M2,M3,M4,M5]),
	
	revista(R1),revista(R2),revista(R3),revista(R4),revista(R5),
	/* precisa ser melhorado AQUI */
	R1\==veja,
	R1\==galileu,
	R5\==veja,
	R5\==caras,
	R5\==istoe,
	R3==galileu,
	alldifferent([R1,R2,R3,R4,R5]),

	
	dentista(D1),dentista(D2),dentista(D3),dentista(D4),dentista(D5),
	/* precisa ser melhorado AQUI */
	D1==silvia,
	D2\==adriana,
	D3==raquel,
	D2\==silvia,
	D4\==silvia,
	D5\==silvia,
	D1\==raquel,
	D5\==raquel,
	D5\==adriana,
	D1\==priscila,
	alldifferent([D1,D2,D3,D4,D5]),
		
	horario(H1),horario(H2),horario(H3),horario(H4),horario(H5),
	/* precisa ser melhorado AQUI */
	H1\==1030,
	H1\==1100,
	H1==1015,
	H2\==1100,
	H2\==1030,
	H3\==1015,
	H4\==1015,
	H4==1000,
	H5\==1030,
	alldifferent([H1,H2,H3,H4,H5]),
		
	paciente(P1),paciente(P2),paciente(P3),paciente(P4),paciente(P5),
	/* precisa ser melhorado AQUI */
	P1\==marcos,
	P5\==marcos,
	P2\==marcos,
	P1\==rodrigo,
	P2\==rodrigo,
	P3\==rodrigo,
	P3\==celso,
	P1\==celso,
	P5\==eduardo,
	alldifferent([P1,P2,P3,P4,P5]),
		
	camisa(C1),camisa(C2),camisa(C3),camisa(C4),camisa(C5),
	/* precisa ser melhorado AQUI */
	C1\==amarelo,
	C5\==amarelo,
	C4\==amarelo,
	C3\=amarelo,
	C1\==verde,
	C5\==verde,
	C4\==verde,
	C5\==vermelho,
	C1\==azul,
	C5\==azul,
	C2\==azul,
	C1\==branco,
	alldifferent([C1,C2,C3,C4,C5]),
	
	%% QUAL O LUGAR CORRETO .... validar acima
	(M4==obturacao,R4==caras),
	(D3==raquel,R3==galileu),
	(P5==alvaro,D5==priscila).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BASE DE DADOS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	
	motivo(aparelho).
	motivo(canal).
	motivo(clareamento).
	motivo(obturacao).
	motivo(restauracao).
	
	revista(caras).
	revista(epoca).
	revista(galileu).
	revista(istoe).
	revista(veja).
	
	dentista(adriana).
	dentista(daniele).
	dentista(priscila).
	dentista(silvia).
	dentista(raquel).
	
	horario(1000).
	horario(1015).
	horario(1030).
	horario(1045).
	horario(1100).
	
	paciente(alvaro).
	paciente(celso).
	paciente(eduardo).
	paciente(marcos).
	paciente(rodrigo).
	
	camisa(amarelo).
	camisa(azul).
	camisa(branco).
	camisa(verde).
	camisa(vermelho).
	
	alldifferent([]).
	alldifferent([H|T]):-	not(member(H,T)),
							alldifferent(T).
	
	
	
	imprime_lista([]) :- write('\n ....................... THE END \n  '). 
	imprime_lista([H|T]) :-  
	    write('\n ....................... \n '), 
	    write(H), 
	    imprime_lista(T).


