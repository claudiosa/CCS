%
% coloring problem in ASP.
%
% Coloring of some of the countries in Europe.
% 
%
% This was created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also http://www.hakank.org/answer_set_programming/
%

countries(belgium;denmark;france;germany;netherlands;luxembourg).

% 3 colors is not engough
% colors(red;green;blue).
colors(red;green;blue;white).


arc(france,belgium;luxembourg;germany).
arc(luxembourg,germany;belgium).
arc(netherlands,belgium).
arc(germany,belgium;netherlands;denmark).

neighbour(X,Y) :- arc(X,Y).
neighbour(Y,X) :- arc(X,Y).

% Ensure that each country has exactly one color,
% using disjunctions.
% Note: must use --shift in gringo/clingo:
%    clingo --shift coloring.lp
% color(X, red) | color(X, green) | color(X, blue) | color(X, white) :- countries(X).
 
% Ensure that each country has exactly one color,
% with aggregates:
%    clingo coloring.lp
1 {color(X, C) : colors(C) } 3 :- countries(X). 

% Two neighbouring countries cannot have the same color.
:- color(X1, C), color(X2, C), neighbour(X1,X2).

% symmetry breaking
:- color(germany, red).

%#hide.
%show color(X,C).