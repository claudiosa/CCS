%  clingo 08_lesson.lp 0
%%% BASE DE FATOS ...
prof( advogado ; medico ; engenheiro ).
esposas( patricia ; lucia ; maria ).
homens( luis ; paulo; carlos ).

%*
 Encerrado os fatos do problema 
*%
%%% EQUIVALENTE UM TODOS DIFERENTES ....
1 { casal(H, M, P) : homens(H), esposas(M)} 1 :- prof(P).
%% UM CONJUNTO COM TODOS OS PARES repetidos ou nao de H e M,
%% mas profissoes DIFERENTES
%% AND
1 { casal(H, M, P) : homens(H), prof(P) } 1  :- esposas(M).
%% idem para esposas diferentes
%% AND
1 { casal(H, M, P) : esposas(M), prof(P) } 1 :- homens(H).
%% idem para homens diferentes
%* UMA COMBINACAO destes 3 conjuntos fornece um 
   ALL_DIFFERENT, classico
   Estas 3 regras foram a chave deste problema
*%
%% AS RESTRICOES

%% NOT ALLOWED
:- casal(carlos,_,medico).         %% Carlos NAO eh medico
:- casal(paulo, patricia, _).      %% Patricia NAO eh casada com Paulo

%% ALLOWED
:- not casal(paulo , _, advogado). %% O Paulo EH advogado
:- not casal(_, maria , medico).   %% O medico EH casado com a Maria

#show casal/3.

%* 
THE END -- FIM   
*%


