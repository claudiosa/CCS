%  clingo 08_lesson.lp 0

%* 
 Fui hah uma festa e  apresentado ha tres casal.
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
*%
% Modelagem com FUNCTORES: (H,M,P) logo ((H1,M1,P1), (H2,M2,P2),
% (H3,M3,P3))
% conferir com o resultado de PROLOG
% em ASP eh:
% casal(paulo,lucia,advogado) casal(luis,maria,medico) casal(carlos,patricia,engenheiro)
%*
ESPERADO ...
casal(paulo,lucia,advogado) 
casal(luis,maria,medico) 
casal(carlos,patricia,engenheiro)
 
 Aqui comeca o codigo ===> BLOCO COMENTARIOS
 UFA ....
*%

%%% BASE DE FATOS ...
prof( advogado ; medico ; engenheiro ).
esposas( patricia ; lucia ; maria ).
homens( luis; paulo; carlos ).

%*
 Encerrado os fatos do problema 
*%
%%% EQUIVALENTE UM TODOS DIFERENTES ....
1 { casal(H, M, P) : homens(H), esposas(M)} 1 :- prof(P).
%% UM CONJUNTO COM TODOS OS PARES repetidos ou nao de H e M,
%% mas prof DIFERENTES
1 { casal(H, M, P) : homens(H), prof(P) } 1  :- esposas(M).
%% idem para esposas diferentes
1 { casal(H, M, P) : esposas(M), prof(P) } 1 :- homens(H).
%% idem para homens diferentes

%%% UMA COMBINACAO destes 3 conjuntos fornece um ALL_DIFFERENT

%% AS RESTRICOES

:- casal(carlos,_,medico).         %% Carlos NAO eh medico
:- casal(paulo, patricia, _).      %% Patricia NAO eh casada com Paulo
:- not casal(paulo , _, advogado). %% O Paulo EH advogado
:- not casal(_, maria , medico).   %% O medico EH casado com a Maria

#show casal/3.

%* 
THE END -- FIM   
*%


