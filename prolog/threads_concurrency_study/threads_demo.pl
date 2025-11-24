% Exemplo simples de uso de threads no SWI-Prolog
% Exemplo simples de uso de threads com delay diferente
% para números pares e ímpares.

run_demo :-
    writeln('Iniciando threads...'),

    thread_create(trabalho(1), Id1, []),
    thread_create(trabalho(2), Id2, []),
    thread_create(trabalho(3), Id3, []),

    thread_join(Id1, Status1),
    thread_join(Id2, Status2),
    thread_join(Id3, Status3),

    format("Thread ~w terminou com status: ~w~n", [Id1, Status1]),
    format("Thread ~w terminou com status: ~w~n", [Id2, Status2]),
    format("Thread ~w terminou com status: ~w~n", [Id3, Status3]),

    writeln('Fim do demo.').

% Trabalho com diferentes sleeps para par/ímpar
trabalho(N) :-
    format("Thread ~w iniciada...~n", [N]),

    % IF simples: se par → demora maior, se ímpar → menor
    (   0 is N mod 2
    ->  Delay is N * 4,       % par: delay maior
        format("Thread ~w (par) dormindo ~w segundos...~n", [N, Delay])
    ;   Delay is N * 3,           % ímpar: delay menor
        format("Thread ~w (ímpar) dormindo ~w segundos...~n", [N, Delay])
    ),

    sleep(Delay),

    format("Thread ~w finalizada!~n", [N]).

