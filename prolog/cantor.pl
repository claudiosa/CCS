/* FERNANDA VOLTZ */
/* SISTEMA ESPECIALISTA - MUSICAS / CANTORES */

inic :- 
	consult('c:/meus documentos/claudio/cd.txt'),
      	menu(z), nl.

inic.

limpa_area(X) :-  retract(X) , fail.
limpa_area(_) .  /* o aterramento */


menu(s).    /* para terminar este menu principal */
menu( _ ) :-
	repete,    /* repeat until */ nl,
	write('    <<< Menu Principal  >>>    '), nl,
	write(' c - Consultas                 '), nl,
	write(' m - Manutenção                '), nl,
	write(' s - Sair                      '), nl,
	write(' Digite: c, m, ou s ==> '),
	le_opcao(Y),
	acao(Y),
	menu(Y).     /* chamada recursiva */


/**************** SALVA NA BASE DE DADOS ********************/ 

acao(s) :- nl,
	   write('Salvando a Base de Dados...'), nl,
           tell('c:/meus documentos/claudio/cd.txt'),
           listing(cantor), nl,
	   told, write('FIM').

acao(s) :- told, nl,
	   write('Houve falha no fechamento do Arquivo...').  


acao(m):- submenu(a).
	  submenu(s).
	  submenu(_) :- repetir, nl,
	  write('    <<< Menu Consulta  >>>    '), nl,
	  write(' I - Incluir                  '), nl,
	  write(' E - Excluir                  '), nl,
	  write(' A - Alterar                  '), nl,
	  write(' S - Sair                     '), nl,
	  write(' Digite:: i, e, a, s ==>'),
	  ler_opcao(Y),
	  acao2(Y),
	  submenu(Y).

/****************************** CONSULTAS**********************************/

acao(c):- submenu3(a).
	  submenu3(s).
	  submenu3(_) :- repetir3, nl,
	  write('    <<< Menu Consulta  >>>                           '), nl,
	  write(' T - Todos os Cantores                               '), nl,
	  write(' D - As Músicas de um determinado Cantor             '), nl,
	  write(' E - Todas as Músicas de um determinado Estilo       '), nl,
	  write(' N - Todas as Músicas de uma determinada Nota        '), nl,
	  write(' C - Todas as Músicas de um determinado Estilo e Nota'), nl,
	  write(' S - Sair                     '), nl,
	  write(' Digite:: t, d, e, n, c, s ==>'),
	  ler_opcao3(Y),
	  acao3(Y),
	  submenu3(Y).

/************************* INCLUI CANTOR ***************************/

acao2(i):-nl,
	  write('********** Inserindo Cantores *************'), nl,
	  write('Digite o Nome do Cantor............?'),
	  read(user,NomeCantor ), nl, /* ler em string ou lista */
 
	  le_lista_functor(Lista),

	  assertz(cantor(NomeCantor,Lista)).

acao2(i) :- write('  Ocorreu uma falha na inclusao '),
	    get_single_char(_).

/****************************ALTERAÇÃO CANTOR**********************/

acao2(a) :- 
	  write('********** Alterando Cantores ************'), 
	  nl,
	  acao2(e),
	  acao2(i).

/********************** EXCLUI CANTOR ******************************/

acao2(e) :- write('********* Excluindo Cantores ***********'), nl,
	    write('Qual o Cantor a ser excluido.........? '),
	    read(user, NomeCantor), 
	    retract(cantor(NomeCantor,Lista)). 

acao2(e) :- write( 'Ocorreu uma falha na exclusao. '),
	    get_single_char(_).

/********************* SUPORTE AO SUBMENU **************************/

acao2(s).


/***********************SALVANDO BASE DE DADOS***************************/

acao3(s).  

/**************************** TODOS OS CANTORES **************************/


