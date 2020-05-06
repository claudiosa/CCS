
%:- dynamic fato/1.
/*

*/

all :- t1, t2, t3, t4.

t1:-
 %% Tempo inicial
 %retractall(fato/1),
 format("\n Saida Soma de FATOS - t1 \n "),
 statistics(cputime,T1),
% time(ntimes(1000)),
  s(10,X), 
  writeln('=>....Soma de fatos:' : X),

%% Tempo final
  statistics(cputime ,T2),
%cputime	(User) CPU time since thread was started in seconds
 statistics(process_cputime, T),
 statistics(stack,Stack),
 statistics(globalused,Global),
 T3 is (T2 - T1)/1000,
 format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
 format('\n Cputime: ~10f sec :: ~10f ms', [T3, (T2-T1)]), 
 format('\n Process_cputime: ~10f  sec', T),
 format('\n Total memory in use for stacks in all threads: ~d  ', Stack ),
 format('\n Number of bytes in use on the global stack: ~d  ', Global)
 .
 
t2:-
    %% Tempo inicial
    
    format("\n Saida Soma na LISTA - t2 \n "),
    statistics(cputime,T1),
   % time(ntimes(1000)),
    lst_voxel(L), 
    sum_list(L,X),
    writeln('=>....Soma na lista:' : X),
   
   %% Tempo final
    statistics(cputime ,T2),
   %cputime	(User) CPU time since thread was started in seconds
    statistics(process_cputime, T),
    statistics(stack,Stack),
    statistics(globalused,Global),
    T3 is (T2 - T1)/1000,
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Cputime: ~10f sec :: ~10f ms', [T3, (T2-T1)]), 
    format('\n Process_cputime: ~10f  sec', T),
    format('\n Total memory in use for stacks in all threads: ~d  ', Stack ),
    format('\n Number of bytes in use on the global stack: ~d  ', Global)
    .
    
t3:-
    %% Tempo inicial
    format("\n Saida Soma FATOS DIFF \n "),
    statistics(cputime,T1),
    s_dif(10,X), 
    writeln('=>....Soma de fatos:' : X),
   
   %% Tempo final
     statistics(cputime ,T2),
   %cputime	(User) CPU time since thread was started in seconds
    statistics(process_cputime, T),
    statistics(stack,Stack),
    statistics(globalused,Global),
    T3 is (T2 - T1)/1000,
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Cputime: ~10f sec :: ~10f ms', [T3, (T2-T1)]), 
    format('\n Process_cputime: ~10f  sec', T),
    format('\n Total memory in use for stacks in all threads: ~d  ', Stack ),
    format('\n Number of bytes in use on the global stack: ~d  ', Global)
    .
    
 
t4:-
    %% Tempo inicial
    %retractall(fato/1),
    format("\n Saida Soma LISTA - DIFF - t4 \n "),
    statistics(cputime,T1),
   % time(ntimes(1000)),
    lst_voxel(L), 
    sum_list(L,X),
    writeln('=>....Soma na lista:' : X),
   
   %% Tempo final
    statistics(cputime ,T2),
   %cputime	(User) CPU time since thread was started in seconds
    statistics(process_cputime, T),
    statistics(stack,Stack),
    statistics(globalused,Global),
    T3 is (T2 - T1)/1000,
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Cputime: ~10f sec :: ~10f ms', [T3, (T2-T1)]), 
    format('\n Process_cputime: ~10f  sec', T),
    format('\n Total memory in use for stacks in all threads: ~d  ', Stack ),
    format('\n Number of bytes in use on the global stack: ~d  ', Global)
    .
 



/* 
[ccs@gerzat exemplo_transliteracao]$ grep "(\[" lista_fatos.pl 
lst_voxel([cat -n "Arquivo_Desejado" | grep -n ^ | grep ^Linha_do_Arquivo: | cut -d: -f2

cat -n "Arquivo_Desejado" | grep -n ^ | grep ^Linha_do_Arquivo
cat "Arquivo_Desejado" | grep -n ^ | grep ^Linha_do_Arquivo: | cut -d: -f2
cat "Arquivo_Desejado" | grep -n ^ | grep ^Linha_do_Arquivo


*/

ntimes(N) :- N=:=0, !.
ntimes(N) :- N1 is (N-1),
             %%% adiciona fato   
             assertz(fato(N)),                                    

             ntimes(N1).

/* soma sequencial dos fatos */
n_fatos(999999).

s(N,S) :-
    N > 0,
    voxel(N),
    N1 is (N-1),
    s(N1,S1),
    S is (S1 + N).
s(0,0).

/**** eleva ao quadrado e RAIZ ******/
s_dif(N,S):-
    N > 0,
    voxel(N),
    /* operacao matematica */
    pow(N,2,Quad),
    X is sqrt(Quad),
    N1 is (N-1),
    s_dif(N1,S1),
    S is (S1 + X).

s_dif(0,0).


% findall(X,t(X),L). ===> SEM USAR ISTO ...
my_s_list([],0) :- !.
my_s_list([H|L],S) :-
       
       pow(H,2,Quad),
       X is sqrt(Quad),
       
       S is (X+S1),
       my_s_list(L, S1).


square(X,Y) :- Y is X * X.

last([X],X).
last([ _ |L],X2) :- last(L,X2).
