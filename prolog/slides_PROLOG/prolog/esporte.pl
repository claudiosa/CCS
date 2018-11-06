/* SISTEMA ESPECIALISTA - ESPORTES */

:- dynamic esporte/2.
inic :- consult('esporte.txt'), menu(z), nl.

/* consult('h:/mb6cc/Programas Prolog/esporte.txt'), */


menu(s).    /* para terminar este menu principal */
menu( _ ) :-
	repete,    /* repeat until */ nl,
	write('    <<< Menu Principal  >>>    '), nl,
	write(' E - Escolher Esporte          '), nl,
	write(' M - Manutencao                '), nl,
        write(' S - Sair                      '), nl,
        write(' Digite: e, m, ou s ==> '),
        le_opcao(Y),
        acao(Y),
        menu(Y).     /* chamada recursiva */

repete.
repete :- repete. /* sempre ser bem sucedido  ....  fica em loop   */


le_opcao(X) :- get_single_char(Y), 
   	       atom_char(X,Y),
 	       write(' ===> '),
	       write(X),
	       member1(X,[e ,m ,s ]).
   

member1(X,[X|_]).
member1(X,[_|L]) :- member1(X,L).

/**************** SALVA NA BASE DE DADOS ********************/ 

acao(s) :- nl,
           write('Salvando a Base de Dados...'), nl,
         /*  tell('h:/mb6cc/Programas Prolog/esporte.txt'), */
          tell('esporte.txt'),
            nl,
           told, write('FIM ... bye-bye').

acao(s) :- told, nl,
           write('Houve falha no fechamento do Arquivo...').  


/********************** ACOES ******************************/

acao(e) :- write('    NAO IMPLEMNTEDA....  '), nl,
 		get_single_char(_).
acao(m):- submenu(a).

submenu(s).

submenu(_) :- repetir, nl,
          write('    <<< Menu Consulta  >>>   '), nl,
          write(' I - Incluir                  '), nl,
 	  write(' E - Excluir                  '), nl,
	  write(' M - Modificar                '), nl,
	  write(' S - Sair                     '), nl,
          write(' Digite:: i, e, m, s ==>'),
          ler_opcao(Y),
          acao2(Y),
          submenu(Y).     /* chamada recursiva */

repetir.
repetir :- repetir. /* sempre ser bem sucedido  ....  fica em loop   */

ler_opcao(X) :- get_single_char(Y), 
   	        atom_char(X,Y),
 	        write(' ===> '),
	        write(X),
	        member2(X,[i, e, m, s ]).

member2(X,[X|_]).
member2(X,[_|L]) :- member2(X,L).


/********************** INCLUI ESPORTE ***********************/

acao2(i):-nl,
	  write('Inserindo um novo Esporte .....'), nl,
          write('Qual é o nome do Esporte ? '),
	  read(user, Nomesporte), nl,
	  write(' Estilo :  1 - Leve'), nl,
     	  write('          3 - Radical'), nl,
          read(user, Estilo), nl,	
          write(' Custo :  1 - Caro'), nl,
          write('          2 - Médio'), nl,  
	  write('          3 - Barato'), nl,
          read(user, Custo), nl,
          write(' Faixa Etária: 1) 7  a 10 anos'), nl,
          write('               2) 11 a 50 anos'), nl,  
          write('               3) 20 a 60 anos'), nl,
          write('               4) 21 a 70 anos'), nl,
          read(user, Faixa), nl,
          write(' Caloria/Hora : 1) 50  a 100'), nl,
          write('                2) 101 a 200'), nl,
          write('                3) 201 a 300'), nl,      
          read(user, Caloria), nl,
          write(' Local : 1 - Indoor'), nl,
          write('         2 - Outdoor'), nl,
          write('         3 - Ambos'), nl,
          read(user, Local), nl,
          /*
    trabalhe com o seguinte formato...... 
    esporte(Nomesporte,  [Estilo,Custo,Faixa,Caloria,Local])
    ou seja.... um predicado e uma lista de atributos....
    que agora será variável... poiis com functores ...
    o número de atributos deverá ser fixo
    */
     /* MUDE AQUI */
     assertz(esporte(Nomesporte, atributos(Estilo,Custo,Faixa,Caloria,Local))),
	write(' SALVO OK ..... na MT' ),
	get_single_char(_).

acao2(i) :- write('  Ocorreu uma falha na inclusao '),
            get_single_char(_).


/******************** EXCLUIR ESPORTE ******************************/

acao2(e) :- write('Excluindo um esporte as escuras...'), nl,
            write('Esporte a ser excluido: '), nl,
            read(user, Nomesporte),
            /* MUDE AQUI */
            retract(esporte(Nomesporte,atributos(_,_,_,_,_))). 

acao2(e) :- write( 'Ocorreu uma falha na exclusao. '),
            get_single_char(_).

/********************* SUPORTE AO SUBMENU **************************/

acao2(s).

 
/********************* SEM USO ********************/

le_aux([Char|Resto]):- write(' '),
		       get0(Char),
		       testa(Char),
		       put(Char),
		       write(' | '),
		       le_aux(Resto).

/* Condição de Parada */
le_aux([]):- !.

testa(13):- !, fail.
testa(10):- !, fail.
testa(27):- !,fail.
testa(_):- true.

/*******************************/
:-inic.
