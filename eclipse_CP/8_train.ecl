:- lib(ic), lib(ic_edge_finder3), lib(branch_and_bound).

train([A0,A1,A2,B0,B1,B2]) :-
    [A0,A1,A2,B0,B1,B2] :: 0..100,%A0: saida do trem A da estacao 0
    D  #= 10,    % duracao da viagem por cada seccao
    B0 #= 15,    % forcar a saida do trem B da estacao 0 para 15
    
    A1 #>= A0 + D,
    A2 #>= A1 + D,
    B1 #>= B0 + D,
    B2 #>= B1 + D,
    
    disjunctive([A0,B1], [D,D]),   % trilho 1
    disjunctive([A1,B0], [D,D]),   % trilho 2
    
    Cost #= A2 + B2, %A2 e B2 = tempo de chegada na ultima estacao

    minimize(labeling([A0,A1,A2,B0,B1,B2]), Cost).
