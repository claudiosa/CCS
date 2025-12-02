% ---------------------------------------------
% main(+ArquivoFatos, +N, +PredNome)
% Carrega fatos, soma o segundo arg., imprime resultado
% ---------------------------------------------

main(FactsFile, N, PredName) :-
    % carrega arquivo  limpar memória
    consult(FactsFile),
  
    % calcula soma
    sum_mirrors(N, Sum),

    % imprime SOMENTE o resultado numérico
    write(Sum).

% ---------------------------------------------

% Soma os mirrors(1..N), simples e direto
sum_mirrors(N, Sum) :-
    sum_loop(1, N, 0, Sum).

% Caso base
sum_loop(I, N, Acc, Acc) :-
    I > N, !.

% Passo recursivo
sum_loop(I, N, Acc, Sum) :-
    mirror(I, M),          % já chamamos direto
    Acc1 is Acc + M,
    I2 is I + 1,
    sum_loop(I2, N, Acc1, Sum).
% ---------------------------------------------
    