

%%% .... : [10,11,12,13,14,15,16,17,18,19]
%%% gerador de lista ....
t3 :- gen_l(10, 19, L), 
      nl, 
      writeln(uma_lista_ascendente.... :L).
gen_l(Start, End, L) :- findall(X,between(Start,End,X),L).




i :- 
    Start is 5,
    End is 10,
    s(Start, End, [], L), 
    writeln(saida :L).

%    s(X , X, L, L) :- !.
/*    %L2 is  [X|L],
s(X , X, L , L_output) :-     
    reverse( L , L_output ),
    writeln(output :L_output ), !.
*/
s(X , X, L, L) :- !.
s(X1 , END, L1 , Sol) :- 
    X1 < END,
    X2 is (X1 + 1),
    s(X2 , END, [X2|L1], Sol).