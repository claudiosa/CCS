:-lib(ic).   

t_sc :- final_slide_contraint([1,1], 2, X),
         writeln(" One per time " : X),
         fail. %%% to print all once time
/*         
  
 One per time  : [1, 1, 0, 0]
 One per time  : [0, 1, 1, 0]
 One per time  : [0, 0, 1, 1]
%%%% 
*/
final_slide_contraint(L1, N_zeros, X) :- 
		sliding_const(L1, N_zeros, L_all),
        member(X,L_all).

go:- 
    %% usage: sequence of [1,1] combined with  4 ZEROs
	sliding_const([1,1], 2, L_all),
	writeln(" ALL SLIDINGS CONSTRAINTs " : L_all),
	print_list_by_array(L_all),
	sliding_const([1,1,1,1], 3, L_2all),
	writeln(" ALL SLIDINGS  CONSTRAINTs " : L_2all),
	print_list_by_array(L_2all).
  /* ...........  imprimindo via array  ........... */

print_list_by_array(L_all):-  
   list2array(L_all,Array),
   	dim(Array,[L]), 
	(for( I , 1 , L ),
	 param( Array  )
	 do
	   %% retorna a I esima linha do array
	   arg( I ,  Array ,  Array_I_Linha ),
	   writeln("Linha do array " : I : Array_I_Linha )
    ).
    
/* *************************************************** */   
            %% Segue uma lista de UNS ... e quantidade de ZEROS 
sliding_const( L_UNS, N_ZEROS, L_all):-
 	monta_listas( L_UNS , N_ZEROS, L_all, N_ZEROS).

%% ideia do algoritmo ... MONTAR LISTAS  com N_ZEROS ao fim da lista
%% de uns ... ateh uma ultima lista com N_ZEROS na frente desta lista.

/*	
monta_listas(L1 ,0, [L4], Fixo) :- 
	ins_n_z_i(L1, Fixo, L2),  %%%INSERE 000 no inicio DA LISTA
	ins_n_z_f(L1, 0, L3),  %%%% INSERE NENHUM 0 NO FINAL DA LISTA
	aPPEND(L2,L3,L4).
	
	ALGO EQUIVALENTE A PARADA ABAIXO ....
*/
monta_listas(_ , -1 , [], _) :- !.

monta_listas(L1, N_Zeros, [L4|L5] , Fixo):-
	NO_INI is Fixo - N_Zeros,  /* CONTADORES FIXO >= N_Zeros*/
	NO_FIM is N_Zeros,        /* CONTADORES*/    
	ins_n_z_i(L1, NO_INI, L2),  %%%INSERE 000 no inicio DA LISTA
	ins_n_z_f(L1, NO_FIM, L3),  %%%% INSERE 000NO FINAL DA LISTA
	aPPEND(L2,L3,L4),
	N_Zeros_New is (N_Zeros - 1),
%%%	writeln(" L4 " : L4),
	monta_listas(L1, N_Zeros_New , L5 , Fixo ).
	
%%% insere N 0s na frente de uma lista de 1's	
ins_n_z_i(X, 0 , X):- !.
ins_n_z_i(_, X ,_):- X < 0, writeln(" BUG ..." : X).
ins_n_z_i(L1, N, [0 | L2 ]):-
	N2 is (N-1),
	ins_n_z_i(L1 , N2, L2 ).

/*
Faz isto:
?- ins_n_z_i([1, 1], 4, L2).
L2 = [0, 0, 0, 0, 1, 1]
*/
	
ins_n_z_f(L1,N,L2):-        %%%%% USA O ANTERIOR E INVERTE
	ins_n_z_i(L1,N,L3), 
	reverse(L3,L2).

/*
Faz isto:
?- ins_n_z_f([1, 1], 4, L2).
L2 = [1, 1, 0, 0, 0, 0]
*/

%%% um append um pouco diferente 
aPPEND([] , L2, L2 ).
aPPEND([A|_] , [B|L2], [B | L2 ]) :- A == B, !.
aPPEND([A|L1] , [B|L2], [A | L3 ]) :-
       A \== B,
       aPPEND(L1 , [B|L2], L3 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AUXs
list2array(L,A) :-
                length(L, Size),
                dim(A,[Size]),
                (foreacharg(X,A),
		        foreach(X,L) do true). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AUXs
