/*
Fui hah uma festa e  apresentado ha tres casais.
Os maridos tinham profissoes  e esposas distintas.
Apos alguns "goles" me confundi quem era casado com quem,
e as profissoes.
Apenas lembro de alguns fatos, entao me ajude descobrir quem
sao estes casais, com base nos seguintes dados:

1.  O medico eh casado com a Maria;
2.  O Paulo eh advogado;
3.  Patricia nao eh casada com Paulo;
4.  Carlos nao eh medico.

Retirado da revista Coquetel: Problemas de Logica

Os demais nomes de nosso personagens sao:
H = { carlos (c) , luiz (l) , paulo (p) }
M = { maria, lucia, patricia }
P = { advogado (a), medico (m), engenheiro (e) }

Modelagem com FUNCTORES: (H,M,P) logo ((H1,M1,P1), (H2,M2,P2),
(H3,M3,P3))
*/

/* aqui comeca o codigo */

  prof(advogado).
  prof(medico).
  prof(engenheiro).
  esposa(patricia).
  esposa(lucia).
  esposa(maria).
/* encerrado os fatos do problema */

%% x :- deduz1(X, Y, Z), write(X), nl, write(Y), nl, write(Z), nl.

x :- deduz1( functor(X, Y, Z) ),
	write(X),
	nl,
	write(Y),
	nl,
	write(Z), nl.

deduz1( functor( (carlos,M1,P1), (luis,M2,P2), (paulo,M3,advogado) ) )
        :-
	esposa(M1),
	esposa(M2),
	esposa(M3),
	prof(P1),
	prof(P2),
	M3 \== patricia, %%Patricia nao eh casada com Paulo
	P1 \== medico,   %%Carlos nao eh medico
	(P2 == medico, M2 == maria), %%O medico eh casado com a Maria
	%% lendo o texto, P2 eh medico, pois P3 eh advogado
	P1 \== advogado,
	P2 \== advogado,
	P1 \== P2,
	M1 \== M2,
	M1 \== M3,
	M2 \== M3.

/* Relendo as hipoteses, voce vai concluir  que o
 programa se reduz a:
 */

y :- deduz_2(X, Y, Z), write(X), nl, write(Y), nl, write(Z), nl.

deduz_2((carlos,M1,P1), (luis,maria,medico), (paulo,M3,advogado)) :-
	esposa(M1),
	esposa(M3),
	prof(P1),
	M3 \== patricia,
	P1 \== medico,
	P1 \== advogado.


/*?- ['casais.pl'].
% casais.pl compiled 0.00 sec, 0 bytes
Atualizado em nov/2015


*/
