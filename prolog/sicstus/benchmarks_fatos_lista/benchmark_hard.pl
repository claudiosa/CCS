
/* ************************************* */

%%%all :- time(t1), time(t2).

n_acessos(50000).

t1:-
 %% Tempo inicial
 %retractall(fato/1),
 format("\n Saida ACESSOS via FATOS - t1 \n "),
 statistics(cputime,T1),
 statistics(runtime,[Start|_]), %%%% SICSTUS
% time(ntimes(1000)),
  n_acessos(X),
  writeln('===> num_acessos  ' :X),
  ntimes(X),

%% Tempo final
  statistics(cputime ,T2),
  statistics(runtime,[Stop|_]), %%% SICSTUS
%cputime	(User) CPU time since thread was started in seconds
 statistics(process_cputime, T),
 statistics(stack,Stack),
 statistics(globalused,Global),
 T3 is (T2 - T1)/1000,
 
 format('\n T1: ~f msec \t T2: ~f  msec', [T1, T2]),
 format('\n Cputime: ~10f sec :: (T2-T1) ~10f ms', [T3, (T2-T1)]), 
 format('\n SISCTUS: Start: ~f msec \t Stop: ~f  msec', [Start, Stop]),
 format('\n SISCTUS runtime: ~f  msec', [(Stop - Start)]),
 
 format('\n Process_cputime: ~10f  msec', T),
 format('\n Total memory in use for stacks in all threads: ~d  ', Stack ),
 format('\n Number of bytes in use on the global stack: ~d  ', Global)
 .
 
t2:-
    %% Tempo inicial
    
    format("\n Saida ACESSOS via LISTA - t2 \n "),
    statistics(cputime,T1),
    statistics(runtime,[Start|_]), %%%% SICSTUS
   % time(ntimes(1000)),
    n_acessos(X),
    writeln('===> num_acessos  ' :X),
    lst_voxel(L), 
    acess_list(X,L),
    
   %% Tempo final
    statistics(cputime ,T2),
    statistics(runtime,[Stop|_]), %%% SICSTUS
   %cputime	(User) CPU time since thread was started in seconds
    statistics(process_cputime, T),
    statistics(stack,Stack),
    statistics(globalused,Global),
    T3 is (T2 - T1)/1000,
    format('\n T1: ~f msec\t T2: ~f  msec', [T1, T2]),
    format('\n SISCTUS: Start: ~f msec \t Stop: ~f  msec', [Start, Stop]),
    format('\n Cputime: ~10f sec :: (T2-T1) ~10f ms', [T3, (T2-T1)]), 
    format('\n Process_cputime: ~10f  msec', T),
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

ntimes(N) :- 
    %random(1,999999,X),  
    random(1,1000000,X),  
    %random(1,11,X),  %%% intervalo exclui 11
    N > 0,
    voxel(X),
   % writeln('==> ' :X),                                    
   % write('.'),
    N1 is (N-1),    
    ntimes(N1).
ntimes(0).

/**** eleva ao quadrado e RAIZ ******/


% findall(X,t(X),L). ===> SEM USAR ISTO ...
acess_list(N,L) :-
    N > 0,
    random(1,1000000,X),
    %%%random(1,11,X),  %%% intervalo exclui 11
    % nth1(X,L,V), %%% nth1 ... index start 1.
    my_member(X,L ),
   % write('.'),
   % writeln('==> ' :V),
    N1 is (N-1),
    acess_list(N1,L).
acess_list(0,_)  :- !.


my_member(X,[X|_]) :- !.
my_member(X,[A|L]) :-
  A \== X,
  my_member(X,L).

