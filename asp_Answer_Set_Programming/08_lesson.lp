% $ clingo casal_asp.pl 0

% Fui hah uma festa e  apresentado ha tres casal.
% Os maridos tinham profissoes  e esposas distintas.
% Apos alguns "goles" me confundi quem era casado com quem,
% e as profissoes.
% Apenas lembro de alguns fatos, entao me ajude descobrir quem
% sao estes casal, com base nos seguintes dados:

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
% casal(paulo,lucia,advogado) casal(luis,maria,medico) casal(carlos,patricia,engenheiro)
%*
ESPERADO ...
casal(paulo,lucia,advogado) 
casal(luis,maria,medico) 
casal(carlos,patricia,engenheiro)
 
 Aqui comeca o codigo ===> BLOCO COMENTARIOS
 UFA ....
*%

prof( advogado ; medico ; engenheiro ).
esposas( patricia ; lucia ; maria ).


%* encerrado os fatos do problema 
*%

1 {casal(carlos,M,P) : esposas(M) ,  prof(P)} 1 .
1 {casal(luis,M,P) : esposas(M),  prof(P)}  1 .
1 {casal(paulo,M,P) : esposas(M),  prof(P)} 1 .

 %1{casal(carlos,M1,_); casal(luis,M2,_); casal(paulo,M3,_)} 1 :-
 %  M1 != M2, M1 != M3, M2 != M3. 


:- casal(carlos,_,medico).    %%Carlos nao eh medico
:- casal(paulo,patricia,_).   % Patricia nao eh casada com Paulo
:- not casal(paulo,_,advogado).   % O Paulo eh advogado;
:- not casal(_, maria , medico). %%O medico eh casado com a Maria

%%% Woman and ocupation are different
%:- casal(carlos,M1,_), casal(luis,M2,_), casal(paulo,M3,_), M1 = M2, M1 = M3, M2=M3. 
%:- casal(carlos,_,P1), casal(luis,_,P2),  casal(paulo,_,P3), P1 = P2, P1 = P3, P2=P3. 



#show casal/3.
%%%#show [X, Y, Z] : casal(X,Y,Z) .

%* 
   Relendo as hipoteses, voce vai concluir  que o
   programa se reduz a:
*%


