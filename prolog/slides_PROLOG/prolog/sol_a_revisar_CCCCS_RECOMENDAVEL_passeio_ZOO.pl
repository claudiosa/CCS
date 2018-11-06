% Passeio no Zoologico 
% TRABALHO EM GRUPO
% MARLON HENRY E ELOY
%%% ADAPTACACAO PROF CLAUDIO - JUNHO 2015


go :-  %% Tempo inicial
    statistics(cputime,T1),
   
    amigas(  [M1, M2, M3, M4,M5]  ), 
    imprime_lista(  [M1, M2, M3, M4,M5]  ),

     %% Tempo final
    statistics(cputime ,T2), 
    Tempo_BUSCA is T2 - T1, 
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Tempo total: ~10f  msec', Tempo_BUSCA), !.


amigas([(MOCHILA1, NOME1, MATERIA1, SUCO1, LANCHE1, ANIMAL1),
        (MOCHILA2, NOME2, MATERIA2, SUCO2, LANCHE2, ANIMAL2),
        (MOCHILA3, NOME3, MATERIA3, SUCO3, LANCHE3, ANIMAL3),
        (MOCHILA4, NOME4, MATERIA4, SUCO4, LANCHE4, ANIMAL4),
        (MOCHILA5, NOME5, MATERIA5, SUCO5, LANCHE5, ANIMAL5)]
       ):-
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%mochila
	mochila(MOCHILA1), mochila(MOCHILA2), mochila(MOCHILA3), mochila(MOCHILA4), 
	mochila(MOCHILA5), 
	alldifferent([MOCHILA1, MOCHILA2, MOCHILA3, MOCHILA4, MOCHILA5]),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% 22. AmeninadamochilaVermelhaestáexatamenteàdireitadademochilaVerde
	(
	(MOCHILA1==verde,MOCHILA2==vermelho);
	(MOCHILA2==verde,MOCHILA3==vermelho);
	(MOCHILA3==verde,MOCHILA4==vermelho);
	(MOCHILA4==verde,MOCHILA5==vermelho)
	),
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%nomes     
	nome(NOME1), nome(NOME2), nome(NOME3), nome(NOME4), 
	nome(NOME5), 
	alldifferent([NOME1, NOME2, NOME3, NOME4, NOME5]),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% 19. A Jéssica ocupa a segunda posição na ﬁla. 
	NOME2==aretuza,
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%materias     
	materia(MATERIA1), materia(MATERIA2), materia(MATERIA3), materia(MATERIA4), 
	materia(MATERIA5), 

	alldifferent([MATERIA1, MATERIA2, MATERIA3, MATERIA4, MATERIA5]),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% 1. A penúltima garota da ﬁla gosta de Biologia.
	MATERIA4==biologia,
	
	% 3. A menina que gosta de História está em algum lugar entre a Japa e a menina que gosta de Geograﬁa, nesta ordem. 
	(
	(NOME1==japa,MATERIA3==geografia,MATERIA2==historia);
	(NOME1==japa,MATERIA4==geografia,(MATERIA2==historia;MATERIA3==historia));
	(NOME1==japa,MATERIA5==geografia,(MATERIA2==historia;MATERIA3==historia;MATERIA4==historia));
	(NOME2==japa,MATERIA4==geografia,MATERIA3==historia);
	(NOME2==japa,MATERIA5==geografia,(MATERIA3==historia;MATERIA4==historia));
	(NOME3==japa,MATERIA5==geografia,MATERIA4==historia)
	),
	
	% 2. A menina de mochila Amarela está em algum lugar à esquerda da garota que gosta de Português. 
	(
	(MATERIA2==portugues,MOCHILA1==amarelo);
	(MATERIA3==portugues,(MOCHILA1==amarelo;MOCHILA2==amarelo));
	(MATERIA4==portugues,(MOCHILA1==amarelo;MOCHILA2==amarelo;MOCHILA3==amarelo));
	(MATERIA5==portugues,(MOCHILA1==amarelo;MOCHILA2==amarelo;MOCHILA3==amarelo;MOCHILA4==amarelo))
	),
	
	
	% 21. A garota que gosta de Geograﬁa está ao lado da de mochila Azul. 
	
	(
	(MATERIA1==geografia,(MOCHILA2==azul));
	(MATERIA2==geografia,(MOCHILA1==azul;MOCHILA3==azul));
	(MATERIA3==geografia,(MOCHILA2==azul;MOCHILA4==azul));
	(MATERIA4==geografia,(MOCHILA3==azul;MOCHILA5==azul));
	(MATERIA5==geografia,(MOCHILA4==azul))
	),
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%lanche     
	lanche(LANCHE1), lanche(LANCHE2), lanche(LANCHE3), lanche(LANCHE4), 
	lanche(LANCHE5), 
	alldifferent([LANCHE1, LANCHE2, LANCHE3, LANCHE4, LANCHE5]),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% 8. A menina que trouxe uma Maçã está na quarta posição da ﬁla.
	LANCHE4==maca,
	% 10. A menina que trouxe Chocolate está na segunda posição.
	LANCHE2==chocolate,

	
	% 9. A garota que gosta de Geograﬁa vai comer Salgadinho.
	(
	(MATERIA1==geografia,LANCHE1==salgado);
	(MATERIA2==geografia,LANCHE2==salgado);
	(MATERIA3==geografia,LANCHE3==salgado);
	(MATERIA4==geografia,LANCHE4==salgado);
	(MATERIA5==geografia,LANCHE5==salgado)
	),
	
	
	% 11. A garota que vai comer Sanduíche gosta de Português. 
	(
	(LANCHE1==sanduiche,MATERIA1==portugues);
	(LANCHE2==sanduiche,MATERIA2==portugues);
	(LANCHE3==sanduiche,MATERIA3==portugues);
	(LANCHE4==sanduiche,MATERIA4==portugues);
	(LANCHE5==sanduiche,MATERIA5==portugues)
	),
	
	
	% 18. A Renata está entre a menina que vai comer Banana e a Ana, nesta ordem.
	
	(
	(LANCHE1==banana,NOME3==anny,NOME2==renata);
	(LANCHE1==banana,NOME4==anny,(NOME2==renata;NOME3==renata));
	(LANCHE1==banana,NOME5==anny,(NOME2==renata;NOME3==renata;NOME4==renata));
	(LANCHE2==banana,NOME4==anny,NOME3==renata);
	(LANCHE2==banana,NOME5==anny,(NOME3==renata;NOME4==renata));
	(LANCHE3==banana,NOME5==anny,NOME4==renata)
	),


	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%suco     
	suco(SUCO1), suco(SUCO2), suco(SUCO3), suco(SUCO4), 
	suco(SUCO5), 
	alldifferent([SUCO1, SUCO2, SUCO3, SUCO4, SUCO5]),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	% 16. A garota que prefere suco de Abacaxi está em uma das pontas da ﬁla. 
	
	(SUCO1==abacaxi ; SUCO5==abacaxi),
	% 12. A menina que gosta de suco de Morango está em uma das pontas da ﬁla. 
	(SUCO1==morango;SUCO5==morango),

	
	% 20. O suco preferido da Pati é o de Limão. 
	(
	(SUCO1==limao,NOME1==pati);
	(SUCO2==limao,NOME2==pati);
	(SUCO3==limao,NOME3==pati);
	(SUCO4==limao,NOME4==pati);
	(SUCO5==limao,NOME5==pati)
	),

	% 17. A menina que gosta de suco de Morango está exatamente à direita de quem gosta de suco de Maracujá. 
	(
	(SUCO1==maracuja,SUCO2==morango);
	(SUCO2==maracuja,SUCO3==morango);
	(SUCO3==maracuja,SUCO4==morango);
	(SUCO4==maracuja,SUCO5==morango)
	),
	
	% 14. A garota da mochila Amarela gosta de tomar limonada.
	(
	(MOCHILA1==amarelo,SUCO1==limao);
	(MOCHILA2==amarelo,SUCO2==limao);
	(MOCHILA3==amarelo,SUCO3==limao);
	(MOCHILA4==amarelo,SUCO4==limao);
	(MOCHILA5==amarelo,SUCO5==limao)
	),

	% 15. A menina que gosta de História gosta de suco de Laranja.
	
	(
	(MATERIA1==historia,SUCO1==laranja);
	(MATERIA2==historia,SUCO2==laranja);
	(MATERIA3==historia,SUCO3==laranja);
	(MATERIA4==historia,SUCO4==laranja);
	(MATERIA5==historia,SUCO5==laranja)
	),
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%animal     
	animal(ANIMAL1), animal(ANIMAL2), animal(ANIMAL3), animal(ANIMAL4), 
	animal(ANIMAL5), 
	
	alldifferent([ANIMAL1, ANIMAL2, ANIMAL3, ANIMAL4, ANIMAL5]),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	% 5. A garota que que ver a Arara está ao lado da que quer ver o Leão.
	(
	(ANIMAL1==arara,ANIMAL2==leao);
	(ANIMAL2==arara,(ANIMAL1==leao;ANIMAL3==leao));
	(ANIMAL3==arara,(ANIMAL2==leao;ANIMAL4==leao));
	(ANIMAL4==arara,(ANIMAL3==leao;ANIMAL5==leao));
	(ANIMAL5==arara,ANIMAL4==leao)
	),
	
	% 7. A garota que quer ver o Macaco usa uma mochila Branca. 
	
	(
	(ANIMAL1==macaco,MOCHILA1==branco);
	(ANIMAL2==macaco,MOCHILA2==branco);
	(ANIMAL3==macaco,MOCHILA3==branco);
	(ANIMAL4==macaco,MOCHILA4==branco);
	(ANIMAL5==macaco,MOCHILA5==branco)
	),
	
	% 6. A menina da mochila Vermelha está em algum lugar à esquerda da que quer ver o Leão. 
	
	(
	(ANIMAL2==leao,MOCHILA1==vermelho);
	(ANIMAL3==leao,(MOCHILA1==vermelho;MOCHILA2==vermelho));
	(ANIMAL4==leao,(MOCHILA1==vermelho;MOCHILA2==vermelho;MOCHILA3==vermelho));
	(ANIMAL5==leao,(MOCHILA1==vermelho;MOCHILA2==vermelho;MOCHILA3==vermelho;MOCHILA4==vermelho))
	)
	,

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
	% 13. A menina que gosta de suco de Limão está entre a garota que quer ver o Elefante e a que gosta de suco de Maracujá, nesta ordem. 
	
	(
	(ANIMAL1==elefante,SUCO3==maracuja,SUCO2==limao);
	(ANIMAL1==elefante,SUCO4==maracuja,(SUCO2==limao;SUCO3==limao));
	(ANIMAL1==elefante,SUCO5==maracuja,(SUCO2==limao;SUCO3==limao;SUCO4==limao));
	(ANIMAL2==elefante,SUCO4==maracuja,SUCO3==limao);
	(ANIMAL2==elefante,SUCO5==maracuja,(SUCO3==limao;SUCO4==limao));
	(ANIMAL3==elefante,SUCO5==maracuja,SUCO4==limao)
	),

	% 4. A Pati está exatamente à esquerda da garota que quer ver a Girafa
	(
	(NOME1==pati,ANIMAL2==girafa);
	(NOME2==pati,ANIMAL3==girafa);
	(NOME3==pati,ANIMAL4==girafa);
	(NOME4==pati,ANIMAL5==girafa)
	)
	.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
