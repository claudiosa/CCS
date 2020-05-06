
/* ************************************* */
% :- consult('rbtrees.pl'). >>>>> SO PARA AS RB
% :- consult('fatos_e_listao.pl').

:- use_module(library(random)).
:- use_module(library(avl)).
%%% nao eh BST classica

all :- t_fatos, t_rb, t_avl .

%n_acessos(10000).
n_acessos(1000000).

t_fatos :-
 write(' Output Fact Acess - t_fatos \n '),
 statistics(runtime,[Start|_]), %%%% SICSTUS
% time(ntimes(1000)),
  n_acessos(X_vezes),
  write('===> Acess_number: '), 
  write(X_vezes),
 
  ntimes(X_vezes), % calll fatos....
  
  % Tempo final
 % statistics(cputime ,T2),
 statistics(runtime,[Stop|_]),
 Truntime is (Stop - Start),
%cputime        (User) CPU time since thread was started in seconds
 write('\n SISCTUS: Start: '), write(Start), write('  ms'),
 write('\n SISCTUS: Stop: '),  write(Stop),  write('  ms'),
 write('\n SISCTUS runtime:'), write(Truntime),  write('  ms'),
 write('\n FATOS ===========================================')                                                 
 .


ntimes(N) :- 
    %random(1,999999,X),  
    random(1,1000000,X),  
    %random(1,11,X),  %%% intervalo exclui 11
    N > 0,
    voxel(X),
   % writeln('==> ' :X),                                    
   %% write('.'),
    N1 is (N-1),    
    ntimes(N1).
ntimes(0).
/*************************************************************/

t_rb :-
 %% Tempo inicial
 %retractall(fato/1),
 write(' Output Red-Black Tree Acess - t_RB \n '),
 statistics(runtime,[Start|_]), %%%% SICSTUS
% time(ntimes(1000)),
  n_acessos(X_vezes),
  write('===> Acess_number: '), 
  write(X_vezes),
  lst_voxel(L), 
  rb_new(RB_Tree_INI),
  %%
  load_L_in_RB(L, RB_Tree_INI, RB_Tree),
  acess_tree(X_vezes, RB_Tree), 
%% Tempo final
 % statistics(cputime ,T2),
 statistics(runtime,[Stop|_]),
 Truntime is (Stop - Start),
%cputime	(User) CPU time since thread was started in seconds
 write('\n SISCTUS: Start: '), write(Start), write('  ms'),
 write('\n SISCTUS: Stop: '),  write(Stop),  write('  ms'),
 write('\n SISCTUS runtime:'), write(Truntime),  write('  ms'),
 write('\n RB ===========================================')                                                 
 .

teste_RB :- 
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


/* *********************** */

acess_tree(N,Tree) :-
    N > 0,
    random(1,1000000,Key),
    %random(1,11,Key),  %%% intervalo exclui 11
    rb_lookup(Key, Value, Tree),
    %%%write('.'),
    % writeln('==> ' :Value),
    N1 is (N-1),
    acess_tree(N1, Tree).
acess_tree(0,_)  :- !.

/********************************************/

/*************************************************************/

t_avl :-
 %% Tempo inicial
 %retractall(fato/1),
 write(' Output AVL Tree Acess  - t_avl \n '),
 statistics(runtime,[Start|_]), %%%% SICSTUS
% time(ntimes(1000)),
  n_acessos(X_vezes),
  write('===> Acess_number  '), 
  write(X_vezes) ,
  lst_voxel(L) , 
  
  %% INIC is a [] 
  load_L_in_AVL(L, empty, RB_Tree),
  acess_tree_AVL(X_vezes, RB_Tree), 
  
%% Tempo final
 % statistics(cputime ,T2),
 statistics(runtime,[Stop|_]),
 Truntime is (Stop - Start),
%cputime        (User) CPU time since thread was started in seconds
 write('\n SISCTUS: Start: '), write(Start), write('  ms'),
 write('\n SISCTUS: Stop: '),  write(Stop),  write('  ms'),
 write('\n SISCTUS runtime:'), write(Truntime),  write('  ms'),
 write('\n RB ===========================================')                                                 
 .

/*
load_AVL([A|L], Tre
ord_list_to_avl(+List, -AVL)

avl_fetch(+Key, +AVL)
avl_member(?Key, +AVL, ?Val)
*/
/*********** LOAD AVL **********/
load_L_in_AVL([], A, New) :- New = A, !.
load_L_in_AVL([A|L], AVL_Tree , AVL_New_2   ) :-
  Key = A,
  Value is (A+1000), %%% ANYTHING HERE
  % avl_store(+Key, +OldAVL, +Val, ?NewAVL)
  avl_store(Key, AVL_Tree , Value, AVL_New),
  
  load_L_in_AVL(L, AVL_New, AVL_New_2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

acess_tree_AVL(N,Tree) :-
    N > 0,
    random(1,1000000,Key),
    %random(1,11,Key),  %%% intervalo exclui 11
    avl_member(Key, Tree, Value),
    %avl_member(?Key, +AVL, ?Val)
    %write('.'),
    % writeln('==> ' :Value),
    N1 is (N-1),
    acess_tree_AVL(N1, Tree).
acess_tree_AVL(0,_)  :- !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
1o. Test:

| ?- all.
 Output Fact Acess - t_fatos 
 ===> Acess_number: 1000
 SISCTUS: Start: 178705  ms
 SISCTUS: Stop: 178706  ms
 SISCTUS runtime:1  ms
 FATOS =========================================== Output Red-Black Tree Acess - t_RB 
 ===> Acess_number: 1000
 SISCTUS: Start: 178706  ms
 SISCTUS: Stop: 223039  ms
 SISCTUS runtime:44333  ms
 RB =========================================== Output AVL Tree Acess  - t_avl 
 ===> Acess_number  1000
 SISCTUS: Start: 223040  ms
 SISCTUS: Stop: 249209  ms
 SISCTUS runtime:26169  ms
 RB ===========================================
yes
| ?- 

2o. Test

| ?-  t_fatos.
 Saida ACESSOS FATOS - t_fatos 
 ===> num_acessos: 1000........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
 SISCTUS: Start: 85252  ms
 SISCTUS: Stop: 85254  ms
 SISCTUS runtime:2  ms
 FATOS ===========================================
yes
| ?- t_avl.
 Saida ACESSOS AVL - t_avl 
 ===> num_acessos  1000........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
 SISCTUS: Start: 85257  ms
 SISCTUS: Stop: 110698  ms
 SISCTUS runtime:25441  ms
 RB ===========================================
yes
| ?- t_rb.
 Saida ACESSOS RB - t_RB 
 ===> num_acessos  1000........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
 SISCTUS: Start: 110714  ms
 SISCTUS: Stop: 178582  ms
 SISCTUS runtime:67868  ms
 RB ===========================================
yes

*/


