
/* Sistema especialista - Cinema */

:-dynamic filme/3.
:- dynamic lista_gen/2.


inic :- limpa_area(lista_gen(_,_)),
	limpa_area(filme(_,_,dados(_,_,_))),
        /*consult('h:/dcc6cc/Trabalhos 4 Ano/Programas Prolog/filmes.txt'),*/
	/*consult('c:/4 Ano CC/Prolog/filmes.txt'), */
	consult('filmes.txt'),
	/* consult('..... '), */
	menu(z), nl.

inic.

limpa_area(X) :-  retract(X) , fail.
limpa_area(_) .  /* o aterramento */

menu(s).    /* para terminar este menu principal */
menu( _ ) :-
	repete,    /* repeat until */ nl,
	write('    <<< Menu Principal  >>>    '), nl,
	write(' I - Inserir                   '), nl,
	write(' E - Excluir                   '), nl,
	write(' A - Alterar                   '), nl,
	write(' C - Consultar                 '), nl,
        write(' S - Sair                      '), nl,
	write(' 1 - Insere regras             '), nl,
	write(' 2 - Exclui regras             '), nl,
	write(' 3 - Mostra regras             '), nl,
        write(' 4 - Aplica regras             '), nl,
        write(' Digite:: i, e, a, c, ou s ==> '),
        le_opcao(Y),
        acao(Y),
        menu(Y).     /* chamada recursiva */

repete.
repete :- repete. /* sempre ser bem sucedido  ....  fica em loop   */


le_opcao(X) :- get_single_char(Y), 
   	       atom_char(X,Y),
 	       write(' '),
	       write(X),
	       member1(X,[i ,e ,a ,c ,s, '1', '2', '3', '4' ]).
   

member1(X,[X|_]).
member1(X,[_|L]) :- member1(X,L).

/*****************************************************/

acao('1') :- write(' escreva a regra no formato ...' ), nl,
	   write(' lista_gen(X,Y) :- genero(X,Y) ==> após ?- ... seguido de . (ponto) ' ), nl,
	   write(' :: '), 
	   read(Regra), 	
	   assertz( Regra ),
	   write(' Inclusao OK....' ),
	   get_single_char(_).

acao('1') :- write('  Ocorreu uma falha na inclusao da regra '),
           get_single_char(_). 

acao('2') :- 
	   write(' removendo ...' ), nl,
	   write(' lista_gen(X,Y) :- genero(X,Y)  ' ), nl,	
	   retract( lista_gen(X,Y) :- genero(X,Y)  ),
	   write(' Exclusão OK....' ),
	   get_single_char(_).

acao('2') :- write('  Ocorreu uma falha na exclusão da regra '),
           get_single_char(_). 

acao('4') :- lista_gen(X,Y),
	     write(X), 
	     write(' ....: ' ), 
	     write(Y), nl, fail.
acao('4') :- write('  Mais nada nesta regra '),
             get_single_char(_).






/* Inserir Novo Filme*/
acao(i):- nl,
	  write('Inserindo um novo filme...'), nl,
          write('Qual é o nome do filme? '),
	  le_lista(Nomefilme), 
          remove_letra(Nomefilme, Novofilme),
	  filme(Novofilme, _,_), nl, 
          write('********Filme Já Cadastrado********'), !
		; 
          nl,
	  write('Tal filme nao existe ... digite novamente...: '),
          le_lista(Nomefilme),
	  remove_letra(Nomefilme, Novofilme), nl,
	  write('Quais os atores do filme? '),
	  lista_de_strings(L_atores), 
	  remove_letra(L_atores, Novoatores), nl,
          write('Quais o ano do filme? '),
	  read(user, Ano), nl,
	  write('Qual o genero do filme? '),
	  read(user, Genero), nl,
	  write('Qual a nota do filme? '),
	  read(user, Nota), nl,
          assertz(filme(Novofilme, Novoatores,dados(Ano,Genero,Nota))).

acao(i) :- write('  Ocorreu uma falha na inclusao '),
           get_single_char(_).   

/*******************************************************/
/* Excluir Filme*/
acao(e):- acao2(a), nl,
          write('Excluindo filme...'), nl,
	  write('Filme a ser removido: '), 
	  le_lista(Nomefilme), 
          remove_letra(Nomefilme, Novofilme),
	  retract(  filme(Novofilme,_,dados(_,_,_))   ).

