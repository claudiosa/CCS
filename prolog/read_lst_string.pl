/***********************************/
:- dynamic(predicado_teste/1). 
 /* Incluir o predicado dynamic ... advertindo que 
     que predicado_teste será um predicado dinamico...
*/     
y :- lista_de_strings( L ), nl, 
      write(L),   /* escreve no padrao que armazenou ...... */
      nl,
      escreve_lista( L ), /* escreve no padrao de lista ...... */
      assertz(predicado_teste(L) ),
      nl,
      listing(predicado_teste). /* escreve no padrao interno de como  serah tratado */
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
     lista_de_strings([]) :- !.        /* no caso de do retorno de Outros = [], da 
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

testa(35) :- !, fail.         /* jogo da velha # */
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


