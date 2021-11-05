
% $ clingo color_map.lp 1
% by Susana
% clingo color_map.lp 1 --out-ifs='\n' --out-atomf=%s.  
%  clingo color_map.lp 1 --out-ifs='\n' --out-atomf=%s --text 

%/* Colors availble */

color(red).
color(blue).
color(green).
color(yellow).
%% For tests
%color(xxxxxxxxxx).
%color(yyyyyyyyyy).

%/* Geographical data for South America. */
%% For tests
%country(argentina).
%country(brazil).
%country(uruguay).
%country(chile).

country(antilles).       country(argentina).
country(bolivia).        country(brazil).
country(columbia).       country(chile).
country(ecuador).        country(french_guiana).
country(guyana).         country(paraguay).
country(peru).           country(surinam).
country(uruguay).        country(venezuela).

%%% the map of South America 
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


%  Country X Colors - Assign any color for each country, producing a set
1 { country_color(P, C) : color(C) } 1 :- country(P).

%% specify a color for a country 
% { country_color(P,C)} = 1 :- P = brazil, C = green.
% by Susana - ASP Community
% Equivalent to:
% country_color(brazil,green).
% Equivalent to:
:- not country_color(brazil,green).


%% The major rule or general solve
% C != C1 :- country_color(P, C), country_color(P1, C1), neighbour(P,P1).
% by Susana - ASP Community
:- country_color(P, C), country_color(P1, C), neighbour(P,P1).

%% number of colors used
n_colors(N) :-   N = #count{C : country_color(P,C)}.

%% A minimizations on this set
#minimize{ N : n_colors(N) }.
%#hide country_color(brazil,verde).
#show country_color/2.
#show n_colors/1.

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


