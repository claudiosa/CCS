:-lib(fd).
:-lib(fd_sets).

go :-
        Weights = [](11, 61,66,63,69,4,90,11),
        model(Weights, Sets, Diff),
		minimize( label_sets(Sets), Diff ),  %%% 
		%% aqui o minimize precisa de %%% :-lib(fd).
     	%%%label_sets(Sets),
        writeln(sets=Sets ; diff=Diff).

model(Weights, Sets, Diff) :-
        arity(Weights, N),
        N1 is N//2,
        N2 is N-N1,

        Sets = [L1,L2,L3],
        intsets(Sets, _, 1, N),   % shorthand for :: []..[1,2,...,N]

    	#(L1, N1),
        #(L2, N2),
        #(L3, N),

        weight(L1, Weights, W1),
        weight(L2, Weights, W2),
        weight(L3, Weights, W3),

        fd_sets:(W3 #= W1+W2),
        fd_sets:(Diff #= abs(W1-W2)),

        fd_sets:union(L1, L2, L3).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
label_sets([]).
	label_sets([S|Ss]) :-
	insetdomain(S,_,_,_),
	%%%Instantiate Set to a possible value
	label_sets(Ss).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
