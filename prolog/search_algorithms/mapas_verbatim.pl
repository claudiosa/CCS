\begin{verbatim}
/* coloracao dos paises */
writeln([]) :- !.
writeln([Head|Tail]) :- !, write(Head), nl, writeln(Tail).
writeln(Arg) :- write(Arg),nl.

mapa :- cor_mapa([],Solution), writeln(Solution).

cor_mapa(Solution,Solution) :-
          \+ restando_mais_algum(_,Solution).

cor_mapa(List,Solution) :-
     restando_mais_algum(PAIS,List),
     cor(COR),
     \+ proibido(PAIS,COR,List),
     write(PAIS), nl ,
     cor_mapa([[PAIS,COR]|List],Solution).

restando_mais_algum(PAIS,List) :- pais(PAIS),
                           \+ member([PAIS,_],List).

proibido(PAIS,COR,List) :-
     faz_fronteira(PAIS,Neighbor),
     member( [Neighbor,COR], List) .

faz_fronteira(PAIS,Neighbor) :- vizinho(PAIS,Neighbor).
faz_fronteira(PAIS,Neighbor) :- vizinho(Neighbor,PAIS).

/* Apenas 04 cores são o suficiente */

cor(red).
cor(blue).
cor(green).
cor(yellow).

/* Geographical data for South America. */

pais(antilles).       pais(argentina).
pais(bolivia).        pais(brazil).
pais(columbia).       pais(chile).
pais(ecuador).        pais(french_guiana).
pais(guyana).         pais(paraguay).
pais(peru).           pais(surinam).
pais(uruguay).        pais(venezuela).

vizinho(antilles,venezuela).   vizinho(argentina,bolivia).
vizinho(argentina,brazil).     vizinho(argentina,chile).
vizinho(argentina,paraguay).   vizinho(argentina,uruguay).
vizinho(bolivia,brazil).       vizinho(bolivia,chile).
vizinho(bolivia,paraguay).     vizinho(bolivia,peru).
vizinho(brazil,columbia).      vizinho(brazil,french_guiana).
vizinho(brazil,guyana).        vizinho(brazil,paraguay).
vizinho(brazil,peru).          vizinho(brazil,surinam).
vizinho(brazil,uruguay).       vizinho(brazil,venezuela).
vizinho(chile,peru).           vizinho(columbia,ecuador).
/***************/
\end{verbatim}
