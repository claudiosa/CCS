
/*
    Example: Thread Pool + Logical Worlds in SWI-Prolog
    ---------------------------------------------------
    This example demonstrates:

    ✔ How to create a thread pool using thread_pool_create/3
    ✔ How to dispatch tasks to the pool using thread_create_in_pool/4 (CORRIGIDO)
    ✔ How to maintain multiple “logical worlds” (isolated sets of facts)
    ✔ How to have different threads process different worlds concurrently

    Each logical world stores its own facts and produces its own result.
*/
:- use_module(library(thread_pool)).
:- dynamic world_fact/2.     % world_fact(WorldName, Fact)
:- dynamic world_result/2.   % world_result(WorldName, ComputedValue)

% Certifique-se de que sum_list está disponível, geralmente está no library(lists)
:- use_module(library(lists)).

/* --------------------------------------------------------
   Initialize two logical worlds with different sets of facts
   -------------------------------------------------------- */

init_worlds :-
    % Clean any previous data
    retractall(world_fact(_, _)),
    retractall(world_result(_, _)),

    % World A facts
    assertz(world_fact(world_a, value(11))),
    assertz(world_fact(world_a, value(22))),

    % World B facts
    assertz(world_fact(world_b, value(3))),
    assertz(world_fact(world_b, value(7))).


/* --------------------------------------------------------
   Worker predicate: processes a logical world
   --------------------------------------------------------
   This predicate simulates "world-level" computation:
   It collects all the facts for the world and sums them.
   The result is stored in world_result/2.
-------------------------------------------------------- */

process_world(World) :-
    % Collect all values belonging to this world
    findall(V, world_fact(World, value(V)), List),

    % Compute sum of world values
    sum_list(List, Sum),

    % Store the result (can be read later by main thread)
    % A 'mutex' seria ideal em um cenário de alta concorrência
    % para garantir a integridade dos `assertz`/`retractall`,
    % mas para este exemplo simples, não é estritamente necessário.
    assertz(world_result(World, Sum)),

    % Print diagnostic output from the worker thread
    format("Thread processed ~w with sum = ~w~n", [World, Sum]).


/* --------------------------------------------------------
   Main entry point: builds thread pool, runs jobs, reads results
   -------------------------------------------------------- */

run_demo :-
    % Initialize the logical worlds
    init_worlds,

    % Create a thread pool named "my_pool" with 3 worker threads
    thread_pool_create(my_pool, 3, []),

    % Dispatch two tasks to the pool - AGORA COM thread_create_in_pool/4
    thread_create_in_pool(my_pool, process_world(world_a), _, []), % <- MUDANÇA AQUI
    thread_create_in_pool(my_pool, process_world(world_b), _, []), % <- MUDANÇA AQUI

    % Give threads a moment to finish (simples sincronização)
    % Em um código de produção, você usaria thread_join/2 ou wait_for_messages/2.
    sleep(1),

    % Retrieve results from both worlds
    world_result(world_a, ResultA),
    world_result(world_b, ResultB),

    % Print final outcomes
    format("Final result of world A = ~w~n", [ResultA]),
    format("Final result of world B = ~w~n", [ResultB]),

    % DESTROI O POOL DE THREADS (ADICIONADO)
    thread_pool_destroy(my_pool),
    print("Pool Destroied").