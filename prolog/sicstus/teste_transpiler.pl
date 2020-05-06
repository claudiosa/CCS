:- use_module(library(transpiler)).
:- set_prolog_flag(double_quotes,chars).
:- initialization(main).

main :- 
	translate("function add(a,b){return a + b;}",javascript,lua,X),
	atom_chars(Y,X),
	writeln(Y).
