
compto([ ], 0).
compto([ _ | T], N):-  compto(T,N1),  N is N1+1.

uniao([],X,X).
uniao([X|L1],L2,[X|L3]) :- uniao( L1, L2, L3).

%% uniao([a,c,e], [b,d],  [a, c, e, b, d]).    


x :- findall(X, (nota(X, Y), Y > 7 ), Lx), write(Lx).

/*Suponha os seguintes fatos:*/
nota(joao,5.0).
nota(maria,6.0).
nota(joana,8.0).
nota(mariana,9.0).
nota(cleuza,8.5).
nota(jose,6.5).
nota(jaoquim,4.5).
nota(mara,4.0).
nota(mary,10.0).
         

%% ilusta o fail
%%nota(X, _ ), write(X), nl, fail ; true.

/*Considerando que:
Nota de 7.0 á 10.0 = Aprovado.
Nota de 5.0 á 6.9 = Recuperacao.
Nota de 0.0 á 4.9 = Reprovado.

Escreva uma regra para identificar a situação de um determinado aluno.*/


situacao(NOME,'aprovado') :- nota(NOME,NOTA),NOTA>=7.
situacao(NOME,'reprovado') :- nota(NOME,NOTA),NOTA<5.
situacao(NOME,'recuperacao'):-nota(NOME,NOTA),NOTA<7,NOTA>=5.
