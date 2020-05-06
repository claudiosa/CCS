
%%% CLASSICOS DE RECURSAO 

%%% TESTE com e sem :-!. (CORTE -- PODA)
loop_DOWN( 0 ) . %%%% ATERRAMENTO um ou mais -- Mas sempre deve existir
%%%% :- !.
loop_DOWN(N) :- 
         N>0,
         writeln(numero : N ),
         M is N-1, 
         loop_DOWN(M).

%%% um aterramento para excecoes e erros ...
loop_DOWN(N) :-
    N < 0,
    writeln(" Digitaste um valor negativo ....").
%%% isto é como um OTHERWISE das outras linguagens
%%% uma resposta ... apenas. 
uma_vez(Goal) :- %%% once(X)
        call(Goal), !.

%%%
a(1). 
a(2). 
a(3).

l :- a(X),
     writeln(xxxxX :X),
     %is(X , 4).
     fail. %%% false 

l :- true. %%%% ATERRAMENTO --- SEMPRE DEVE EXISTIR
%%%% ATERRAMENTO um ou mais -- Mas sempre deve existir


loop_UP(N) :- loop_UP_AUX(N,0).


%%% UM EXCEPTION novamente -- mas agora antes da chamada RECURSIVA
loop_UP_AUX(N ,_ ) :-
    N < 0,
    writeln(" Digitaste um valor negativo ...."),
    !.

%%% TESTE com e sem :-!. (CORTE -- PODA)
loop_UP_AUX(N,N):- !. %%%% ATERRAMENTO um ou mais -- Mas sempre deve existir
%% este aterramento por CASAMENTO de PADROES ... N e N
%% equivalente: loop_UP_AUX(N1,N2):- N1=N2 , !.
loop_UP_AUX(N,M) :- 
             M>=0,
             writeln(numero :M ),
             M1 is M+1, 
             loop_UP_AUX(N,M1).

/************************* LISTAS *********************/
%%%%% IMPRIME LISTAS 
print_all([]).  /* condicao de parada ... 
            antes da recursividade ===> EM GERAL ... 
            mas nem sempre ... vejam outros casos acima
 */
print_all([X|Rest]) :- 
    write(X), nl, 
    print_all(Rest).

print_all_2(List) :- 
    member(X, List), 
    write(X), nl, 
    fail. %%% ou false 

print_all_2(_).   
%%%% ATERRAMENTO apos a regra recursiva -- Mas sempre deve existir


y1 :- print_all(["test", "acid", 'punk']).
y2 :- print_all_2(["test", "acid", 'punk']).

/*
Revendo ...
?- between(1,4,X).
X = 1 ;
X = 2 ;
X = 3 ;
X = 4.

?- 

foreach(:Generator, :Goal)
?- foreach(between(1,4,X), (nl,write(X))).

1
2
3
4
true.

?- foreach(between(-1,-3,X), (nl,write(X))).
true.

?- foreach(between(-1,3,X), (nl,write(X))).

-1
0
1
2
3
true.
?- foreach(between(1,4,X), dif(X,Y)), Y = 5.
Y = 5.
?- foreach(between(1,4,X), dif(X,Y)), Y = 3.
false.

?- foreach(member(S, ["test", "acid"]), writeln(S) ).
test
acid
true.

- foreach(between(3,8,Y), (write(Y),nl)).
3
4
5
6
7
8
true.

*/


/*
for(var i = startingX; i <= endingX; ++i){
		x = i * xwidth;
		point = vectorSpace.getPointInEquationFromX(x, lineEquation);
*/


startingX(10).
endingX(20).
y3 :-
    startingX(Start),
    endingX(End),
    %foreach( (between(Start,End,X), X> 15),
    foreach( between(Start,End,X),
             (
              soma(X),
              % K is (X+X), CUIDAR ... nao funciona
              writeln(xxxxALL :X  :Start :End)
            )
            ),
    format("\n Fim do FOR" ),
    !.    
%%% deve terminar OK na parte acima                 
y3 :- format("\n NAO ALCANCOU O FIM DO FOR" ).

soma(X) :- Z is (X+X), writeln(zzz : Z).
%format("\n A soma de ~w  é: ~w", [X,Z])
%format("\n A soma de ~w  é: ~w", [X,X+X])
 
/*  ********************************* */