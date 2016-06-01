%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File database
% Usage : file/2.
% file(?name, ?type).

file('mgcp', 'bin').
file('tsserver', 'bin').
file('mgcp_th.c', 'src').
file('mgcp_app.c', 'src').
file('ts_server.c', 'src').
file('ts_daemon.c', 'src').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Print of file database
% Usage : print_db/0.

print_db:-
    file(Name, Type),
    format(' File Name : ~w, File Type : ~w.', [Name, Type]), nl,
    fail.
