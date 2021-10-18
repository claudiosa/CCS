/* Apenas 04 cores são o suficiente */

cor(vermelho).
cor(azul).
cor(verde).
cor(amarelo).

/* Geographical data for South America. */

pais(antilles).       pais(argentina).
pais(bolivia).        pais(brazil).
pais(columbia).       pais(chile).
pais(ecuador).        pais(french_guiana).
pais(guyana).         pais(paraguay).
pais(peru).           pais(surinam).
pais(uruguay).        pais(venezuela).


% alldifferent positions
%1 { pos(Runner, Position) : positions(Position) } 1 :- runners(Runner).
%1 { pos(Runner, Position) : runners(Runner) } 1 :- positions(Position).

 1{ pais_color(P, C) : cor(C) } 1 :- vizinho(P,P1), pais_color(P1,C1), C \= C1.
 1{ pais_color(P, C) : pais(P) } 1 :- vizinho(P,P1), pais_color(P1,C1), C \= C1.


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