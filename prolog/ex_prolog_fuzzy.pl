/*

FUZZMACH.PRO:

Developed by Alberto Pacheco, 1996-1997

e-mail: apacheco@campus.chi.itesm.mx



This version supports:

- One-goal, one-sample-at-a-time

- Linear Fuzzy Membership Representations (upgradable)

- Zadeh Fuzzy Set Operators (upgradable)

- Centroid Defuzzification Method

- Singleton Geometry Output Space



  To run, type:



?- main.



  Test results:



>0.153846 and 0.800000

>0.153846 and 0.100000

>Centroid: carb = 1.000000 / 0.100000

>carb is ok

>

>0.333333 and 0.055556

>0.055556 and 0.000000e+000

>Centroid: carb = 1.000000 / 0.100000

>carb is rich

>

>0.153846 and 0.800000

>0.153846 and 0.857143

>Centroid: carb = 3.307693 / 0.253846

>carb is rich

>

>Output:

>carb = 13.030303

>



*/





% Operator Definitions



:- op(700, xfx, is).

:- op(720, xfy, and).

:- op(740, xfy, or).

:- op(760, xfx, then).

:- op(780, fx,  if).




/*
% Main Procedure:

%1) Initialization;

%2) Goal with Output Variable
*/


main :-

init(carb),

one_goal(carb).



/*

% Initialization: Clear global working memory

*/

init(Var) :-

retractall(_),

assert(sum1(Var,0.0)),

assert(sum2(Var,0.0)),!.




/*
% Probes all rules with conclusion 'Var'

*/

one_goal(Var) :-

prove( Var is X ),

write(Var),write(' is '),write(X),nl,nl,

   fail.


/*
% Reports the composite solution
*/


one_goal(Var) :-

write('Output: '),

output_value(Var,X),

nl, write(Var), write(' = '), write(X), nl.




/*
%:::  PRODUCTION RULES (FUZZY MODEL'S RULES)  :::



% R-1
*/

ifco   is  low

andhc   is  low

andco2  is  high

thencarb is  ok.



% R-2

ifco   is  high

andhc   is  high

andco2  is  medium

thencarb is  rich.



% R-3

ifco   is  medium

andhc   is  low

andco2  is  high

thencarb is  rich.



% R-4

ifco   is  low

andhc   is  low

andco2  is  medium

orco2  is  low

thencarb is  poor.





%:::  FUZZY SETS DEFINITIONS  :::



fuzzy_set( co,  low,dt,0.0,  1.0,   0.0,  0.0 ).

fuzzy_set( co,  medium,tp,0.3,  1.0,   1.0,  1.7 ).

fuzzy_set( co,  high,at,1.0,  2.5,   0.0,  0.0 ).



fuzzy_set( co2, low,dt,7.0,  8.5,   0.0,  0.0 ).

fuzzy_set( co2, medium,tp,7.5,  8.5,   8.5, 10.0 ).

fuzzy_set( co2, high,at,8.5, 15.0,   0.0,  0.0 ).



fuzzy_set( hc,  low,dt,   150.0, 275.0,  0.0,  0.0 ).

fuzzy_set( hc,  high,at,   150.0, 600.0,  0.0,  0.0 ).





%:::  SINGLETON OUTPUTS  :::



fuzzy_set( carb, poor,sg,5.0,  0.0,   0.0,  0.0 ).

fuzzy_set( carb, ok, sg,10.0, 0.0,   0.0,  0.0 ).

fuzzy_set( carb, rich,sg,15.0, 0.0,   0.0,  0.0 ).





%:::  INPUT VALUES  :::



input_value( 1,  co,   0.9  ).

input_value( 1,  hc, 175.0  ).

input_value( 1, co2,   9.5  ).



/*



% ANOTHER SET OF INPUTS



input_value( 2,  co,   0.33  ).

input_value( 2,  hc, 235.00  ).

input_value( 2, co2,  13.80  ).



input_value( 3,  co,   0.80  ).

input_value( 3,  hc, 100.00  ).

input_value( 3, co2,   9.50  ).



input_value( 4,  co,   3.90  ).

input_value( 4,  hc, 600.00  ).

input_value( 4, co2,   9.90  ).



input_value( 5,  co,   0.50  ).

input_value( 5,  hc,  10.00  ).

input_value( 5, co2,  14.90  ).



*/



/***************************************************************

Prolog Interpreter in Prolog

Based on Dennis Merrit's Article

"Building Custom Rule Engines," PC AI, Mar/Apr 1996.

****************************************************************/



prove(ATTR is VALUE and REST) :-% AND

getav(ATTR, VALUE),

prove(REST),

apply_fuzzy_oper(and_z).

