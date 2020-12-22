% Modelagem: ((H1,M1,P1), (H2,M2,P2), (H3,M3,P3))
% FATOS
prof( advogado ; medico ; engenheiro ).
esposas( patricia ; lucia ; maria ).
%* encerrado os fatos do problema *%
%% Exemplos de regras:
%% no minimo 3 e no maximo 7 elementos por conjunto
3 { casais(carlos,M1,P1) ;
   casais(luis,M2,P2) ; 
   casais(paulo,M3,advogado) } 7 

%* 
2 ou mais elementos por respostas
2 {casais(carlos,M1,P1) ; casais(luis,M2,P2) ;
   casais(paulo,M3,advogado)} 
1 respostas por conjunto ... neste caso 1 por casal
1 {casais(carlos,M1,P1) ; casais(luis,M2,P2) ; 
   casais(paulo,M3,advogado)} 1
*%  
        :-
	esposas(M1),
	esposas(M2),
	esposas(M3),
	prof(P1),
	prof(P2),
	M3 != patricia, %%Patricia NAO eh casada com Paulo
	P1 != medico,   %%Carlos NAO eh medico
	P2 = medico, 
        M2 = maria, %%O medico eh casado com a Maria
	%% lendo o texto, P2 eh medico, pois P3 eh advogado
	P1 != advogado,
	P2 != advogado,
	P1 != P2,
	M1 != M2,   %% varios diferentes
	M1 != M3,
	M2 != M3.

%% Imprimindo a saida:
#show casais/3.




