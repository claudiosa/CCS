% ring_demo.pl
% Toy demo: ring topology of 4 Prolog nodes (A-B-C-D-A) exchanging deltas.
% Each node:
%  - has a message queue
%  - owns some worlds (it is the authoritative applier for those worlds)
%  - has its own rule set (node-specific)
%  - applies deltas locally (if owner), evaluates its rules for that world,
%    and forwards the delta to its neighbors (anti-echo via seen_delta)
%
% Run:
%   swipl ring_demo.pl
%   ?- start_ring_demo.
%
% Reference brief (for context): /mnt/data/Brief for Claudio.pdf

:- dynamic node_info/4.       % node_info(Name, Queue, Peers, ThreadId)
:- dynamic world_owner/2.     % world_owner(World, OwnerNode)
:- dynamic world_fact/3.      % world_fact(World, FactId, Value)
:- dynamic node_rule/4.       % node_rule(Node, World, RuleId, RuleTerm)
:- dynamic seen_delta/1.      % seen_delta(DeltaId)
:- dynamic session_world/2.   % session_world(SessionId, World)
:- dynamic id_counter/1.

:- discontiguous group_facts_by_key/2. %% ccs


id_counter(0).
new_id(Id) :-
    retract(id_counter(N)), N1 is N + 1, assert(id_counter(N1)), Id = N1.

% ------------------------------------------------------------------
%  Node spawn and main loop
% ------------------------------------------------------------------

% spawn_node(Name, Peers, ThreadId)
spawn_node(Name, Peers, ThreadId) :-
    message_queue_create(Queue),
    thread_create(node_loop(Name, Queue), ThreadId, []),
    assertz(node_info(Name, Queue, Peers, ThreadId)),
    format("[system] spawned node ~w with peers ~w and thread ~w~n", [Name, Peers, ThreadId]).

% node_loop(Name, Queue)
node_loop(Name, Queue) :-
    format("[~w] started~n", [Name]),
    node_loop_run(Name, Queue),
    format("[~w] exiting~n", [Name]).

node_loop_run(Name, Queue) :-
    thread_get_message(Queue, Msg),
    ( Msg = stop ->
        % graceful stop
        format("[~w] received STOP~n", [Name]),
        true
    ; Msg = delta(DeltaId, From, World, FactId, Value) ->
        ( seen_delta(DeltaId) ->
            % already processed -> ignore
            format("[~w] ignored seen delta ~w (from ~w)~n", [Name, DeltaId, From])
        ;
            % mark as seen
            assertz(seen_delta(DeltaId)),
            % check owner
            ( world_owner(World, Name) ->
                % this node is the owner -> apply
                apply_delta(Name, From, World, FactId, Value)
            ;
                format("[~w] received delta ~w for world ~w (owner != me) - will forward~n",
                       [Name, DeltaId, World])
            ),
            % forward to peers (even if not owner) - anti-echo prevents loops
            forward_to_peers(Name, Msg)
        ),
        node_loop_run(Name, Queue)
    ; Msg = add_rule(World, RuleId, RuleTerm) ->
        % add rule that this node will evaluate for given world
        assertz(node_rule(Name, World, RuleId, RuleTerm)),
        format("[~w] added rule ~w for world ~w: ~w~n", [Name, RuleId, World, RuleTerm]),
        node_loop_run(Name, Queue)
    ; Msg = snapshot(World) ->
        make_snapshot(Name, World),
        node_loop_run(Name, Queue)
    ; Msg = info ->
        show_node(Name),
        node_loop_run(Name, Queue)
    ; format("[~w] unknown message: ~w~n", [Name, Msg]),
      node_loop_run(Name, Queue)
    ).

% ------------------------------------------------------------------
%  Delta application and forwarding
% ------------------------------------------------------------------

% apply_delta(Name, From, World, FactId, Value)
apply_delta(Name, From, World, FactId, Value) :-
    % idempotent apply: remove old fact with same FactId if present
    ( retract(world_fact(World, FactId, _Old)) -> true ; true ),
    assertz(world_fact(World, FactId, Value)),
    format("[~w] applied delta from ~w -> (~w : ~w = ~w)~n", [Name, From, World, FactId, Value]),
    % evaluate this node's rules for the world
    evaluate_node_rules(Name, World).

% forward_to_peers(Name, Msg)
forward_to_peers(Name, Msg) :-
    node_info(Name, Queue, Peers, _Tid),
    forall(member(P, Peers),
           ( node_info(P, QP, _Peers2, _), thread_send_message(QP, Msg),
             format("[~w] forwarded message to ~w~n", [Name, P]) )).

% ------------------------------------------------------------------
%  Simple rule evaluation framework per node
%  Node rules are attached to nodes (node_rule/4)
%  Different toy rule types implemented:
%    - sum_greater_than(Threshold)
%    - evens_greater_than(Threshold)
%    - odds_greater_than(Threshold)
%    - average_greater_than(Threshold)
%    - count_ge(K)
%    - value_gt_filter(F)  -> alert if any value > F
% ------------------------------------------------------------------