acao3(t) :- 
	findall(X , cantor(X,_) , Tudo_x),
	findall(Y , cantor(_,Y) , Tudo_y),

	w_lst_2(Tudo_x, Tudo_y),   nl,
	write('  =============================================='),
	nl, !.     

acao3(t) :- write('  Não foi encontrado nada na base de dados ').


/**************CONSULTA AS MUSICAS DE UM DETERMINADO CANTOR***************/

acao3(d) :- 
	   nl,	
	   write('Consultar as Musicas do Cantor...'), nl,
	   read(user, NomeCantor), !,
	   cantor(NomeCantor,L_Musicas),
	   nl,
	   write('Nome do Cantor: '),
	   write(NomeCantor), nl,  
	   write('Musicas: '), 
	   escreve_lista(L_Musicas), nl, fail.


  
acao3(d) :- write('Não foi encontrado nada na base de dados ').


/***************TODAS AS MUSICAS DE UM DETERMINADO ESTILO****************/

acao3(e) :- nl,
		write('Listando as Músicas do Estilo...'), nl,
		read(user,NomeEstilo), !,
		cantor(NomeCantor,L_Musicas),
		eh_membro_Estilo(NomeEstilo,L_Musicas), nl,
		escreve_lista(L_Musicas),nl,nl,
		fail.

acao3(e) :- write('Não foi encontrado nada na base de dados').


/***************TODAS AS MUSICAS DE UMA DETERMINADA NOTA****************/

acao3(n) :- nl,

		write('Listando as Músicas da Nota...'), nl,
		read(user,NumeroNota), !,
		cantor(NomeCantor,L_Musicas),
		eh_membro_Nota(NumeroNota,L_Musicas), nl,
		escreve_lista(L_Musicas),nl,
		fail.

acao3(n) :- write('Não foi encontrado nada na base de dados').


/***********TODAS AS MUSICAS DE UM DETERMINADO ESTILO E NOTA************/

acao3(c) :- nl,

		write('Listando as Músicas da Nota...'), nl,
		read(user,NumeroNota), !,
		write('e Estilo .....................'),
	    	read(user,NomeEstilo),
		cantor(NomeCantor,L_Musicas),
		eh_membro_Estilo_Nota(NomeEstilo,NumeroNota,L_Musicas), nl,
		escreve_lista(L_Musicas),nl,
		fail.



/*	    write('Consultar as Músicas que tem como Nota.........:'),
	    read(user,Nota),nl,
	    write('e Estilo ......................................:'),
	    read(user,Estilo),
	    nl,
	    cantor(_,musica(_,Estilo,Nota)), nl,
	    findall(F, cantor(_,musica(F,Estilo,Nota)), Tudo_f),
	    findall(Nota, cantor(_,musica(_,Estilo,Nota)), Tudo_t),
	    findall(Estilo, cantor(_,musica(_,Estilo,Nota)), Tudo_m),
	    w_lst_6(Tudo_f, Tudo_t, Tudo_m),   nl,
	    nl, !.*/

acao3(c) :- write('Não foi encontrado nada na base de dados').


/********************** MANUTENÇÕES***************************/

repete.
repete :- repete. /* sempre ser bem sucedido  ....  fica em loop   */


le_opcao(X) :- get_single_char(Y), 
	       atom_char(X,Y),
	       write(' ===> '),
	       write(X),
	       member1(X,[c ,m ,s ]).
   

member1(X,[X|_]).
member1(X,[_|L]) :- member1(X,L).

repetir.
repetir :- repetir. /* sempre ser bem sucedido  ....  fica em loop   */

ler_opcao(X) :- get_single_char(Y), 
		atom_char(X,Y),
		write(' ===> '),
		write(X),
		member2(X,[i, e, a, s ]).

member2(X,[X|_]).
member2(X,[_|L]) :- member2(X,L).


repetir3.
repetir3 :- repetir3. /* sempre ser bem sucedido  ....  fica em loop   */