prove(ATTR is VALUE or REST) :-% OR

getav(ATTR, VALUE),

prove(REST),

apply_fuzzy_oper(or_z).

prove(ATTR is VALUE) :-% IS

getav(ATTR,VALUE).



getav(ATTR,VALUE) :-% IF/THEN (CONCLUSION)

if CONDITIONS then ATTR is VALUE,

prove(CONDITIONS),

retract(prem(Mx)),

centroid(ATTR,VALUE,Mx).

getav(ATTR,VALUE) :-

not(if _ then ATTR is _),

rule_translation(ATTR,VALUE).





%:::  IS A BOOLEAN OR A FUZZY RULE?  :::





% FUZZY RULE PROCESSING



rule_translation( T, Cj ) :-

clause( fuzzy_set(T,_,_,_,_,_,_), _ ), !,

input_value( _, T, X ), !,

fuzzification( T, Cj, X ).



% DISCRETE INFERENCE RULE PROCESSING



rule_translation( T, Cj ) :-

input_value( _, T, Cj ), !,

is_true.

rule_translation( T, Cj ) :-

is_false,

nl,write('Error in rule_translation(): Undefined set'),nl,write(T),nl,write(Cj).





%:::  FUZZIFICACION  :::



fuzzification( N, Cj, X ) :-

fuzzy_set( N, Cj, T, A, B, C, D ),

degree_of_membership( T, A, B, C, D, X, M ),

assert(prem(M)), !.





% LINEAR DECREASING FUZZY SET (dt)



degree_of_membership( dt, A, _, _, _, X, 1.0 ) :-

X =< A, !.

degree_of_membership( dt, _, B, _, _, X, 0.0 ) :-

X >= B, !.

degree_of_membership( dt, A, B, _, _, X, M ) :-

line_eq( dt, A, B, X, M ), !.





% LINEAR INCREASING FUZZY SET (at)



degree_of_membership( at, A, _, _, _, X, 0.0 ) :-

X =< A, !.

degree_of_membership( at, _, B, _, _, X, 1.0 ) :-

X >= B, !.

degree_of_membership( at, A, B, _, _, X, M ) :-

line_eq( at, A, B, X, M ), !.





% TRAPEZOIDAL OR TRIANGULAR FUZZY SET



degree_of_membership( tp, A, _, _, _, X, 0.0 ) :-

X =< A, !.

degree_of_membership( tp, A, B, _, _, X, M ) :-

X > A, X =< B,

line_eq( at, A, B, X, M ), !.

degree_of_membership( tp, _, B, C, _, X, 1.0 ) :-

X > B, X < C, !.

degree_of_membership( tp, _, _, C, D, X, M ) :-

X > C, X < D,

line_eq( dt, C, D, X, M ), !.

degree_of_membership( tp, _, _, _, _, _, 0.0 ).  % X>D





%:::  FUZZY OPERATORS  :::



apply_fuzzy_oper( and_z ) :-

retract(prem(M1)),

write(M1),

retract(prem(M2)), !,

write(' and '), write(M2), nl,

min(M1,M2,M),

assert(prem(M)), !.



apply_fuzzy_oper( or_z ) :-

retract(prem(M1)),

write(M1),

retract(prem(M2)),!,

write(' or '), write(M2), nl,

max(M1,M2,M),

assert(prem(M)), !.





%:::  CENTROID DEFUZZIFICATION METHOD  :::



centroid(Var,Sg,Memb) :-

fuzzy_set(Var,Sg,sg,S,_,_,_),!,

P is (S*Memb),

retract(sum1(Var,Q)),

R is (P+Q),

assert(sum1(Var,R)),

retract(sum2(Var,N)),

M is (Memb+N),

assert(sum2(Var,M)),

write('Centroid: '),write(Var),write(' = '),write(R/M),nl,!.





%:::  END OF DEFUZZIFICATION METHOD  ::::



output_value(Var,X) :-

retract(sum1(Var,P)),

retract(sum2(Var,Q)),

P > 0.0,

Q > 0.0,!,

X is P/Q.



output_value(_,0.0) :- !.





%:::  LINEAR INTERPOLATION  :::



line_eq( dt, X1, X2, X, Y ) :-

Y is (X2 - X) / (X2 - X1).



line_eq( at, X1, X2, X, Y ) :-

Y is (X - X1) / (X2 - X1).





%::: BOOLEAN VALUES  :::



is_true :- assert(prem(1.0)), !.



is_false :- assert(prem(0.0)), !.





%:::  FUZZY FUNCTION PRIMITIVES  :::



min( X, Y, X ) :- X < Y, !.

min( _, Y, Y ).



max( X, Y, X ) :- X > Y, !.

max( _, Y, Y ).