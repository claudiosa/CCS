/* BUSCA em PROFUNDIDADE */

/*
   X4
X1,X2,X3
   X5
*/
   
/* movimentos com 2 brancos nesta Cruz .... */

move((X1,X2,X3,X4,X5), (X2,X1,X3,X4,X5)) :-  X2 == '_';  X1 == '_'. 
move((X1,X2,X3,X4,X5), (X1,X3,X2,X4,X5)) :-  X2 == '_';  X3 == '_'.
move((X1,X2,X3,X4,X5), (X1,X4,X3,X2,X5)) :-  X2 == '_';  X4 == '_'.
move((X1,X2,X3,X4,X5), (X1,X5,X3,X4,X2)) :-  X2 == '_';  X5 == '_'. 

inicio :-  
    pt_origem(X),
    busca([[X]], Solucao), /* X  é o nó inicial, logo entra na lista */
    reverse(Solucao, Sol_invertida), 
    write_L(Sol_invertida),
    length(Sol_invertida, Total),
    pt_destino(Y), nl,
    write('Onde a posição inicial era: '), write(X), nl,
    write('E a posição final era: '), write(Y), nl,
    write('Total de estados: '), write(Total), nl,
    Aux is (Total -1),
    write('Total de movimentos: '), write(Aux), !.

inicio:- nl, write('Sem solução ... caminho não encontrado!').


/* pontos iniciais e finais do problema */
pt_origem(  ('#', '@', '*', '_', '_' ) ).
pt_destino( ('_', '@', '_','*','#')  ).

/*************************************************************/
%% cond. de parada.... o nó corrente é o desejado
busca( [ [No_final|Caminho] |_] , [No_final | Caminho ] ):-
        pt_destino(No_final) , !. %% termina a busca...

/* parte recursiva geral */
busca([Nodo|Caminho],Solucao):-
          expandir(Nodo, Novos_caminhos),
          append(Caminho, Novos_caminhos, Novo_caminho),
          busca(Novo_caminho, Solucao).

expandir([Nodo|Caminho],Novos_caminhos) :-
           findall([Novo_nodo, Nodo|Caminho],
           (move(Nodo, Novo_nodo),
           not(member(Novo_nodo,[Nodo|Caminho]))),
           Novos_caminhos), !. /* ultima linha do findall */
expandir(_,[]).

/*************************************************************/
/*
   X4
X1,X2,X3
   X5
*/

w_cruz((X1,X2,X3,X4,X5)) :-
       write('  '), write(X4), nl,
       write(X1), write(' '), write(X2), 
       write(' '), write(X3), write(' '),nl,
       write('  '), write(X5).
 
 write_L([]).
 write_L([X|L]):-  w_cruz(X), nl, nl, write_L(L).
/************************************************************/
