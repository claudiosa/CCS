:- use_module(library('bounds')).
:- use_module(library('lists')).
%:- use_module(library(clpfd)).

geraListaMovs(0,L) :- L = [], !.
geraListaMovs(NumMovs,[[Checker,Move]|T]) :-
        Checker in 1..5,
        Move in 1..6,
        N #= NumMovs - 1,
        labeling([ff],[Checker,Move]),  
        geraListaMovs(N,T).

replace([],_,_,_) :-
        fail.
replace([_|T],Elem,1,[HR|R]) :-
        HR = Elem,
        R = T,
        !.
replace([H|T],Elem,Index,[H|R]) :-
        succ(II,Index),
        replace(T,Elem,II,R).
        
        
pegaElem(_,[],_) :-
        fail.
pegaElem(1,[H|_],Elem) :-
        Elem = H,
        !.
pegaElem(Index,[_|T],Elem) :-
        succ(Ind,Index),
        pegaElem(Ind,T,Elem).

posicaoFinal1(Checkers) :-
        Checkers = [[CX1, _], [CX2, _], [CX3, _], [CX4, _], [CX5, _]],
        all_different(Checkers),
        CX1 #= 3,
        CX2 #= 3,
        CX3 #= 3,
        CX4 #= 3,
        CX5 #= 3,
        writeln(Checkers).

posicaoFinal2(Checkers) :-
        Checkers = [[CX1, CY1], [CX2, CY2], [CX3, CY3], [CX4, CY4], [CX5, CY5]],
        all_different(Checkers),
        CX1 + CY1 #= 6,
        CX2 + CY2 #= 6,
        CX3 + CY3 #= 6,
        CX4 + CY4 #= 6,
        CX5 + CY5 #= 6,
        writeln(Checkers).

posicaoFinal3(Checkers) :-
        Checkers = [[_, CY1], [_, CY2], [_, CY3], [_, CY4], [_, CY5]],
        all_different(Checkers),
        CY1 #= 3,
        CY2 #= 3,
        CY3 #= 3,
        CY4 #= 3,
        CY5 #= 3,
        writeln(Checkers).

posicaoFinal(Checkers) :-
        posicaoFinal1(Checkers);
        posicaoFinal2(Checkers);
        posicaoFinal3(Checkers).

percorreListaMovs(Checkers, []) :- posicaoFinal(Checkers).
percorreListaMovs(Checkers, [[Checker,Move]|[]]) :-
        pegaElem(Checker, Checkers, C0),
        move(Move,Checker, C0),
        valid(C0),
        replace(Checkers,C0,Checker,NewCheckers),
        posicaoFinal(NewCheckers).
        
percorreListaMovs(Checkers, [[Checker,Move]|T]) :-
        pegaElem(Checker, Checkers, C0),
        move(Move,C0, C1),
        valid(C1),
        replace(Checkers,C1,Checker,NewCheckers),
        percorreListaMovs(NewCheckers, T).

imprimeLinha1(Checkers) :-
        write('      '),
        (member([1,3],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([1,4],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([1,5],Checkers) -> write('[X]'); write('[ ]')),
        nl.
        
imprimeLinha2(Checkers) :-
        write('   '),
        (member([2,2],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([2,3],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([2,4],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([2,5],Checkers) -> write('[X]'); write('[ ]')),
        nl.
        
imprimeLinha3(Checkers) :-
        (member([3,1],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([3,2],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([3,3],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([3,4],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([3,5],Checkers) -> write('[X]'); write('[ ]')),
        nl.
        
imprimeLinha4(Checkers) :-
        write('   '),
        (member([4,1],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([4,2],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([4,3],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([4,4],Checkers) -> write('[X]'); write('[ ]')),
        nl.
        
imprimeLinha5(Checkers) :-
        write('      '),
        (member([5,1],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([5,2],Checkers) -> write('[X]'); write('[ ]')),
        write('   '),
        (member([5,3],Checkers) -> write('[X]'); write('[ ]')),
        nl.
        
imprimeLinhas(Checkers) :-
        writeln('   '),
        imprimeLinha1(Checkers),
        imprimeLinha2(Checkers),
        imprimeLinha3(Checkers),
        imprimeLinha4(Checkers),
        imprimeLinha5(Checkers),
        writeln('   ').
        
imprimeMovs(Checkers, []) :- imprimeLinhas(Checkers), writeln('FUCK YEAH!!').
imprimeMovs(Checkers, [[Checker,Move]|[]]) :-
        pegaElem(Checker, Checkers, C0),
        move(Move,Checker, C0),
        replace(Checkers,C0,Checker,NewCheckers),
        imprimeLinhas(NewCheckers).

imprimeMovs(Checkers, [[Checker,Move]|T]) :-
        imprimeLinhas(Checkers),
        pegaElem(Checker, Checkers, C0),
        move(Move,C0, C1),
        replace(Checkers,C1,Checker,NewCheckers),
        imprimeMovs(NewCheckers, T).

move(1,[X,Y], [X1,Y1]) :- X1 #=X,   Y1 #=Y-1.
move(2,[X,Y], [X1,Y1]) :- X1 #=X+1, Y1 #=Y-1.
move(3,[X,Y], [X1,Y1]) :- X1 #=X+1, Y1 #=Y.
move(4,[X,Y], [X1,Y1]) :- X1 #=X,   Y1 #=Y+1.
move(5,[X,Y], [X1,Y1]) :- X1 #=X-1, Y1 #=Y+1.
move(6,[X,Y], [X1,Y1]) :- X1 #=X-1, Y1 #=Y.

/*
 1 2
6 # 3
 5 4

[ ][ ][1][ ][ ]
[ ][ ][2][ ][ ]
[ ][ ][3][ ][ ]
[ ][ ][4][ ][ ]
[ ][ ][5][ ][ ]

[ ][ ][ ][ ][1]
[ ][ ][ ][2][ ]
[ ][ ][3][ ][ ]
[ ][ ][4][ ][ ]
[5][ ][ ][ ][ ]

[ ][ ][ ][ ][1]
[ ][ ][ ][2][ ]
[ ][ ][3][ ][ ]
[ ][4][ ][ ][ ]
[5][ ][ ][ ][ ]

[ ][ ][ ][ ][ ]
[ ][ ][ ][ ][ ]
[1][2][3][4][5]
[ ][ ][ ][ ][ ]
[ ][ ][ ][ ][ ]


[ ][ ][1][1][1]
[ ][1][1][1][1]
[1][1][1][1][1]
[1][1][1][1][ ]
[1][1][1][ ][ ]

   . . .
  . . . .
 . . . . .
  . . . .
   . . .
*/

valid([1, Y]) :- Y #>= 3, Y #=< 5.
valid([2, Y]) :- Y #>= 2, Y #=< 5.
valid([3, Y]) :- Y #>= 1, Y #=< 5.
valid([4, Y]) :- Y #>= 1, Y #=< 4.
valid([5, Y]) :- Y #>= 1, Y #=< 3.



hexagon(Checkers,Resultado,Movs) :-
        Resultado #>= 0,
        labeling([ff],[Resultado]),
        geraListaMovs(Resultado,Movs),
        percorreListaMovs(Checkers, Movs),
        !.

