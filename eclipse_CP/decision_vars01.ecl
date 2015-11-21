
:-lib(ic).
%:-lib(lists).

vetor([](3, 5, 7, 9, 3, 4, 6, 7, 8, 2, 2,  2, 2, 2)).
cte(12). %%% um valor final da soma de valores do vetor acima


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prod_escalar_Array(A1, A2 , Prod_Result):-
	(
	 foreacharg(X1, A1),
  	 foreacharg(X2, A2),
	 %% vantagem da lista ... nao precisa declarar o tamanho
     foreach(P_cel, Array_de_cel)
	 do
	     P_cel  #=  X1*X2 %%% ou  P_cel is X1*X2
     ),
      writeln("Array de restricoes em soma:" : Array_de_cel),
      Prod_Result #= sum(Array_de_cel),  
      %%%% sum: Soma de Array .... INTERNAMENTE tudo LISTA
      writeln("Unico valor ... em um dominio" : Prod_Result).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

go :-
	    cte(K),
        vetor(V),
        collection_to_list(V, L),
        
        length(L,N),
        dim(X_Decision, [N]), %% cria um array
        X_Decision #:: 0 .. 1, %% vals do dominio para este array
 
	    %% R1:
        prod_escalar_Array( X_Decision, V, Prod_Esc_X) , 
	    %% R2:
        Prod_Esc_X #= K,
        %% writeln(" Temps " : [K, Prod_Esc_X] ),
  
% 	flatten_array( X, LX ), %% converte Array versus Lista
%	array_list( X, L_X ), ?? ERA para funcionar
    collection_to_list( X_Decision, L_X ),
    search(L_X, 0, first_fail,indomain,complete,[]),
    writeln(" Decision Array  " :  X_Decision). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
SAIDA:
decision_vars01.ecl compiled 3728 bytes in 0.02 seconds
Array de restricoes em soma: : [_1044{0 .. 3}, _1299{0 .. 5}, _1554{0 .. 7}, _1809{0 .. 9}, _2064{0 .. 3}, _2319{0 .. 4}, _2574{0 .. 6}, _2829{0 .. 7}, _3084{0 .. 8}, _3339{0 .. 2}, _3594{0 .. 2}, _3849{0 .. 2}, _4104{0 .. 2}, _4359{0 .. 2}]
Unico valor ... em um dominio : _4956{0 .. 62}
 Decision Array   : [](0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1)
 Decision Array   : [](0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1)
*/
