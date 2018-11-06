%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pai(hommer, bart).
pai(hommer, lisa).
pai(avo_hommer, hommer).
pai(joao, avo_hommer).
pai(joao, irmao_avo_hommer).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
avo(X,Y) :- pai(X,Z), pai(Z,Y). 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ancestral(X,Y) :- pai(X,Y).
ancestral(X,Y) :- pai(X,Z) , ancestral(Z,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% VER FIGURA SOBRE RECURSIVIDADE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
