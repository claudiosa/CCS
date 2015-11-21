:- lib(viewable).
:- lib(ic).
bug :- length(Vars, 10), 
		Vars :: 7..17, 
		viewable_create(nome_da_janela, Vars),
		alldifferent(Vars),
		labeling(Vars),nl,
		write(Vars).