acao(e) :- write('  Ocorreu uma falha na exclusao '),
           get_single_char(_).

/****************************************************/
/* Alterar Filme*/
acao(a):- write('Alterando filme...'), nl,
	  acao(e), 
	  acao(i).

/*****************************************************/
acao(s):- nl,
	  write('Salvando a Base de Dados... '), nl,		
	  /*tell('h:/dcc6cc/Trabalhos 4 Ano/Programas Prolog/filmes.txt'),*/
	  /*tell('c:/4 Ano CC/Prolog/filmes.txt'),*/
	  tell('filmes.txt'), /* torna este a saida padrão.... o stream corrente */
          listing(filme/3),
	  listing(regra_gen/2),
	   listing(regra_gen),
	   nl,
	  told, /* fecha  o stream corrente .. volta a tela... */
         write('FIM').
 
acao(s):- told, nl,
	  write('Houve Falha No Fechamento do Arquivo... ').

/********************************************************/

acao(c):- submenu(a).
submenu(s).
submenu(_) :- repetir, nl, nl,
          write('    <<< Menu Consultar  >>>   '), nl,
          write(' A - Todos                    '), nl,
 	  write(' B - A Partir do Ano X        '), nl,
	  write(' C - Nota Maior que X         '), nl,
	  write(' D - Por Genero               '), nl, 
	  write(' E - Por Ator		       '), nl,       
          write(' S - Sair                     '), nl,
          write(' Digite:: a, b, c, d, e, s ==> '),
          ler_opcao(U),
          acao2(U),
          submenu(U).     /* chamada recursiva */
         

repetir.
repetir :- repetir. /* sempre ser bem sucedido  ....  fica em loop   */

/****************************************************/

/* Listar Todos os Filmes*/
acao2(a):- nl, 
	   write('Listando Todos os Filmes...'), nl,
	   findall(Z , filme(Z,_,dados(_,_,_)), Tudo_z),
     	   findall(X , filme(_,X,dados(_,_,_)), Tudo_x),
	   findall(Y , filme(_,_,dados(Y,_,_)), Tudo_y),
	   findall(W , filme(_,_,dados(_,W,_)), Tudo_w),
	   findall(V , filme(_,_,dados(_,_,V)), Tudo_v),  
           listar(Tudo_z, Tudo_x, Tudo_y, Tudo_w, Tudo_v), nl,   
           write('=============================================='),
           nl, !.	

acao2(a):- write(' Não há nenhum registro cadastrada ').

/********************************************************/
/* Listar os Filmes Apartir do Ano X*/
acao2(b):- nl,
	   write('Listando Apartir de um Ano...'), nl,
	   write('Ano:  '), 
	   read(user, Anos), !,
	   filme(Nome,L_Atores,dados(Ano,Generos,Nota)),
	   Ano >= Anos, nl,
	   write('Nome do Filme: '), string_to_list(Nomefilme, Nome),
	   write(Nomefilme), nl,  
	   write('Atores: '), 
	   escreve_lista(L_Atores), nl,  
	   write('Ano: '), write(Ano), 
	   write('    Genero: '), write(Generos),
	   write('    Nota: '), write(Nota), fail.

acao2(b).

/******************************************************/
/* Listar os Filmes Com Nota Maior Que X*/
acao2(c):- nl,
	   write('Listando Filmes Com Nota Maior Que...'), nl,
	   write('Nota:  '), 
	   read(user, Notas), !,
	   filme(Nome,L_Atores,dados(Ano,Generos,Nota)),
	   Nota>=Notas, nl,
	   write('Nome do Filme: '), string_to_list(Nomefilme, Nome),
	   write(Nomefilme), nl,  
	   write('Atores: '), 
	   escreve_lista(L_Atores), nl,  
	   write('Ano: '), write(Ano),
	   write('    Genero: '), write(Generos),
	   write('    Nota: '), write(Nota), fail.

acao2(c).

