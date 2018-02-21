/* From the book PROLOG PROGRAMMING IN DEPTH
   by Michael A. Covington, Donald Nute, and Andre Vellino.
   Copyright 1988 Scott, Foresman & Co.
   Non-commercial distribution of this file is permitted. */
/* Modified for Quintus Prolog by Andreas Siebert */

/* MAP.PL */

/* This file uses the writeln routine in file WRITELN.PL. */
:- ( clause(writeln(_),_) ; consult('writeln.pl') ).

map :- color_map([],Solution), writeln(Solution).

color_map(Solution,Solution) :-
          \+ remaining(_,Solution).

color_map(List,Solution) :-
     remaining(Country,List),
     color(Hue),
     \+ prohibited(Country,Hue,List),
     write(Country),nl,
     color_map([[Country,Hue]|List],Solution).

remaining(Country,List) :- country(Country),
                           \+ member([Country,_],List).

prohibited(Country,Hue,List) :-
     borders(Country,Neighbor),
     member([Neighbor,Hue],List).

borders(Country,Neighbor) :- beside(Country,Neighbor).
borders(Country,Neighbor) :- beside(Neighbor,Country).

member(X,[X|_]).
member(X,[_|Y]) :- member(X,Y).

/* Only four colors are ever needed */

color(red).
color(blue).
color(green).
color(yellow).

/* Geographical data for South America. */

country(antilles).       country(argentina).
country(bolivia).        country(brazil).
country(columbia).       country(chile).
country(ecuador).        country(french_guiana).
country(guyana).         country(paraguay).
country(peru).           country(surinam).
country(uruguay).        country(venezuela).

beside(antilles,venezuela).   beside(argentina,bolivia).
beside(argentina,brazil).     beside(argentina,chile).
beside(argentina,paraguay).   beside(argentina,uruguay).
beside(bolivia,brazil).       beside(bolivia,chile).
beside(bolivia,paraguay).     beside(bolivia,peru).
beside(brazil,columbia).      beside(brazil,french_guiana).
beside(brazil,guyana).        beside(brazil,paraguay).
beside(brazil,peru).          beside(brazil,surinam).
beside(brazil,uruguay).       beside(brazil,venezuela).
beside(chile,peru).           beside(columbia,ecuador).
beside(columbia,peru).        beside(columbia,venezuela).
beside(ecuador,peru).         beside(french_guiana,surinam).
beside(guyana,surinam).       beside(guyana,venezuela).

