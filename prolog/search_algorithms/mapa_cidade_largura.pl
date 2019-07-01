/* BUSCA em LARGURA - MAPA em formato de ruas e quadras...
           a        b        c        d
           |        |        |        |
           |        |        |        |
1 ---------+--------+--------+--------+--------
           |        | (3,b/c)|        |
           |        | ou     |        |
           |        | (3,b/c)|        |
2 ---------+--------+---*----+--------+--------
           |        |        |        |
           |        |        |        |
           |        |        |        |
3 ---------+--------+--------+--------+--------
           |        |        |        |
           |        |        |        * (d,3/4)
           |        |        |        | ou (d,4/3)
4 ---------+--------+--------+--------+--------
           |        |        |        |
           |        |        |        |

Localização de qualquer ponto é dado por: ( Rua , Quadra_1/Quadra_2)

*/

inicio :-  
    pt_origem(X),
    caminho(X, Solucao),
    reverse(Solucao, Sol_invertida), 
    write(Sol_invertida),
    pt_destino(Y), nl,
    write('Onde o ponto de origem do mapa era: '), write(X), nl,
    write('E o ponto de destino do mapa era: '), write(Y).

/******************************************
 * Rrepresentação de um MAPA QUALQUER     *
 *****************************************/
mapa([(1,a/b),(2,a/b),(3,a/b),(4,a/b),
      (1,b/c),(2,b/c),(3,b/c),(4,b/c),
      (1,c/d),(2,c/d),(3,c/d),(4,c/d),
      (a,1/2),(a,2/3),(a,3/4),
      (b,1/2),(b,3/2),(b,3/4),
      (c,1/2),(c,2/3),(c,3/4),
      (d,1/2),(d,3/2),(d,3/4)
     ]).

/* pontos iniciais e finais do problema*/
pt_origem((1,a/b)).
pt_destino((d,3/4)).
/*************************************************************/
caminho(Nodo_inicial, Solucao):-
        busca([ [Nodo_inicial] ] , Solucao),!.
caminho(_,_) :- nl, write('Sem solução ... caminho não encontrado').

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
               (conexao(Nodo, Novo_nodo),
               not(member(Novo_nodo,[Nodo|Caminho]))),
               Novos_caminhos), !.
expandir(_,[]).
/*************************************************************/
/**** Com base no objetivo do Problema .. adaptar aqui....   */
conexao(A,B) :- mapa(Mapa), imediato(A,Mapa,B).

/* Próximo ponto: na mesma rua */
imediato((X,Y/Z),[(Rua,Q1/Q2)| _ ], (Rua,Q1/Q2)):-
                           (X == Rua ) , na_quadra(Y, Z, Q1, Q2).   

/* Próximo ponto: quadra a direita do ponto corrente */
imediato((X,Y/Z),[(Rua,Q1/Q2)| _ ], (Rua,Q1/Q2)):-
                           (X == Q1 ) , na_quadra(Y, Z, Rua, Q2).
  
/* Próximo ponto: quadra a esquerda do ponto corrente  */
imediato((X,Y/Z),[(Rua,Q1/Q2)| _ ], (Rua,Q1/Q2)):-
                           (X == Q2 ) , na_quadra(Y, Z, Rua, Q1).
  
/* Próximo ponto: regra geral recursiva */
imediato((X,Y/Z),[_|L], (Rua,Q1/Q2)):-imediato((X,Y/Z), L , (Rua,Q1/Q2)).

na_quadra(Y, Z, Q1, Q2) :- /* combinações ao próximo ponto */
            ((Q1 == Y),!) ; 
            ((Q2 == Z),!) ; 
            ((Q1 == Z),!) ; 
             (Q2 == Y).
/******************************************************/
/*
?- inicio.
[ (1, a/b), (1, b/c), (1, c/d), (d, 1/2), (d, 3/2), (d, 3/4)]
Onde o ponto de origem do mapa era: 1, a/b
E o ponto de destino do mapa era: d, 3/4

Yes
?-  
*********************************************************/
