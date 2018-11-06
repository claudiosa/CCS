%http://rachacuca.com.br/logica/problemas/festival-de-bandas/

/*
Christopher Renkavieski

Execução: time(go2).

Saída:
?- ['Christopher_bandas.pl'].
true.


?- go.

......................................
branca,punk,jade,2009,23,ce : 
......................................
amarela,poprock,roxy,2006,22,mt : 
......................................
azul,grunge,rose,2008,19,sp : 
......................................
verde,gotico,jake,2005,20,mg : 
......................................
vermelha,hardcore,dave,2007,21,am : 
 FIM 

 T1: 255.203236          T2: 257.229305  msec
 Tempo total: 2.0260689050  msec
true.

?- 


*/

go :-
    %% Tempo inicial
    statistics(cputime,T1),
   
    modelo(L), 
    imprime_lista(L),
 
    %% Tempo final
    statistics(cputime ,T2), 
    Tempo_BUSCA is (T2 - T1), 
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Tempo total: ~10f  msec', Tempo_BUSCA), !.

go :- true.

go1 :- (modelo([B1, B2, B3, B4, B5]),
			writeln("\nBanda 1":B1),
			writeln("\nBanda 2":B2),
			writeln("\nBanda 3":B3),
			writeln("\nBanda 4":B4),
			writeln("\nBanda 5":B5)),
			fail.
go1 :- true.

