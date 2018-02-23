/* Sistema especialista Monitor: monitora uma RMON-MIB inferindo sobre possíveis problemas com elementos de rede */
/* fica opcional.....  pois será usado listing....*/

/* 
:- dynamic salva_fatos/0.
:- dynamic salva_regras/0.
*/
inic :- 
    /* limpa_area(lista_gen(_,_)), */
	consult('regras_mon.txt'),
	consult('fatos_mon.txt'),
	menu(z), nl.


inic.
limpa_area(X) :-  retractall(X) , fail.
limpa_area(_) .  /* o aterramento */

menu(s).    /* para terminar este menu principal */
menu( _ ) :-
	repete,    /* repeat until */ nl,
	write('    <<< Menu Principal  >>>    '), nl,
	write(' 1 - Insere regras ou fatos    '), nl,
	write(' 2 - Exclui regras             '), nl,
	write(' 3 - Mostra regras/fatos            '), nl,
	/* write(' 3 - Mostra fatos             '), nl, */
        write(' 4 - Aplica regras             '), nl,
        write(' S/s - Sair                      '), nl,
        write(' Digite uma das opções acima ==> '),
        le_opcao(Y),
        acao(Y),
        menu(Y).     /* chamada recursiva */

repete.
repete :- repete. /* sempre ser bem sucedido  ....  fica em loop   */


le_opcao(X) :- get_single_char(Y), 
   	       atom_char(X,Y),
 	       write(' '),
	       write(X),
	       member(X,['1', '2', '3', '4', 'S', s ]).
   

/*****************************************************/


/* Inclui Regra */

     /*  
	     .... a regra incluida já se torna dinamica.....por default
	     write(' Quantos argumentos (aridade) tem a regra ? ' ), 
	     get_single_char(N_arg), nl,
	     write(' Qual cabeca da regra ? ' ), 
	     read(Cab), nl,
	     write('Digite a regra lista_gen(X,Y) :- genero(X,Y). ==> após ?- ... seguido de . (ponto) ' ), nl,
	     write(' :: '),
 	     read(Regra),
	     asserta(':- dynamic Cab/N_arg.'),
	     */
acao('1') :- 
	     nl,
	     write('Digite uma regra ou um fato do tipo: lista_gen(X,Y) :- genero(X,Y).'), nl,
	     write(' ==> após ?- ... seguido de . (ponto) ' ), nl,
	     write(' ==> '),
 	     read(Regra),
	     assertz(Regra),
	     write(' Inclusao OK....' ),
	     get_single_char(_).

acao('1') :- write('  Ocorreu uma falha na inclusao da regra ou do fato '),
             get_single_char(_). 



	/* Exclui Regra */

acao('2') :- 
		 nl,
         write(' Exclusao: Escreva a regra/fato no formato ...' ), nl,
	     write(' lista_gen(X,Y) :- genero(X,Y). ==> após ?- ... seguido de . (ponto) ' ), nl,
	     write(' :: '), 
	     read(Regra),
	     retract(Regra),nl,nl,
	     write(' Exclusão OK....' ),
	     get_single_char(_).

acao('2') :- write('  Ocorreu uma falha na exclusão da regra/fato '),
             get_single_char(_). 



/* Lista Todas as Regras*/

acao('3'):- nl, 
	    write(' Todas as Regras Dinâmicas  ...' ), nl,
	    write(' Digite a cabeca da regra/fato ... seguido de . (ponto) '),
	    nl,
	    write(' ==> '),
	    read(X),
	    listing(X),
	    /* mostra_regras_dinamicas,	*/
	    /* este predicado.... aqui não está OK.... */
        pausa(_), !.	

acao('3') :- write(' Não há nenhuma Regra Cadastrada. ').


	/* Aplica a Regra */

acao('4') :- 
		 lista_gen(X,Y),
	     write(X), 
	     write(' ....: ' ), 
	     write(Y), nl, fail.

acao('4') :- write('  Mais nada nesta regra '),
             get_single_char(_).



/*****************************************************/
acao(s):- nl,
	  salva_regras,
	  salva_fatos,
	  write('FIM'), !.
 
acao(s):- nl,
	  write('Houve Falha No Fechamento do Arquivo... '),
          get_single_char(_).


/********************************************************/
salva_regras :-
	  write('Salvando nas Base de Regras... '), nl,		
	  /* no windows... cuidar com o caminho em questao.... */
	  tell('regras_mon.txt'), /* TUDO VAI PARA esta a saida padrão.... o stream corrente */
	  /* lista_regras(....), */
	  /* aqui está faltando ... o que se quer salvar... */
	  listing(salva_regras),
	  told, !. /* fecha  o stream corrente .. volta a tela... */
	  

salva_regras :- told, nl,  write('Problemas no salva os dados... '), get_single_char(_).

salva_fatos :-
  	  write('Salvando nas Base de Fatos... '), nl,
  	  /* cuidar com o caminho de tell */		
	  tell('dados_mon.txt'), /* TUDO VAI PARA esta a saida padrão.... o stream corrente */
	/*	  lista_regras(....), */
	/* aqui está faltando ... o que se quer salvar... */
	  write(' faltando escrever....'),
	  listing(salva_fatos),
	  told, !. /* fecha  o stream corrente .. volta a tela... */
	  

salva_fatos :- told, nl,  write('Problemas no salva os dados... '), 
			   get_single_char(_).
/********************************************************/
  mostra_regras_dinamicas :- 
				clause(Cabeca, Corpo), nl,
				write(Cabeca), write('.....'), 
				write(Corpo),
				fail.
   mostra_regras_dinamicas :- nl, write('.....'), pausa(_).
/* ************************************************* */
/*
member(X,[X|_]).
member(X,[_|L]) :- member(X,L).
*/

pausa(_) :- get_single_char(_).

testa(35):- !, fail.
testa(10):- !, fail.
testa(27):- !,fail.  
testa(_):- true.



/*   PARA LEITURA  DE UMA STRING.... */
le_uma_string(Lista) :- 
               /*  nl,*/
               /* write('  ===> '),*/
                le_aux2( Lista ).
		/*string_to_list( Str, Lista ). converte ASCII em String... */
	        /* converte Lista em String.... ... */
		/*nl,
		write(' Conferindo o que leu... : ') ,
		write( Str ).*/
	

le_aux2( [ Char | Resto ] ) :-
             get_single_char( Char ), 
	     testa2( Char ),	
             put( Char ),
             le_aux2( Resto ).

/* Condicao de Parada */
le_aux2( [] ) :- !.        

testa2(35) :- !, fail.         /* jogo da velha # */
testa2(13) :- !, fail.        /* Return */
testa2(10) :- !, fail.        /* New line ===> UNIX */
testa2(27) :- !, fail.        /* Escape */
testa2(_)  :- true. 

/**************************************************************************/
/* Remove caracteres Ascii, Como Return, Flexas de Movimento*/
remove_letra([[]|_],[]).

remove_letra([],[]).

remove_letra([[X|L1]|_],[X|L2]):- write(X), ((X>=48 , X=<57); 
				(X>=65 , X=<122); 
				(X==32); 
				(X==13)), 
			        remove_letra(L1,L2).

remove_letra([[_|L1]|_],L2):- remove_letra(L1,L2).

/****************************************************************************/
:- inic.



