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
% conferir com o resultado de PROLOG
% em ASP eh:
% casais(paulo,lucia,advogado) casais(luis,maria,medico) casais(carlos,patricia,engenheiro)
%

%* 
 Aqui comeca o codigo ===> BLOCO COMENTARIOS
 UFA ....
*%

prof( advogado ; medico ; engenheiro ).
esposas( patricia ; lucia ; maria ).


%* encerrado os fatos do problema 
*%

%% ao main SET
3 { casais(carlos,M1,P1) ; casais(luis,M2,P2) ; casais(paulo,M3,advogado) } 3 
%2 {casais(carlos,M1,P1) ; casais(luis,M2,P2) ; casais(paulo,M3,advogado)} 3
%1 {casais(carlos,M1,P1) ; casais(luis,M2,P2) ; casais(paulo,M3,advogado)} 3
        :-
    quem_sao_as_esposas(M1,M2,M3),		    
	prof(P1),
	prof(P2),
	P1 != medico,   %%Carlos nao eh medico
	P2 = medico, 
    
	%% lendo o texto, P2 eh medico, pois P3 eh advogado
	P1 != advogado,
	P2 != advogado,
	P1 != P2.

quem_sao_as_esposas(M1,M2,M3) :-
	%esposas(M1; M2; M3),
	esposas(M1),
	esposas(M2),
	esposas(M3),
    M3 != patricia, %%Patricia nao eh casada com Paulo
    M2 = maria, %%O medico eh casado com a Maria
%   not_equal(M1,M2,M3). 	
	M1 != M2,
	M1 != M3,
	M2 != M3.

%*  NAO HA CASAMENTO .... em ASP ... it is not PROLOG
not_equal(M1,M2,M3) :- 
	M1 != M2,
	M1 != M3,
	M2 != M3.
:-  not_equal(_,_,_).
*%

#show casais/3.
%%%#show [X, Y, Z] : casais(X,Y,Z) .

%* Relendo as hipoteses, voce vai concluir  que o
   programa se reduz a:
*%


