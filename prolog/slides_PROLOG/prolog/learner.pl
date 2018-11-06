/* LEARNER.PL */
/* Programa que modifica uma base de dados...*/
/* learning capitals and its respective states...*/

inic :- 
        limpa_area(capital_of(_,_)),
        /* consult('d:/users/claudio/ia/pgms.pl/capitais.txt'), */
        consult('/home/professores/claudio/cursos/tep4/pgms_ia/capitais.txt'),
       /*    prestar muita atencao se o caminho estah correto */
       /*
       see(user),  faz user como stream de entrada ===> teclado 
       tell(user),  faz user como stream de saida ===> video 
       */
       acao(l),    /* listando a base logo no inicio */
      write('  BASE CARREGADA COM SUCESSO'), nl,
      menu(i). /* i, e, a, c, b, l, ... exceto s */

inic. 

 limpa_area(X) :-  retract(X) , fail.
 limpa_area(_) .

menu(s).    /* para terminar este menu principal */
menu(_) :-
	repete,    /*   ..... o repeat until */ nl,
	write('    <<< Menu Principal  >>>   '), nl,
	write(' I - Inserir novas Capitais/Estados  '), nl,
	write(' E - Excluir Cap ou Est      '), nl,
	write(' A - Alterar Cap ou Est    '), nl,
	write(' C - Consulta Típica   '), nl,
	write(' B - Busca de novo no arquivo   '), nl,
        write(' L - Lista toda BD (RAM)    '), nl,
        write(' S - Sair               '), nl,
        write(' Digite:: i, e, a, c, b, l, ou s ==> '),
        le_opcao(Y),
        acao(Y),
       menu(Y).     /* chamada recursiva */

repete.
repete :- repete.

le_opcao(X) :-   /* ( o ) */
	get_single_char(Y), 
	atom_char(X,Y),
	write(' ===> '),
	write(X),
	/* upper_lower(X_maisc , X), */
	menber1(X,[i,e,a,c,b,l ,s ]).
   
menber1(X,[X|_]).
menber1(X,[_|L]) :- menber1(X,L).

/* OBS: sem clausula aterrada ====> 
pois se falhar aqui cai no replay....*/	

/* ************** ************** ************** **************/

acao(i) :- 
	nl,
	write('Inserindo um novo estado ...  . no final'), nl,
/*    	trace,  habilitiar o trace por aqui.... flush,  */
        write('Qual é a capital? '),
        le_uma_string( Capital),
	write( ' ====> leu : '),
        write(Capital), nl,
        write(' Qual é o seu estado? '),
	/* read(user, Estado), */
	le_uma_string( Estado ),
        write( ' ====> leu : '),
	write(Estado),
	assertz(capital_of(Capital,Estado) ).

acao(i) :- 
	write('  Ocorreu uma falha na inclusao '),
        get_single_char(_).
/* ************** ************** ************** **************/
acao(c) :- 
          write('  carregando a base de dados ...'),
	  /* lendo um arquivo */	  
/*   ===> a base jah havia sido carregada       
     consult('d:/users/claudio/ia/pgms.pl/capitais.txt'), 
     consult('~/cursos/tep4/pgms_ia/capitais.txt'),
*/          
          see(user),   /* torna a stream padrao como ENTRADA sendo user */
/*       tell( stream de SAIDA padrao... arquivo etc.... )   */
          nl,
          write('Note! Type names entirely in'),nl,
          write('lower case, followed by a period.'),nl,
          process_a_query, !.
/* ************** ************** ************** **************/
acao(l) :- 
     findall(Z , capital_of(_,Z) , Tudo_z),
     findall(X , capital_of(X,_) , Tudo_x),
     w_lst_2(Tudo_x, Tudo_z),   nl,
     write('  =============================================='),
     nl,
/*     get_single_char(_),  */
     !.	
acao(l) :- write('  Não nenhuma capital cadastrada ').

/*     bagof(Z,capital_of(_,Z), Tudo), */
/* ************** ************** ************** **************/
acao(s) :-   
        nl,
/*        trace,  */
         write('Saving the knowledge base...'),
	 /* faz esta stream ... como saida padrao.... */
  /*    tell('d:/users/claudio/ia/pgms.pl/capitais.txt'), */
         tell('/home/professores/claudio/cursos/tep4/pgms_ia/capitais.txt'),
         write(':- dynamic capital_of/2.'),nl, /* capital_of has to */
         listing(capital_of),     nl,   /* be declared dynamic */
         told, /* fecha a stream  definido em  tell que eh de SAIDA */	
         write(' FIM ').
acao(s) :-   
	told, nl,
	write('  Houve alguma  falha no fechamento do arquivo.......... ').

acao(_) :- 
         nl,
	write('  Regras nao implementadas ').
/* ************** ************** ************** **************/
process_a_query :- 
                  write('State? '),
		  le_uma_string( State ) ,
                  answer(State).
process_a_query :- !.

/* If the state is in the knowledge base, display it, then
    loop back to process_a_query */
/* para o caso de átomos já existentes */
answer(State) :-  
		   capital_of(State,City), nl,
                   write('The capital of '),
                   write(State),
                   write(' is '),
                   write(City),    !. 