/*******************************************************/
/* Listar os Filmes Por Genero*/
acao2(d):- nl,
	   write('Listando Por Genero...'), nl,
	   write('Generos: A  - Ação'), nl,
	   write('         AV - Aventura'), nl,
	   write('	   C  - Comédia'), nl,
	   write('	   D  - Drama'), nl,
	   write('	   DO - Documentário'), nl,
	   write('	   F  - Ficção'), nl,
	   write('	   FI - Ficção Científica'), nl,
	   write('	   R  - Romance'), nl,
	   write('	   S  - Suspense'), nl,
	   write('	   T  - Terror'), nl,
	   write('	   W  - Western  ===> '), 
           read(user, Gen), 
           genero(Gen,Generos), 
	   filme(Nome,L_Atores,dados(Ano,Genero,Nota)),
	   Genero = Generos, nl,
	   write('Nome do Filme: '), string_to_list(Nomefilme, Nome),
	   write(Nomefilme), nl,  
	   write('Atores: '), 
	   escreve_lista(L_Atores), nl,  
	   write('Ano: '), write(Ano), 
	   write('    Genero: '), write(Genero),
	   write('    Nota: '), write(Nota), fail.

acao2(d).

/*****************************************************/
/* Listar Todos os Filmes de um Ator*/
acao2(e):- nl,
	   write('Listando os Filmes de um Ator...'), nl,
	   write('Ator/Atriz:  '), 
	   le_lista(Artista), 
	   remove_letra(Artista, Novoartista), !,
	   filme(Nome,L_atores,dados(Ano,Generos,Nota)),
	   member3(Novoartista,L_atores), nl,
	   write('Nome do Filme: '), string_to_list(Nomefilme, Nome),
	   write(Nomefilme), nl,  
	   write('Atores: '), 
	   escreve_lista(L_atores), nl,  
	   write('Ano: '), write(Ano), 
	   write('    Genero: '), write(Generos),
	   write('    Nota: '), write(Nota), fail.

acao2(e):- nl, write(' ... Nao ha mais filmes com este artista .... '),
	   pausa.



/*******************************************************/
acao2(s).

acao2(_):- nl, write('Ação Não Implementada ').

/****************************************************/

member3(X,[X|_]).
member3(X,[_|L]) :- member3(X,L).

/***************************************************/

member4(X,[X|_]).
member4(X,[_|L]) :- member4(X,L).

/******************************************************/
/* Generos*/
genero(a, ação).
genero(av, aventura).
genero(c, comédia).
genero(d, drama).
genero(do, documentário).
genero(f, ficção).
genero(fc, científica).  
genero(r, romance).				
genero(s, suspense).
genero(t, terror).
genero(w, western).

/******************************************/
/* Ler Nome do Filme */
le_lista(Lista):- see(user),
		  le_aux(Lista).

le_aux([Char|Resto]):- 
		     	
		    get0(user,Char),
   	            testa(Char),
		    le_aux(Resto).

/* Condição de Parada */
 le_aux([]):- !.

testa(35):- !, fail.
testa(10):- !, fail.
testa(27):- !,fail.  
testa(_):- true.

/************************************************************/
/* Imprimir Todos os Filmes*/
listar([], [], [], [], []).
listar([Z|L1], [X|L2], [Y|L3], [W|L4], [V|L5]):-
						nl,
						write('Nome do Filme: '), string_to_list(Nome,Z),
						write(Nome), nl,  
						write('Atores: '), escreve_lista(X), nl,
						write('Ano: '), write(Y), 
						write('    Genero: '), write(W),
						write('    Nota: '), write(V),
						listar(L1, L2, L3, L4, L5).

/**********************************************************/
pausa :-  get_single_char(_).   

/************************************************************/
/* Ler Nome dos Atores*/
lista_de_strings( [ Nome | Outros ] ) :-
             				nl, 
					write('Tecle <#>, <Enter> ou <Escape> para terminar a entrada'),
					nl, le_mais,
            				write('Ator/Atriz: '),
             				le_uma_string( Nome ),
				        lista_de_strings( Outros ).
 
/*  Condicao de Parada */
     lista_de_strings([]) :- !.        /* no caso de do retorno de Outros = [], da 
                                                         cláusula anterior .... */
le_mais :-
       		nl, 
       		write('Novo Artista (S/N ou n): '),
       		get_single_char(X), W=X,
                atom_char(V, W), write(V), nl,
       		(X == 110; X == 78) ,!, fail.
       		/* 110 = 'n' e 78 = 'N' */
	      	/* Y = [], !.*/
 
le_mais.

/*    PARA LEITURA  DE UMA STRING.... */
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

/*************************************************************************/
/* Imprime Nome dos Atores*/
escreve_lista([]).
escreve_lista([Head|Tail]) :- put(Head), 
			      write(', '),	
                              escreve_lista(Tail).
/**************************************************************************/
/*Remove caracteres Ascii, Como Return, Flexas de Movimento*/
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