amigas([ ' Problemas ????? ',
         ' revise o codigo acima ',
         ' Revise mais uma vez  ',
         ' Procure o prof  que vai revisar mais uma vez  ',
         ' FOREVER  REVISING CODES ....']).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		% BASE DE DADOS
		mochila(amarelo).
		mochila(azul).
		mochila(branco).
		mochila(verde).
		mochila(vermelho).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		nome(anny).
		nome(aretuza).
		nome(japa).
		nome(pati).
		nome(renata).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		
		materia(biologia).
		materia(geografia).
		materia(historia).
		materia(portugues).
		materia(matematica).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		
		lanche(banana).
		lanche(chocolate).
		lanche(maca).
		lanche(sanduiche).
		lanche(salgado).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		
		suco(abacaxi).
		suco(laranja).
		suco(limao).
		suco(morango).
		suco(maracuja).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		
		animal(leao).
		animal(arara).
		animal(elefante).
		animal(girafa).
		animal(macaco).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
 

% DEFINICAO DE ALLDIFERENT  
	alldifferent([]).
	alldifferent([H|T]):- not(member(H,T)),
	                      alldifferent(T).
	
	imprime_lista([]):- write('\n FIM \n').
	imprime_lista([H|T]):- write('\n......................................\n'),
	                       write(H), write(' : '),
	                       imprime_lista(T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*

QUASE ORIGINAL
	?- go.

.............
verde,japa,matematica,abacaxi,banana,elefante
.............
vermelho,aretuza,historia,laranja,chocolate,arara
.............
amarelo,pati,geografia,limao,salgado,leao
.............
azul,renata,biologia,maracuja,maca,girafa
.............
branco,anny,portugues,morango,sanduiche,macaco
 FIM 

 T1: 11.142291 	 T2: 36.219399  msec
 Tempo total: 25.0771080730  msec
true.

APOS MUDANCAS

......................................
verde,japa,matematica,abacaxi,banana,elefante : 
......................................
vermelho,aretuza,historia,laranja,chocolate,arara : 
......................................
amarelo,pati,geografia,limao,salgado,leao : 
......................................
azul,renata,biologia,maracuja,maca,girafa : 
......................................
branco,anny,portugues,morango,sanduiche,macaco : 
 FIM 

 T1: 45.681035 	 T2: 49.336146  msec
 Tempo total: 3.6551109330  msec
true.

*/
