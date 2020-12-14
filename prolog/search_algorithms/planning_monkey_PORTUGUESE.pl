/* Quanto ao functor state::
    1o. arg: onde est� o macado
    2o. arg: posi��o do macaco em rela��o a caixa
    3o. arg: onde est� a caixa
    4o. arg: segurou ou nao as bananas

swipl -t main -q -f NAME.pl
*/
main :- inicio.

inicio :- busca( state(na_porta, no_chao, na_janela, nao_agarrou) ,
 [ state(na_porta, no_chao, na_janela, nao_agarrou)], []  ).

/* condicao de parada */
busca( state(meio_da_sala, sobre_a_caixa, meio_da_sala, vai_agarrar),  L1 , L2 ):-
			reverse(L1, L1_inv),
			reverse(L2, L2_inv), nl,
			write(' Sequencia de Estados...:'), nl,
			w_lst(L1_inv), nl, nl,
			write(' Sequencia de Acoes...:'), 
			w_lst(L2_inv), nl, 
			write('Sucesso'),
                        print_seq_state(L1_inv,L2_inv)
                        .


/* explora��o dos estados */
busca( S1 ,  L, L_acao ) :-
	move(S1, Acao , S2),
	\+ member( S2, L ),
	busca( S2 ,  [ S2 | L],  [Acao| L_acao] ).


%% CURR_STATE ---> ACTION ---> NEW_STATE
%%% number of the states has 1 more... always.
print_seq_state( _ ,[]) :- format("\n ====================================\n Success \n").

print_seq_state([State|L1],[Action|L2]) :-
     format("\n State: ~w \t Action: ~w", [State, Action]),
     print_seq_state(L1,L2). 




/* os movimentos permitidos */
/* 1. macaco se movimenta sozinho */
move(state(P,no_chao,X,H), anda(P,Q), state(Q,no_chao,X,H)) :- 
	member(P ,[na_porta,   meio_da_sala,  na_janela]),
	member(Q, [na_porta,   meio_da_sala,  na_janela]),
	P \==Q.

/* 2. o macaco empurra a caixa */
move(state(P,no_chao,P,H), empurra_caixa(P,Q), state(Q,no_chao,Q,H)) :- 
	member(P ,[na_porta,   meio_da_sala,  na_janela]),
	member(Q, [na_porta,   meio_da_sala,  na_janela]),
	P \==Q.
/* 3. sobe na caixa */
move(state(P, no_chao,P,H), sobe_na_caixa,  state(P, sobre_a_caixa,P,H)).

/* 4. desce da caixa */
move(state(P, sobre_a_caixa,P,H), desce_da_caixa,  state(P, no_chao,P,H)).

/* 5. vai pegar a comida */
move(state(meio_da_sala, sobre_a_caixa, X , nao_agarrou), 
agarra_a_comida, state(meio_da_sala, sobre_a_caixa, X , vai_agarrar)).

w_lst( [] ).
w_lst( [X|L] ) :- nl, write(' ===> '), write(X),  w_lst(L).
