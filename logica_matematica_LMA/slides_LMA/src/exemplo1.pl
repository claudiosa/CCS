mulher(patricia).
mulher(lucia).
mulher(maria).

profissao(advogado).
profissao(medico).
profissao(engenheiro).

festa((carlos,M1,P1),(luis,M2,P2),(paulo,M3,P3)) :-
	mulher(M1),mulher(M2),mulher(M3),
	M1\==M2,M1\==M3,M2\==M3,
	profissao(P1),profissao(P2),profissao(P3),
	P1\==P2,P1\==P3,P2\==P3,
	((P1==medico,M1==maria);(P2==medico,M2==maria)),
	P3==advogado,
	M3\==patricia,
	P1\==medico.
