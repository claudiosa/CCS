
set_value1(1,[_|R],V,[V|R]).
set_value1(I,[H|T],V,[H|NL]) :- 
    Next is I-1,
    set_value1(Next,T,V,NL).

set_value2(1, C, [H|T], V, [NL|T]) :- 
    set_value1(C, H, V, NL).

set_value2(R, C, [H|T], V, [H|NL]) :-
    Next is R-1,
    set_value2(Next, C, T, V, NL).

jump_right([R,C1],[R,C2],[R,C3]) :- C2 is C1+1, C3 is C2+1.
jump_left([R,C1],[R,C2],[R,C3]) :- C2 is C1-1, C3 is C2-1.
jump_top([R1,C],[R2,C],[R3,C]) :- R2 is R1-1, R3 is R2-1.
jump_bottom([R1,C],[R2,C],[R3,C]) :- R2 is R1+1, R3 is R2+1.

jump(From,Eat,To) :- jump_right(From,Eat,To).
jump(From,Eat,To) :- jump_left(From,Eat,To).
jump(From,Eat,To) :- jump_top(From,Eat,To).
jump(From,Eat,To) :- jump_bottom(From,Eat,To).

valid_jump(Board, [From,Eat,To]) :-
    valid_cell(Board, From),
    jump(From,Eat,To),
    valid_cell(Board, Eat),
    valid_cell(Board, To),
    has_marble(Board, From),
    has_marble(Board, Eat),
    is_empty(Board, To).

valid_cell(Board, [X,Y]) :- 
    valid_pos(X), valid_pos(Y), is_empty(Board, [X,Y]).
valid_cell(Board, [X,Y]) :- 
    valid_pos(X), valid_pos(Y), has_marble(Board, [X,Y]).

valid_pos(X) :- dimension(D), between(1,D,X).

has_marble(Board, [Row,Col]) :-
    marble(V),
    value_at(Board, [Row,Col], V).

is_empty(Board, [Row,Col]) :-
    empty(V),
    value_at(Board, [Row,Col], V).

place_marble(Board, [Row,Col], NewBoard) :-
    marble(V),
    set_value2(Row, Col, Board, V, NewBoard).

eat_marble(Board, [Row,Col] ,NewBoard) :-
    empty(V),
    set_value2(Row, Col, Board, V, NewBoard).

value_at(Board, [Row,Col], Value) :-
    nth1(Row, Board, RowValues),
    nth1(Col, RowValues, Value).

make_jump(Board, [From,Eat,To], NewBoard) :-
    eat_marble(Board, From, AfterFrom),
    eat_marble(AfterFrom, Eat, AfterEat),
    place_marble(AfterEat, To, NewBoard).

not_same_cell([X1,_],[X2,_]) :- X1 \= X2,!.
not_same_cell([_,Y1],[_,Y2]) :- Y1 \= Y2,!.    

has_more_than_one_marble(Board) :-
    valid_cell(Board, X), valid_cell(Board, Y),
    not_same_cell(X, Y),
    has_marble(Board,X), has_marble(Board,Y),!.
    
solve(Board, _) :- \+has_more_than_one_marble(Board),!.

solve(Board, Jumps) :-
    valid_jump(Board, Jump),
    make_jump(Board, Jump, NewBoard),
    solve(NewBoard, NewJumps),
    Jumps = [Jump|NewJumps].

marble(o).
empty(.).
dimension(7).
board([[-,-,o,o,o,-,-],
       [-,-,o,o,o,-,-],
       [o,o,o,o,o,o,o],
       [o,o,o,.,o,o,o],
       [o,o,o,o,o,o,o],
       [-,-,o,o,o,-,-],
       [-,-,o,o,o,-,-]]).

?- board(B), solve(B,Js), write(Js), !.
