/* :-lib(ic_symbolic). */
:- lib(ic).

prof(1, medico).
prof(3, advogado).
prof(2, engenheiro).
m(1, patricia).
m(2, lucia).
m(3, maria).

x :- deduz((carlos,M1,P1), (luis,M2,P2), (paulo,M3,advogado)), 
     m(M1,E1), m(M2,E2), m(M3,E3), 
     prof(P1,P1_out) , prof(P2,P2_out),
     writeln(" A saida e dada por : "),
     writeln((carlos,E1,P1_out)),
     writeln((luis,E2,P2_out)),
     writeln((paulo,E3,advogado)).
     
deduz((carlos,M1,P1), (luis,M2,P2), (paulo,M3,advogado)) :-
    [M1,M2,M3] :: 1 .. 3,
    [P1,P2] :: 1.. 2,
     P2 #= 1,
     M2 #= 3,
     M3 #\= 1,
     P1 #\= 1,
     P1 #\= P2,
     alldifferent([M1,M2,M3]).
     
