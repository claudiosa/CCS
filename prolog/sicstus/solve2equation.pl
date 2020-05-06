
/* Tem que indicar i: input ou +
                   o: output ou -
                   ?: nas duas direções
                   
Exemplo:                     
solve2equation( i, i, i, o )
solve2equation( +, +, +, - )
*/
solve2equation(A, B, C, (R1,R2) ):-
  
    Delta is ( B*B - 4*A*C), %%% o is não aceita backtrackble 
    % writeln(delta: Delta),
    ( Delta < 0 ) ->    %   veio do do if
    (
       writeln('Negative Delta in solve2equation'),
       writeln('A  B  C Delta' :A :B :C :Delta),
       get_single_char(_)
       %%%halt(1)
     )
     ;
     (
       Delta is ( B*B - 4*A*C),   %%% tem que ser recalculado aqui ....
       %% o problema é o uso do (COND) -> (THEN) ; (ELSE) 
       %%
       SqrDelta is sqrt( Delta ),
       R1 is (-B + SqrDelta) / (2*A),
       R2 is (-B - SqrDelta) / (2*A)
     )
     .     




/* Adicionaria testes individualizados */
t1 :- solve2equation(1, -7, -12, Roots ),
       writeln(roots: Roots).
/*
?- t1.
delta:97
roots:(8.424428900898052,-1.424428900898052)
true.
*/
t2 :- solve2equation(120, 7, 1, Roots ),
       writeln(roots: Roots).
/*
?- t2.
delta: -431
Negative Delta in solve2equation
A  B  C Delta:120:7:1: -431
[ccs@vosges exemplo_transliteracao]$ 
*/    


/* EM LOGICA este codigo fica */
em_logica_2_equation(A, B, C, _ ) :-
        Delta is ( B*B - 4*A*C), %%% o is não aceita backtrackble 
       % writeln(delta: Delta),
        Delta < 0, 
        writeln('Negative Delta in solve2equation'),
        writeln('A  B  C Delta' :A :B :C :Delta),
        get_single_char(_), %%% UMA PAUSA 
        ! .
        
em_logica_2_equation(A, B, C, (R1,R2) ):-
       Delta is ( B*B - 4*A*C), %%% o is não aceita backtrackble 
             % writeln(delta: Delta),
       Delta >= 0, 
       Delta is ( B*B - 4*A*C),  
       SqrDelta is sqrt( Delta ),
       R1 is (-B + SqrDelta) / (2*A),
       R2 is (-B - SqrDelta) / (2*A)
       .     
   
t3 :-  em_logica_2_equation(1, -7, -12, Roots ),
       writeln(roots: Roots).

t4 :-  em_logica_2_equation(120, 7, 1, Roots ),
       writeln(roots: Roots).



