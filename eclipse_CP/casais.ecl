/* 
Os demais nomes de nosso personagens sao:
H = { carlos (c) , luiz (l) , paulo (p) }
M = { maria, lucia, patricia }
P = { advogado (a), medico (m), engenheiro (e) }

Modelagem: (H,M,P) logo ((H1,M1,P1), (H2,M2,P2), (H3,M3,P3))
*/

/* aqui comeca o codigo */

prof(advogado).
prof(medico).
prof(engenheiro).
esposa(patricia).
esposa(lucia).
esposa(maria).

%%x :- deduz(X, Y, Z), write(X), nl, write(Y), nl, write(Z), nl.
 x :- deduz(X, Y, Z), printf("\n X: %w \t Y: %w \t Z: %w " , [X , Y , Z] ).

deduz((carlos,M1,P1), (luis,M2,P2), (paulo,M3,advogado)) :-

 esposa(M1),
 esposa(M2),
 esposa(M3),
 prof(P1),
 prof(P2),
 M3 \== patricia,
 P1 \== medico,
 P1 \== advogado,
 P2 \== advogado,
 P1 \== P2,
 M1 \== M2,
 M1 \== M3,
 M2 \== M3.

/* A restricao a) nao foi atendida: 
 %% O medico eh casado com a Maria
 logo o programa acima deve sofrer uma modificacao:
 basta reler as hipoteses e voce vai concluir  que o 
 programa se reduz a:
 */

y :- deduz2(X, Y, Z), write(X), nl, write(Y), nl, write(Z), nl.
 

deduz2((carlos,M1,P1), (luis,maria,medico), (paulo,M3,advogado)) :-
 esposa(M1),
 esposa(M3),
 prof(P1),
 M3 \== patricia,
 P1 \== medico,
 P1 \== advogado.


/*?- ['casais.pl'].
% casais.pl compiled 0.00 sec, 0 bytes

Yes
?- x.
carlos, patricia, engenheiro
luis, lucia, medico
paulo, maria, advogado

Yes
?- y.
carlos, patricia, engenheiro
luis, maria, medico
paulo, lucia, advogado

Yes
?- 
*/