ler_opcao3(X) :- get_single_char(Y), 
		atom_char(X,Y),
		write(' ===> '),
		write(X),
		member3(X,[t, d, e, n, c, s]).

member3(X,[X|_]).
member3(X,[_|L]) :- member3(X,L).


eh_membro_Estilo(NomeEstilo,[musica(NomeMusica,NomeEstilo,Nota)|_]).
eh_membro_Estilo(NomeEstilo,[_|Resto]) :- eh_membro_Estilo(NomeEstilo,Resto).

eh_membro_Nota(NumeroNota,[musica(NomeMusica,Estilo,NumeroNota)|_]).
eh_membro_Nota(NumeroNota,[_|Resto]) :- eh_membro_Nota(NumeroNota,Resto).

eh_membro_Estilo_Nota(NomeEstilo,NumeroNota,[musica(NomeMusica,NomeEstilo,NumeroNota)|_]).
eh_membro_Estilo_Nota(NomeEstilo,NumeroNota,[_|Resto]) :- eh_membro_Estilo_Nota(NomeEstilo,NumeroNota,Resto).

 w_lst_2([],[]).
 w_lst_2( [X|L1], [Y|L2] ):-
	nl,
	write('As Músicas de: '),
	write(X), write(' são '),nl,
		write('Musicas..:'),escreve_lista(Y), nl,
	w_lst_2(L1,L2).


 w_lst_3([],[]).
 w_lst_3( [NomeCantor|L1],[R|L2] ):-
	nl,
	write('A Música de: '), 
	write(NomeCantor), write(' é '), write(R),nl,
	w_lst_3(L1,L2).

 w_lst_4([],[]).
 w_lst_4([H|L1],[G|L2] ):-
	nl,
	write('O Estilo: '), 
	write(Estilo), write(' é da Música:  '), escreve_lista(G),
	w_lst_4(L1,L2).

 w_lst_5([],[],[]).
 w_lst_5([G|L1],[Nota|L2],[H|L3] ):-
	nl,
	write('A Nota: '), 
	write(Nota), write(' pertence à Música:  '), write(G),
	w_lst_5(L1,L2,L3).

 w_lst_6([],[],[]).
 w_lst_6([F|L1],[Nota|L2],[Estilo|L3] ):-
	nl,
	write('A Nota: '),
	write(Nota),
	write('        E o Estilo: '),
	write(Estilo),
	write(' pertence à Música:  '), write(F),
	w_lst_6(L1,L2,L3).



/******************** lendo uma lista de functores ..... ****/

le_lista_functor( [ musica(NomeMusica,Estilo,Nota) | Resto ] ) :-
	nl, write('Digite O Nome da Musica   :: '),
	read(NomeMusica),
	nl, write('Digite O Estilo da Musica :: '),
	read(Estilo),
	nl, write('Digite A Nota da Musica   :: '),
	read(Nota),
	le_mais( Resto ),
	le_lista_functor( Resto ).

/* Condicao de Parada */
le_lista_functor([]) :- !.    /*  no caso de falso em le_mais */


le_mais(Y) :-
	nl, 
	write('Press <Enter ou Escape> to terminar:: '),
	get_single_char(X),
	/* confirmar estes ASCII do teclado ... ou melhorar a mensagem acima... */
	(X == 27; X == 13; X == 10) ,
	Y = [], !.

/* OBS: == eh a pergunta de equivalencia logica,
	=  eh uma pergunta se Y pode receber []; Y = [],
	se for possivel.... Y vai receber [],
	e o is eh atribuicao mesmo...
*/      

le_mais(_).


/*************************************************************************/
escreve_lista([]).
escreve_lista([musica(NomeMusica,Estilo,Nota)|Resto]) :-       
			write(' : '),                   
			write(NomeMusica),      
			write(' : '),                   
			write(Estilo),                      
			write(' : '),                   
			write(Nota), 
			escreve_lista(Resto).

/*************************************************************************/