evaluate_node_rules(Node, World) :-
    findall((RuleId, RuleTerm),
            node_rule(Node, World, RuleId, RuleTerm),
            Rules),
    forall(member((Rid, Rterm), Rules),
           ( evaluate_rule(Node, World, Rid, Rterm) )).

evaluate_rule(Node, World, Rid, sum_greater_than(T)) :-
    findall(V, world_fact(World, _F, V), Vs),
    sum_list(Vs, Sum),
    ( Sum > T ->
        format("[~w] RULE ALERT for ~w: rule ~w sum=~w > ~w~n", [Node, World, Rid, Sum, T])
    ; format("[~w] rule ~w OK for ~w (sum=~w <= ~w)~n", [Node, Rid, World, Sum, T])
    ).

evaluate_rule(Node, World, Rid, evens_greater_than(T)) :-
    findall(V, (world_fact(World, _, V), 0 is V mod 2), Vs),
    sum_list(Vs, SumE),
    ( SumE > T ->
        format("[~w] RULE ALERT (evens) ~w on ~w: sum_even=~w > ~w~n", [Node, Rid, World, SumE, T])
    ; format("[~w] rule ~w OK (evens) for ~w (sum_even=~w <= ~w)~n", [Node, Rid, World, SumE, T])
    ).

evaluate_rule(Node, World, Rid, odds_greater_than(T)) :-
    findall(V, (world_fact(World, _, V), 1 is V mod 2), Vs),
    sum_list(Vs, SumO),
    ( SumO > T ->
        format("[~w] RULE ALERT (odds) ~w on ~w: sum_odd=~w > ~w~n", [Node, Rid, World, SumO, T])
    ; format("[~w] rule ~w OK (odds) for ~w (sum_odd=~w <= ~w)~n", [Node, Rid, World, SumO, T])
    ).

evaluate_rule(Node, World, Rid, average_greater_than(T)) :-
    findall(V, world_fact(World, _, V), Vs),
    ( Vs = [] ->
        Avg = 0
    ; sum_list(Vs, S), length(Vs, L), Avg is S / L
    ),
    ( Avg > T ->
        format("[~w] RULE ALERT (avg) ~w on ~w: avg=~2f > ~2f~n", [Node, Rid, World, Avg, T])
    ; format("[~w] rule ~w OK (avg) for ~w (avg=~2f <= ~2f)~n", [Node, Rid, World, Avg, T])
    ).

evaluate_rule(Node, World, Rid, count_ge(K)) :-
    findall(V, world_fact(World, _, V), Vs),
    length(Vs, L),
    ( L >= K ->
        format("[~w] RULE ALERT (count) ~w on ~w: count=~w >= ~w~n", [Node, Rid, World, L, K])
    ; format("[~w] rule ~w OK (count) for ~w (count=~w < ~w)~n", [Node, Rid, World, L, K])
    ).

evaluate_rule(Node, World, Rid, value_gt_filter(F)) :-
    findall(V, world_fact(World, _, V), Vs),
    ( member(X, Vs), X > F ->
        format("[~w] RULE ALERT (value_filter) ~w on ~w: found value ~w > ~w~n", [Node, Rid, World, X, F])
    ; format("[~w] rule ~w OK (value_filter) for ~w~n", [Node, Rid, World])
    ).

% default: unknown rule type
evaluate_rule(Node, World, Rid, Unknown) :-
    format("[~w] Unknown rule ~w for ~w: ~w~n", [Node, Rid, World, Unknown]).

% ------------------------------------------------------------------
%  Snapshots & info
% ------------------------------------------------------------------

make_snapshot(Node, World) :-
    findall((Fid, V), world_fact(World, Fid, V), Facts),
    format("[~w] SNAPSHOT ~w: ~w~n", [Node, World, Facts]).

show_node(Node) :-
    node_info(Node, Q, Peers, Tid),
    format("[~w] info: queue=~w peers=~w thread=~w~n", [Node, Q, Peers, Tid]).

% ------------------------------------------------------------------
%  API: publish deltas, push rules, sessions
% ------------------------------------------------------------------

% publish_delta(FromNode, World, Value) -> creates a delta id and sends to owner
publish_delta(From, World, Value) :-
    new_id(DeltaId),
    new_id(FactId),
    ( world_owner(World, Owner) ->
        node_info(Owner, Q, _, _),
        thread_send_message(Q, delta(DeltaId, From, World, FactId, Value)),
        format("[client] published delta ~w from ~w to owner ~w (world ~w : ~w = ~w)~n",
               [DeltaId, From, Owner, World, FactId, Value])
    ; format("[client] unknown world ~w - cannot publish~n", [World]) ).

% push_rule(Node, World, RuleTerm)
push_rule(Node, World, RuleTerm) :-
    node_info(Node, Q, _, _),
    new_id(RuleId),
    thread_send_message(Q, add_rule(World, RuleId, RuleTerm)).

create_session(Session, World) :-
    assertz(session_world(Session, World)),
    format("[system] session ~w -> world ~w~n", [Session, World]).

% request a snapshot from a node (for demo)
request_snapshot(Node, World) :-
    node_info(Node, Q, _, _),
    thread_send_message(Q, snapshot(World)).

