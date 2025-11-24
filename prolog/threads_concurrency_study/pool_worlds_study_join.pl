/*
    Versão de Produção: Usando thread_join/2 para Sincronização Determinística
*/
:- use_module(library(thread_pool)).
:- use_module(library(lists)).

:- dynamic world_fact/2.
:- dynamic world_result/2.


/* Predicados init_worlds/0 e process_world/1 permanecem inalterados */

init_worlds :-
    retractall(world_fact(_, _)),
    retractall(world_result(_, _)),
    assertz(world_fact(world_a, value(10))),
    assertz(world_fact(world_a, value(20))),
    assertz(world_fact(world_b, value(3))),
    assertz(world_fact(world_b, value(7))),
    assertz(world_fact(world_c, value(1))),
    assertz(world_fact(world_c, value(5))),
    assertz(world_fact(world_c, value(9))).

process_world(World) :-
    findall(V, world_fact(World, value(V)), List),
    sum_list(List, Sum),
    assertz(world_result(World, Sum)),
    format("Thread processed ~w with sum = ~w~n", [World, Sum]).


/* --------------------------------------------------------
   Ponto de Entrada Principal com thread_join
   -------------------------------------------------------- */

run_demo :-
    init_worlds,
    thread_pool_create(pool_NAME, 3, []),

    % 1. DESPACHA e CAPTURA os IDs das Threads
    format("Despachando tarefas e capturando IDs...~n", []),
    thread_create_in_pool(pool_NAME, process_world(world_a), IdA, []),
    thread_create_in_pool(pool_NAME, process_world(world_b), IdB, []),
    thread_create_in_pool(pool_NAME, process_world(world_c), IdC, []),

    % 2. SINCRONIZAÇÃO DETERMINÍSTICA: Espera por cada thread
    format("Esperando as threads concluírem (thread_join)...~n", []),
    thread_join(IdA, StatusA), % Bloqueia até que IdA termine
    thread_join(IdB, StatusB), % Bloqueia até que IdB termine
    thread_join(IdC, StatusC), % Bloqueia até que IdC termine

    % 3. VERIFICAÇÃO de Status (Opcional, mas recomendado)
    (StatusA = true, StatusB = true, StatusC = true ->
        format("Todas as threads concluíram com sucesso!~n", [])
    ;
        format(user_error, "AVISO: Alguma thread não terminou com sucesso (Status: ~w, ~w, ~w)~n", [StatusA, StatusB, StatusC])
    ),

    % 4. RECUPERAÇÃO dos Resultados
    world_result(world_a, ResultA),
    world_result(world_b, ResultB),
    world_result(world_c, ResultC),

    % 5. Impressão e Limpeza
    format("~n--- Resultados Finais ---~n", []),
    format("Final result of world A = ~w~n", [ResultA]),
    format("Final result of world B = ~w~n", [ResultB]),
    format("Final result of world C = ~w~n", [ResultC]),

    thread_pool_destroy(pool_NAME),
    format("pool_NAME destroied"). 