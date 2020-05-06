%% https://github.com/SWI-Prolog/swipl-devel/blob/master/library/rbtrees.pl
/* ************************************* */

all :- time(t_rb),  time(t1), time(t2).

n_acessos(50000).

t_rb :-
 %% Tempo inicial
 %retractall(fato/1),
 format("\n Saida ACESSOS RB - t_RB \n "),
 statistics(cputime,T1 ),
 statistics(runtime,[Start|_]), %%%% SICSTUS
% time(ntimes(1000)),
  n_acessos(X_vezes),
  writeln('===> num_acessos  ' :X_vezes),
  lst_voxel(L), 
  rb_new(RB_Tree_INI),
  %%
  load_L_in_RB(L, RB_Tree_INI, RB_Tree),
  acess_tree(X_vezes, RB_Tree), 
%% Tempo final
 % statistics(cputime ,T2),
  statistics(runtime,[Stop|_]),
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

load_RB :- 
  lst_voxel(L), 
  %L = [1,2],
  rb_new(RB_Tree_INI),
  %%
  %ord_list_to_rbtree(L, RB_Tree),
  load_L_in_RB(L, RB_Tree_INI, RB_Tree),
  writeln('...show_tree' :RB_Tree),
  rb_size(RB_Tree, Size),
  writeln('...size_tree' :Size),
  rb_lookup(5, Value, RB_Tree),
  writeln('...value_tree' :Value),
  writeln('sucess').

/************* LOAD A RB TREE ****************/
load_L_in_RB([], A, New) :- New = A, !.
 
load_L_in_RB([A|L], RB_Tree , RB_New_2   ) :-
  Key = A,
  Value is (A+1000), %%% ANYTHING HERE
  %%%rb_insert_new(+Tree, +Key, ?Value, -NewTree) 
  rb_insert(RB_Tree, Key, Value, RB_New),
  load_L_in_RB(L, RB_New, RB_New_2).


/* 
?- rb_new(X), rb_insert(X, 1,2,Y), write(Y), nl,  rb_insert(Y, 11,12,Z), write(Z
), rb_size(Z, N), nl, write(N).
t(black(,_8196,_8198,),black(black(,_8196,_8198,),1,2,black(,_8196,_8198,)))
t(black(,_8196,_8198,),black(black(,_8196,_8198,),1,2,red(black(,_8196,_8198,),11,12,black(,_8196,_8198,))))
2
X = t(black('', _8196, _8198, ''), black('', _8196, _8198, '')),
Y = t(black('', _8196, _8198, ''), black(black('', _8196, _8198, ''), 1, 2, black('', _8196, _8198, ''))),
Z = t(black('', _8196, _8198, ''), black(black('', _8196, _8198, ''), 1, 2, red(black('', _8196, _8198, ''), 11, 12, black('', _8196, _8198, '')))),
N = 2.

[ccs@gerzat exemplo_transliteracao]$ grep "(\[" lista_fatos.pl 
lst_voxel([cat -n "Arquivo_Desejado" | grep -n ^ | grep ^Linha_do_Arquivo: | cut -d: -f2

cat -n "Arquivo_Desejado" | grep -n ^ | grep ^Linha_do_Arquivo
cat "Arquivo_Desejado" | grep -n ^ | grep ^Linha_do_Arquivo: | cut -d: -f2
cat "Arquivo_Desejado" | grep -n ^ | grep ^Linha_do_Arquivo
*/

acess_tree(N,Tree) :-
    N > 0,
    random(1,1000000,Key),
    %random(1,11,Key),  %%% intervalo exclui 11
    rb_lookup(Key, Value, Tree),
    % write('.'),
    % writeln('==> ' :Value),
    N1 is (N-1),
    acess_tree(N1, Tree).
acess_tree(0,_)  :- !.

/********************************************/