% request info from node
request_info(Node) :-
    node_info(Node, Q, _, _),
    thread_send_message(Q, info).

% ------------------------------------------------------------------
%  Demo orchestration: build ring topology, worlds, rules, publish deltas
% ------------------------------------------------------------------

start_ring_demo :-
    writeln("=== Cleaning a previous running ==="),
    %clear_demo_state,       % <-- ADICIONE ESTA LINHA!
    force_clean_environment,
    writeln("=== Starting ring demo ==="),
   
    % ring topology: A <-> B <-> C <-> D <-> A
    spawn_node(node_a, [node_b, node_d], TidA),
    spawn_node(node_b, [node_c, node_a], TidB),
    spawn_node(node_c, [node_d, node_b], TidC),
    spawn_node(node_d, [node_a, node_c], TidD),

    % register world owners (Option B)
    assertz(world_owner(w_alpha, node_a)),
    assertz(world_owner(w_beta,  node_b)),
    assertz(world_owner(w_gamma, node_c)),
    assertz(world_owner(w_delta, node_d)),

    % create sessions for demo
    create_session(s1, w_alpha),
    create_session(s2, w_beta),
    create_session(s3, w_gamma),
    create_session(s4, w_delta),

    % push rules per node (modular toy rules)
    % Node A: sum > threshold
    push_rule(node_a, w_alpha, sum_greater_than(25)),

    % Node B: evens and odds separate thresholds
    push_rule(node_b, w_beta, evens_greater_than(10)),
    push_rule(node_b, w_beta, odds_greater_than(5)),

    % Node C: average > X
    push_rule(node_c, w_gamma, average_greater_than(7)),

    % Node D: count >= K and value filter > T
    push_rule(node_d, w_delta, count_ge(3)),
    push_rule(node_d, w_delta, value_gt_filter(15)),

    % publish some deltas to owners (the clients publish to owner nodes)
    publish_delta(client1, w_alpha, 10),
    publish_delta(client1, w_alpha, 20),  % sum 30 -> triggers A rule
    publish_delta(client2, w_beta, 2),
    publish_delta(client2, w_beta, 8),    % evens sum likely triggers B
    publish_delta(client3, w_gamma, 5),
    publish_delta(client3, w_gamma, 10),  % average (5+10)/2 = 7 -> boundary
    publish_delta(client4, w_delta, 4),
    publish_delta(client4, w_delta, 20),
    publish_delta(client4, w_delta, 1),   % count 3 -> triggers D, value>15 triggers

    % give nodes time to process messages
    %sleep(1),
    visual_sleep_ms('@', 999),

    % request snapshots and infos
    request_snapshot(node_a, w_alpha),
    request_snapshot(node_b, w_beta),
    request_snapshot(node_c, w_gamma),
    request_snapshot(node_d, w_delta),

    request_info(node_a),
    request_info(node_b),
    request_info(node_c),
    request_info(node_d),

    %sleep(1),
    visual_sleep_ms('#',999),

    % Clean shutdown: send stop to each node and join threads
    stop_ring_and_join([node_a, node_b, node_c, node_d]),
    writeln("=== Ring demo finished ===").

% stop_ring_and_join(NodeList)
stop_ring_and_join(Nodes) :-
    % send stop messages
    forall(member(N, Nodes),
           ( node_info(N, Q, _, _), thread_send_message(Q, stop) )),
    % join threads
    forall(member(N, Nodes),
           ( node_info(N, _Q, _Peers, Tid),
             format("[system] joining ~w (thread ~w)~n", [N, Tid]),
             thread_join(Tid, _Status) )),
    writeln("[system] all nodes joined").

% ------------------------------------------------------------------
%  Utility debugging helpers
% ------------------------------------------------------------------

clear_demo_state :-
    retractall(node_info(_,_,_,_)),
    retractall(world_owner(_,_)),
    retractall(world_fact(_,_,_)),
    retractall(node_rule(_,_,_,_)),
    retractall(seen_delta(_)),
    retractall(session_world(_,_)),
    retractall(id_counter(_)),
    assert(id_counter(0)).

force_clean_environment :-
    % 1. Tentar parar threads velhos (prudentemente)
    forall(node_info(Name, Q, _Peers, Tid),
           (
               catch(thread_send_message(Q, stop), _, true),
               catch(thread_join(Tid, _), _, true),
               catch(message_queue_destroy(Q), _, true)
           )),

    % 2. Remover todos os fatos definidos dinamicamente
    retractall(node_info(_,_,_,_)),
    retractall(world_owner(_,_)),
    retractall(world_fact(_,_,_)),
    retractall(node_rule(_,_,_,_)),
    retractall(seen_delta(_)),
    retractall(session_world(_,_)),
    retractall(id_counter(_)),
    assertz(id_counter(0)),

    writeln("[system] environment cleaned!").
  
% end of file

visual_sleep_ms(Char, Ms) :-
    Steps is Ms // 100,
    forall( between(1, Steps, _),
           ( format(Char, [] ),
             sleep(0.1) )),
    nl.
