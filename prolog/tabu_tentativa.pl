/*
2 - Coloração de Mapas com Busca Tabu

Resolva o clássico problema da coloração dos mapas utilizando a busca tabu. Ver detalhes na apresentação no site. Considerando que esta estratégia construtiva baseado em busca  locais, uma abordagem rápida quanto a implementação, pode ser utilizada uma combinação  com uma busca em profundidade ou largura vista no exercício anterior.
*/
	/* Problema de coloracao de mapas */

/*
num_aleat([1,2,3,4],X). 
lista_pares([(a,x),(b,Y),(c,Y),(d,W),(e,V),(f,R),(g,x),(h,x),(i,x),(j,V),(k,V)(l,x),(m,R),(n,R)],Z).
energia(L,E).
L = [(a,1),(b,5),(c,5),(d,10),(e,3),(f,2),(g,1),(h,1),(i,1),(j,3),(k,3),(l,1),(m,2),(n,2)]
*/

imprima([]):- !.
imprima([Cabeca|Cauda]):- !,
                 write(Cabeca), 
                 nl, 
                 imprima(Cauda).
imprima(Arg):- write(Arg),nl.

mapa :- cor_mapa([],Solucao), imprima(Solucao).

cor_mapa(Solucao,Solucao) :-
     \+ busca(_,Solucao).

cor_mapa(Lista,Solucao) :-
     busca(PAIS,Lista),
     cor(COR),
     \+ tabu(PAIS,COR,Lista),
     write(PAIS), nl ,
     cor_mapa([[PAIS,COR]|Lista],Solucao).

/* N = Nmax .. numero de iteracoes... */
busca_tabu(N, Tam, Lmapa_corrente, [Lmapa_corrente|Historia], N ) :-
    write( [Lmapa_corrente|Historia]), 
    write('\n Atingiu o max de iterações '), !.   

/* Achou resultado */
busca_tabu(N, Tam, Lmapa_corrente, [Lmapa_corrente|Historia], _ ) :-
    f_enercia(Lmapa_corrente,E), E == 0, write('\n Nenhum país em colisão '), !.

/* caso o mapa não esteja colorido, E =/= 0, e o N < Nmax */
busca_tabu(N, Tam, Lmapa_corrente, [Lmapa_corrente|Historia], Nmax ) :- 
      Nnew is 1 + N, %%  incremento 
      gera_novo_estado(Lmapa_corrente , Lnew),
      not(member_aux(Lnew,  Historia ),
      insere(Lnew, [Lmapa_corrente|Historia], Ltabu_nova),
      /* troca um novo estado por algum da lista tabu */
        
      busca_tabu(N, Tam, Lnew, Ltabu_nova,  Nmax  ).   

tabu(PAIS,COR,Lista) :-
     tem_fronteira(PAIS,Neighbor),
     member( [Neighbor,COR], Lista) .


/* Apenas 04 cores são o suficiente */

cor(vermelho).
cor(azul).
cor(verde).
cor(amarelo).

/* Geographical data for South America. */

pais(antilles).       pais(argentina).
pais(bolivia).        pais(brazil).
pais(columbia).       pais(chile).
pais(ecuador).        pais(french_guiana).
pais(guyana).         pais(paraguay).
pais(peru).           pais(surinam).
pais(uruguay).        pais(venezuela).

vizinho(antilles,[venezuela]).
vizinho(argentina,[brazil,paraguay,bolivia,chile,uruguay]).
vizinho(bolivia,[brazil,paraguay,argentina,chile,peru]).
vizinho(brazil,[argentina,bolivia,columbia,guyana,peru,uruguay,french_guiana,paraguay,surinam,venezuela]).
vizinho(chile,[peru,argentina,bolivia]).
vizinho(columbia,[brazil,ecuador]).
vizinho(ecuador,[columbia]).
vizinho(french_guiana,[brazil]).
vizinho(guyana,[brazil]).
vizinho(paraguay,[argentina,bolivia,brasil]).
vizinho(peru,[brazil,chile,bolivia]).
vizinho(surinam,[brazil]).
vizinho(uruguay,[brazil,argentina]).
vizinho(venezuela,[brazil,antilles]).
