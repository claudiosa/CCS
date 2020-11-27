% $ clingo casais_asp.pl 0

% Fui hah uma festa e  apresentado ha tres casais.
% Os maridos tinham profissoes  e esposas distintas.
% Apos alguns "goles" me confundi quem era casado com quem,
% e as profissoes.
% Apenas lembro de alguns fatos, entao me ajude descobrir quem
% sao estes casais, com base nos seguintes dados:

% 1.  O medico eh casado com a Maria;
% 2.  O Paulo eh advogado;
% 3.  Patricia nao eh casada com Paulo;
% 4.  Carlos nao eh medico.

% Retirado da revista Coquetel: Problemas de Logica

% Os demais nomes de nosso personagens sao:
% H = { carlos (c) , luiz (l) , paulo (p) }
% M = { maria, lucia, patricia }
% P = { advogado (a), medico (m), engenheiro (e) }

% Modelagem com FUNCTORES: (H,M,P) logo ((H1,M1,P1), (H2,M2,P2),
% (H3,M3,P3))
% */

% /* aqui comeca o codigo */

prof( advogado ; medico ; engenheiro ).
esposas( patricia ; lucia ; maria ).




% /* encerrado os fatos do problema */
%3{ casais(carlos,M1,P1) ; casais(luis,M2,P2) ; casais(paulo,M3,advogado) } 3 
2 {casais(carlos,M1,P1) ; casais(luis,M2,P2) ; casais(paulo,M3,advogado)} 
        :-
	esposas(M1),
	esposas(M2),
	esposas(M3),
	prof(P1),
	prof(P2),
	M3 != patricia, %%Patricia nao eh casada com Paulo
	P1 != medico,   %%Carlos nao eh medico
	P2 = medico, 
        M2 = maria, %%O medico eh casado com a Maria
	%% lendo o texto, P2 eh medico, pois P3 eh advogado
	P1 != advogado,
	P2 != advogado,
	P1 != P2,
	M1 != M2,
	M1 != M3,
	M2 != M3.


#show casais/3.
%%%#show [X, Y, Z] : casais(X,Y,Z) .

% /* Relendo as hipoteses, voce vai concluir  que o
%  programa se reduz a:
%  */


