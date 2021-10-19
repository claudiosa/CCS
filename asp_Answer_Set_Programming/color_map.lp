
% $ clingo color_map.lp 1

%/* Colors availble */

color(red).
color(blue).
color(green).
color(yellow).

%/* Geographical data for South America. */
country(antilles).       country(argentina).
country(bolivia).        country(brazil).
country(columbia).       country(chile).
country(ecuador).        country(french_guiana).
country(guyana).         country(paraguay).
country(peru).           country(surinam).
country(uruguay).        country(venezuela).

%%% the map 
neighbour(antilles,venezuela).   neighbour(argentina,bolivia).
neighbour(argentina,brazil).     neighbour(argentina,chile).
neighbour(argentina,paraguay).   neighbour(argentina,uruguay).
neighbour(bolivia,brazil).       neighbour(bolivia,chile).
neighbour(bolivia,paraguay).     neighbour(bolivia,peru).
neighbour(brazil,columbia).      neighbour(brazil,french_guiana).
neighbour(brazil,guyana).        neighbour(brazil,paraguay).
neighbour(brazil,peru).          neighbour(brazil,surinam).
neighbour(brazil,uruguay).       neighbour(brazil,venezuela).
neighbour(chile,peru).           neighbour(columbia,ecuador).


%  Country X Colors
1 { country_color(P, C) : color(C) } 1 :- country(P).
%% specify a color for a country 
{ country_color(P,C)} = 1 :- P = brazil, C = green.

%% The major rule or general solve
C != C1 :- country_color(P, C), country_color(P1, C1), neighbour(P,P1).


%#hide country_color(brazil,verde).
#show country_color/2.

%#show  so_neighbour_de/2.



% 1 { country_color(P, C) : country(P), color(C) }   10 .
% { country_color(P, C) : country(P), color(C) }  = 1 .


%1 {so_neighbour_de(P1,C1) : country_color(P,C)} 1 :- P1 = brazil, C1 = verde.
%country_color(P, C) :-  country(P), color(C), country(P1), color(C1) , neighbour(P,P1), C != C1.

% it's work
%:- country_color(brazil, amarelo). 
%:- country_color(brazil, vermelho). 
%:- country_color(brazil, azul).
%:- country_color(brazil, verde). -- UNSATISFIABLE

% No works
%:- country_color(brazil, C) , color(C),   C = vermelho, C = azul, C = amarelo.
%{ country_color(P, C) : color(C) } = 1 :- neighbour(P,P1), country_color(P1,C1), C != C1.
%{ country_color(P, C) : country(P) } = 1 :- neighbour(P,P1), country_color(P1,C1), C != C1.

