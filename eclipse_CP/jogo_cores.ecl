
:-lib(ic).
:-inicio.

inicio :-
	%%Fred, Joao, Roberto e Tomas
	[ Fp, Jp, Rp, Tp] :: 1 .. 4,
	%%vermelha, laranja, azul e purpura
	[ Vc, Lc, Ac, Pc] :: 1 .. 4,
	
	%% Fred estah a direita de quem veste azul
	Fp + 1 #= Ac, %% um a frente do de azul
	Jp #= 2,
        Rp #= Pc, %% Roberto estah de purpura
	Tp #\= 1, %% Tomas nao estah em 1 nem em 4
	Tp #\= 4,
        Tp #\= Lc, %% Tomas nao veste laranja

	alldifferent([ Fp, Jp, Rp, Tp]),
	alldifferent([ Vc, Lc, Ac, Pc]),
	append([ Vc, Lc, Ac, Pc], [ Fp, Jp, Rp, Tp], L),
	search(L , 0, first_fail, indomain, complete,[]) ,
	writeln("Fred, Joao, Roberto, Tomas" :[ Fp, Jp, Rp, Tp]),
	writeln("vermelha, laranja, azul, purpura" :[ Vc, Lc, Ac, Pc]).


/*
Fred, Joao, Roberto, Tomas : [1, 2, 4, 3]
vermelha, laranja, azul, purpura : [3, 1, 2, 4]
jogo_cores.ecl compiled 2004 bytes in 0.01 seconds

*/	






 

        


