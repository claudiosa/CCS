%:- use_module(library(thread_pool)).
%:- use_module(library(thread_queue)).
% ============================================
% 03_prolog_mirror.pl — versão corrigida
% ============================================

:- dynamic mirror/2.

% Carrega o arquivo de fatos
load_facts(File) :-
    retractall(mirror(_,_)),
    consult(File).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Soma sequencial de uma faixa I..F
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum_range(I, F, Sum) :-
    sum_range_loop(I, F, 0, Sum).

sum_range_loop(I, F, Acc, Acc) :- I > F, !.
sum_range_loop(I, F, Acc, Sum) :-
    mirror(I, V),
    Acc2 is Acc + V,
    I2 is I + 1,
    sum_range_loop(I2, F, Acc2, Sum).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Thread worker
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
worker(Start, End, Queue) :-
    sum_range(Start, End, Sum),
    thread_send_message(Queue, partial_sum(Sum)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Divide trabalho em blocos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
make_blocks(N, NumThreads, Blocks) :-
    BlockSize is N // NumThreads,
    make_blocks_loop(1, N, BlockSize, NumThreads, [], Blocks).

make_blocks_loop(_, _, _, 0, Blocks, Blocks) :- !.
make_blocks_loop(Start, N, BlockSize, ThreadsLeft, Acc, Blocks) :-
    End is min(N, Start + BlockSize - 1),
    ThreadsLeft2 is ThreadsLeft - 1,
    Start2 is End + 1,
    make_blocks_loop(Start2, N, BlockSize, ThreadsLeft2,
                     [block(Start,End)|Acc], Blocks).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN ENTRY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%main(File, N, PredName, NumThreads) :-
main(File, N, _ , NumThreads) :-
    format("[Prolog] Carregando fatos de ~w ...~n", [File]),
    load_facts(File),

    message_queue_create(Q),
    make_blocks(N, NumThreads, Blocks),
    format("[Prolog] Criados ~w blocos de trabalho.~n", [NumThreads]),

    % Criar as threads
    findall(Id,
            (member(block(S,E), Blocks),
             thread_create(worker(S, E, Q), Id, [])),
            ThreadIDs),

    % Recolher resultados
    collect_results(NumThreads, Q, 0, Total),

    message_queue_destroy(Q),

    % Finalizar as threads
    forall(member(T, ThreadIDs), thread_join(T, _)),
    
    %% send the result to Python
    writeln(Total).
    %format("[TOTAL] ~w~n", [Total]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Recebe N mensagens com partial_sum(X)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
collect_results(0, _, Acc, Acc) :- !.
collect_results(N, Q, Acc, Total) :-
    thread_get_message(Q, partial_sum(S)),
    Acc2 is Acc + S,
    N2 is N - 1,
    collect_results(N2, Q, Acc2, Total).