/* STRINGS/LISTAS  */
answer(State) :-  
                  string_to_list( State, L_State),
  /* converte para uma lista ... tenta como fosse uma    lista */
		   capital_of(L_State, City),
		   string_to_list( S_City, City), nl,
                   write('The capital of '),
                   write(State),   /* escrevendo em string */
                   write(' is '),
                   write( S_City ),     !. 
/* átomos */
answer(State) :-  
		   string_to_atom( State, A_State),
  /* converte para um ATOMO ... tenta como fosse uma    lista */
		   capital_of(A_State,City), nl,
                   write('The capital of '),
                   write(A_State), /* escrevendo como um atomo */
                   write(' is '),
                   write(City),     !. 
	     
 /* pare a consulta por aqui ... pois  a resposta  já existia... */
/* 
  If the state is not in the knowledge base, ask the
   user for information, add it to the knowledge base, and
   loop back to process_a_query 
*/

answer(State) :- 
   \+ capital_of(State,_),
   write('  Tal estado nao existe '), nl,
    write('I do not know the capital of that state.'), nl,
      write('  Gostaria que o sistema aprendesse o nome desta nova Capital (s/n)?'), 
	 sim_ou_nao(X),    
          write(' ===> '),
	   ttyflush,
 	   write(X),
         	X == 's',  /* se for sim continua...... */
                nl,
	   write('Please tell me.'),nl,
                   write('Capital? '),
                    /*   read(City), */
  		le_uma_string( City ) ,
                   write('Thank you.'),nl,nl,
                   assertz(capital_of(State,City)),
	   !. 
answer(_) :- !.

sim_ou_nao(X)   :- 	/* true ou false */
	get_single_char(Y), 
	atom_char(X,Y),
              !.
/* sim_ou_nao   :-      false. */
/* **************************************** */
  w_lst_cap( [] ).	
  w_lst_cap([X| L ]) :- 	write(' '), write(X), 
		write(' '), w_lst_cap(L).


 w_lst_2([], []).	
 w_lst_2( [X|L1], [Y|L2] ):-
	nl,
	write('A capital de '), 
	 string_to_list( S_X, X),  /* CONVERTENDO  */
         string_to_list( S_Y, Y), 
	write(S_X), write(' é  '), write(S_Y),
	w_lst_2(L1,L2).

/*****************************************************************/
/*:- dynamic(predicado_teste/1).  */
 /* Incluir o predicado dynamic ... advertindo que 
     que predicado_teste será um predicado dinamico...
*/     

y :- lista_de_strings( L ), nl, 
      write(L),   /* escreve no padrao que armazenou ...... */
      nl,
      escreve_lista( L ), /* escreve no padrao de lista ...... */
      assertz(predicado_teste(L) ),
      nl,
      listing(predicado_teste). 
      /* escreve no padrao interno de como  serah tratado */
/***********************************/
lista_de_strings( [ Nome | Outros ] ) :-
             nl, 
            write('NOME::: '),
             le_uma_string( Nome ),
             le_mais(Outros),      /* constroi uma lista vazia em caso
                                                     de não haver mais nomes
                                                        a serem inseridos....
                                                        Não é um predicado que muito claro....
                                                        mas no momento é o que funciona bem....
                                                */        
             lista_de_strings( Outros ).
 
/*  Condicao de Parada */
     lista_de_strings([]) :- !.        
     /* no caso de do retorno de Outros = [], da 
           cláusula anterior .... */
 
/* este procedimento nao está muito legal... mas,    funciona bem....
*/    
      
le_mais(Y) :-
       nl, 
       write('Novo Nome (S/N ou n): '),
       get_single_char(X),
       (X == 110; X == 78) ,
       /* 110 = 'n' e 78 = 'N' */
       Y = [], !.
 
le_mais(_).

/*    PARA LEITURA  DE UMA STRING.... */
le_uma_string( Str ) :- 
   
             write('Tecle <#>, <Enter> ou <Escape> para terminar a entrada: '), nl,
                write('  ===> '),
                le_aux( Lista ),
		string_to_list( Str, Lista ), /* converte ASCII em String... */
	        /* converte Lista em String.... ... */
		nl,
		write(' Conferindo o que leu... : ') ,
		write( Str ).
	

le_aux( [ Char | Resto ] ) :-
             get_single_char( Char ), 
	     testa( Char ),	
             put( Char ),
             le_aux( Resto ).

/* Condicao de Parada */
le_aux( [] ) :- !.        

testa(35) :- !, fail.         /* jogo da velha #    **/
testa(13) :- !, fail.        /* Return */
testa(10) :- !, fail.        /* New line ===> UNIX */
testa(27) :- !, fail.        /* Escape */
testa(_)  :- true. 
/*
DICA:::   para descobrir o codigo de uma tecla:
?- get_single_char(X), write(X).
 */

/*************************************************************************
 *  Displays a string (a list of ASCII codes).                           *
 *************************************************************************/
escreve_lista([]).
escreve_lista([Head|Tail]) :- 	 write(' : '),			
				put(Head), 
                              escreve_lista(Tail).
/*************************************************************************/


	
/**** Dando o boot em tempo **************************************/		
:- inic.

/***********************************************************************
 ?- string_to_list(bb,X), capital_of(Z,X), string_to_list(S,Z), write(S).
aaa
X = [98, 98]
Z = [97, 97, 97]
S = "aaa" 

Yes
?- 
*/