modelo([ (C1, EL1, V1, F1, A1, ED1),
         (C2, EL2, V2, F2, A2, ED2),
	     (C3, EL3, V3, F3, A3, ED3),
		 (C4, EL4, V4, F4, A4, ED4),
		 (C5, EL5, V5, F5, A5, ED5)
        ]):-
	
	%%%%%%%%%%%%%%%%%%%%%%%% Vocalista
	vocalista(V1), vocalista(V2), vocalista(V3), vocalista(V4), vocalista(V5),
	alldifferent([V1, V2, V3, V4, V5]),
	
	%12.Fred (Rose) está na terceira posição
	V3==rose,
	
	%%%%%%%%%%%%%%%%%%%%%%%%% Camisa
	camiseta(C1), camiseta(C2), camiseta(C3), camiseta(C4), camiseta(C5),
	alldifferent([C1, C2, C3, C4, C5]),
	
	%10.David (Dave) está em algum lugar à direita do vocalista de Azul
	(
	(C1==azul, (V2==dave; V3==dave; V4==dave; V5==dave));
	(C2==azul, (V3==dave; V4==dave; V5==dave));
	(C3==azul, (V4==dave; V5==dave));
	(C4==azul, V5==dave)),
	
	%11.Fred (Rose) está em algum lugar à direita do vocalista de Amarelo
	(
	(C1==amarela, (V2==rose; V3==rose; V4==rose; V5==rose));
	(C2==amarela, (V3==rose; V4==rose; V5==rose));
	(C3==amarela, (V4==rose; V5==rose));
	(C4==amarela, V5==rose)),

	%13.O vocalista de Amarelo está em algum lugar à esquerda do André (Jake).
	(
	(C1==amarela, (V2==jake; V3==jake; V4==jake; V5==jake));
	(C2==amarela, (V3==jake; V4==jake; V5==jake));
	(C3==amarela, (V4==jake; V5==jake));
	(C4==amarela, V5==jake)),
	
	%%%%%%%%%%%%%%%%%%%%%%%%% Estilo
	estilo(EL1), estilo(EL2), estilo(EL3), estilo(EL4), estilo(EL5), 
	alldifferent([EL1, EL2, EL3, EL4, EL5]),
	
	%18.Na primeira posição está o vocalista da banda Punk
	EL1==punk,
	
	%14.O vocalista de Amarelo está em algum lugar entre o Marcelo (Jade) e o vocalista da banda de Grunge, nessa ordem
	(
	(V1==jade, C2==amarela, (EL3==grunge; EL4==grunge; EL5==grunge));
	(V1==jade, C3==amarela, (EL4==grunge; EL5==grunge));
	(V1==jade, C4==amarela, EL5==grunge);
	(V2==jade, C3==amarela, (EL4==grunge; EL5==grunge));
	(V2==jade, C4==amarela, EL5==grunge);
	(V3==jade, C4==amarela, EL5==grunge)
	),
	
	%%%%%%%%%%%%%%%%%%%%%%%%% Formação
	formacao(F1), formacao(F2), formacao(F3), formacao(F4), formacao(F5),
	alldifferent([F1, F2, F3, F4, F5]),
	
	%9.Na quinta posição está o vocalista da banda formada em 2007
	F5==2007,
	
	%8.André (Jake) está ao lado do vocalista da banda formada em 2008
	(
	(V1==jake, F2==2008);
	(V2==jake, (F1==2008; F3==2008));
	(V3==jake, (F2==2008; F4==2008));
	(V4==jake, (F3==2008; F5==2008));
	(V5==jake, F4==2008)
	),
	
	%7.Os vocalistas das bandas formadas em 2006 e 2008 estão lado a lado
	(
	(F1==2006, F2==2008);
	(F2==2006, (F1==2008; F3==2008));
	(F3==2006, (F2==2008; F4==2008));
	(F4==2006, (F3==2008; F5==2008));
	(F5==2006, F4==2008)),
	
	%16.O vocalista da banda de Grunge está ao lado do vocalista da banda formada em 2006
	(
	(EL1==grunge, F2==2006);
	(EL2==grunge, (F1==2006; F3==2006));
	(EL3==grunge, (F2==2006; F4==2006));
	(EL4==grunge, (F3==2006; F5==2006));
	(EL5==grunge, F4==2006)),
	
	%%%%%%%%%%%%%%%%%%%%%%%%% Apresentação
	apresentacao(A1), apresentacao(A2), apresentacao(A3), apresentacao(A4), apresentacao(A5),
	alldifferent([A1, A2, A3, A4, A5]),
	
	%4.Quem vai se apresentar às 19 horas está entre quem apresentará às 22 horas e quem apresentará às 20 horas, nessa ordem
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	(
	(A1==22, A2==19, (A3==20; A4==20; A5==20));
	(A1==22, A3==19, (A4==20; A5==20));
	(A1==22, A4==19, A5==20);
	(A2==22, A3==19, (A4==20; A5==20));
	(A2==22, A4==19, A5==20);
	(A3==22, A4==19, A5==20)
	),
	
	%5.A banda do André (Jake) apresentará às 20 horas
	(
	(V1==jake, A1==20);
	(V2==jake, A2==20);
	(V3==jake, A3==20);
	(V4==jake, A4==20);
	(V5==jake, A5==20)),
	
	%15.A banda gótica se apresentará às 20 horas
	(
	(EL1==gotico, A1==20);
	(EL2==gotico, A2==20);
	(EL3==gotico, A3==20);
	(EL4==gotico, A4==20);
	(EL5==gotico, A5==20)),
	
	%17.O vocalista da banda de Hardcore está exatamente à direita do vocalista que apresentará às 20 horas
	(
	(A1==20, EL2==hardcore);
	(A2==20, EL3==hardcore);
	(A3==20, EL4==hardcore);
	(A4==20, EL5==hardcore)
	),
	
	%3.O vocalista da banda mais velha está exatamente à esquerda de quem vai se apresentar às 21 horas
	(
	(F1==2005, A2==21);
	(F2==2005, A3==21);
	(F3==2005, A4==21);
	(F4==2005, A5==21)
	),
	
	%6.O vocalista que fará a última apresentação está exatamente à esquerda do vocalista da banda formada em 2006
	(
	(A1==23, F2==2006);
	(A2==23, F3==2006);
	(A3==23, F4==2006);
	(A4==23, F5==2006)),
	
	%%%%%%%%%%%%%%%%%%%%%%%%% Estado
	estado(ED1), estado(ED2), estado(ED3), estado(ED4), estado(ED5),
	alldifferent([ED1, ED2, ED3, ED4, ED5]),
	
	%22.Na quinta posição está o vocalista da banda formada na região Norte
	ED5==am,
	
	%1.O vocalista de Vermelho é integrante da banda do Amazonas
	(
	(C1==vermelha, ED1==am);
	(C2==vermelha, ED2==am);
	(C3==vermelha, ED3==am);
	(C4==vermelha, ED4==am);
	(C5==vermelha, ED5==am)
	),
	
	%20.O vocalista da banda formada em 2006 está exatamente à esquerda do vocalista da banda de São Paulo
	(
	(F1==2006, ED2==sp);
	(F2==2006, ED3==sp);
	(F3==2006, ED4==sp);
	(F4==2006, ED5==sp)),
	
	%2.O vocalista da banda do Mato Grosso está exatamente à esquerda do vocalista da banda paulista
	(
	(ED1==mt, ED2==sp);
	(ED2==mt, ED3==sp);
	(ED3==mt, ED4==sp);
	(ED4==mt, ED5==sp)
	),
	
	%21.O vocalista da banda mineira está exatamente à direita de quem está de Azul
	(
	(C1==azul, ED2==mg);
	(C2==azul, ED3==mg);
	(C3==azul, ED4==mg);
	(C4==azul, ED5==mg)
	),
	
	%19.Quem está de Branco está ao lado do vocalista da banda formada na região Centro-Oeste
	(
	(C1==branca, ED2==mt);
	(C2==branca, (ED1==mt; ED3==mt));
	(C3==branca, (ED2==mt; ED4==mt));
	(C4==branca, (ED3==mt; ED5==mt));
	(C5==branca, ED4==mt))
	.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modelo([ ' Problemas ????? ',
         ' revise o codigo acima ',
         ' Revise mais uma vez  ',
         ' Procure o prof  que vai revisar mais uma vez  ',
         ' FOREVER  REVISING CODES ....']).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
%Fatos -- BASE DE DADOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
camiseta(amarela).
camiseta(azul).
camiseta(branca).
camiseta(verde).
camiseta(vermelha).

estilo(gotico).
estilo(grunge).
estilo(poprock).
estilo(punk).
estilo(hardcore).

/*
Novos nomes:
André -> Jake
Chris -> Roxy
David -> Dave
Fred -> Rose
Marcelo -> Jade
*/
vocalista(jake).
vocalista(roxy).
vocalista(dave).
vocalista(rose).
vocalista(jade).

formacao(2005).
formacao(2006).
formacao(2007).
formacao(2008).
formacao(2009).

apresentacao(19).
apresentacao(20).
apresentacao(21).
apresentacao(22).
apresentacao(23).

estado(am).
estado(ce).
estado(mg).
estado(mt).
estado(sp).


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
