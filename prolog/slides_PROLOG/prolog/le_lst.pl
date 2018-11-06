/***********************************/
y :- le_lista( L ), nl,  escreve_lista( L ).
/***********************************/
le_lista( Lista ) :- 
                write('Digite <Enter> ou <Escape> para terminar a entrada: '), nl,
                write('  ===> '),
                le_aux( Lista ),
		string_to_list( Str, Lista ),
	        /* converte Lista em String.... ... */
		nl,
		write(' Escrevendo em string... : ') ,
		write( Str ).
		

le_aux( [ Char | Resto ] ) :-
       	    /* write(' '), */			
             get_single_char( Char ), 
	     testa( Char ),	
             put( Char ),
             le_aux( Resto ).

/* Condicao de Parada */
le_aux( [] ) :- !.        

testa(13) :- !, fail.        /* Return */
testa(10) :- !, fail.        /* New line ===> UNIX */
testa(27) :- !, fail.        /* Escape */
testa(_)  :- true. 
/*************************************************************************
 * write_string(String)                                                   *
 *  Displays a string (a list of ASCII codes).                           *
 *************************************************************************/
escreve_lista([]).
escreve_lista([Head|Tail]) :- 	 write(' : '),			
				put(Head), 
                              escreve_lista(Tail).
/*************************************************************************/

