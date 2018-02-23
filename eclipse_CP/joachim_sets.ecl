
:-lib(fd).  
:-lib(fd_sets).
%%:-lib(branch_and_bound).
dados(1,[61,66,63,69]).
dados(4,[12,122,18,1,9,7]).

go :-
	% dados(1, Lista),
	%%% era para dar certo
	%%%flatten_array(Array, Lista),
	% flatten_array( Weights , Lista  ),
	% write( Weights ),
    Weights = [](1,61,66,63,69,71,22),  %%% eh um array
    
    model(Weights, Sets, Diff),
    %%%label_sets(Sets)
    minimize( label_sets(Sets), Diff ),
    writeln(sets=Sets; diff=Diff ; weights=Weights).
    %% tem que fazer uma funcao para recuperar os indices de cada set
    %% mas deve ter pronto veja a biblioteca de SETs

model(Weights, Sets, Diff) :-
        arity(Weights, N), %% acha a quantidade de elementos ... int
        N1 is N//2, %% dividir por 2
        N2 is N-N1,

        Sets = [L1,L2,L3], %% criou os conjuntos via lista
        intsets(Sets, _, 1, N),  % shorthand for :: [].. [1,2,...,N]
        %% estabele que Sets tem os conjuntos como tipos ...   
	%%cria Conjtos
        #(L1, N1),
        #(L2, N2),
        #(L3, N),
        %%% cria_conjuntos([ (L1,N1), (L2,N2), .....]

	%%% CARDINALIDADE ... do conjuntos sao estabelecidas....
        weight(L1, Weights, W1),
        weight(L2, Weights, W2),
        weight(L3, Weights, W3),

	%%% as constraints sao postadas via CARDINALIDADE Wis
        fd_sets:(W3 #= W1+W2),
        writeln( w1: W1),
        writeln( w2: W2),
        %% Diff #= abs(W1-W2), 
		my_abs(W1, W2,Diff), %%% dif de um contra todos...
        fd_sets:union(L1, L2, L3). %%% pensar depois....
        

my_abs(W1,W2, Diff) :-
		W1 #>= W2, (Diff #= W1-W2), !;
		W2 #> W1,  (Diff #= W2-W1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Obrigatorio
label_sets([]).
	label_sets([S|Ss]) :-
	insetdomain(S,_,_,_),
	%%%Instantiate Set to a possible value
	label_sets(Ss).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*        
y guess is that you want to minimize the difference between the
weights of set L1 and L2.  You do that by simply replacing the line

        label_sets(Sets)

by

        minimize(label_sets(Sets), Diff)
 */      
