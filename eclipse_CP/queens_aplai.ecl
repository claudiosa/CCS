% The n-queens program, adapted by Tias to demonstrate
% running parameterized experiments
%

:- lib(ic).
:- lib(viewable).
:- [queens_data].

queens(Model, Data, VarOrder, Board) :-
    % load data
    queens_data(Data, N),

    % the model
    queens_model(Model, N, Board),

    statistics(times, [T0|_]),
    % the search/6 in a findall, in this case we want all solutions
    findall(Board, (search(Board, 0, VarOrder, indomain, complete, [backtrack(BT)]), setval(backtracks, BT)), Solutions),

    % statistics
    statistics(times, [T1|_]),
    Secs is T1-T0,
    length(Solutions, NrSolutions),
    getval(backtracks, BTs),

    % output
    %print(Board),
    print("Model; VarOrder; Data; N; NrSols; Seconds; Backtracks\n"),
    printf("%a; %a; %a; %d; %d; %w; %d\n", [Model, VarOrder, Data, N, NrSolutions, Secs, BTs]).

queens_model(lists, N, Board) :-
    % initialise decision variables
    length(Board, N),
    Board :: 1..N,
    viewable_create(board, Board),

    % the model
    ( fromto(Board, [Q1|Cols], Cols, []) do
        ( foreach(Q2, Cols), param(Q1), count(Dist,1,_) do
        Q2 #\= Q1,
        Q2 - Q1 #\= Dist,
        Q1 - Q2 #\= Dist
        )
    ).

queens_model(arrays, N, Board2) :-
    % initialise decision variables
    dim(Board, [N]),
    Board[1..N] :: 1..N,
    viewable_create(board, Board),

    % the model
    ( for(I,1,N), param(Board,N) do
        ( for(J,I+1,N), param(Board,I) do
            Board[I] #\= Board[J],
            Board[I] #\= Board[J]+J-I,
            Board[I] #\= Board[J]+I-J
        )
    ),
    Board =.. [_|Board2].
