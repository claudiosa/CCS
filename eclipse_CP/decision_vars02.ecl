
:-lib(ic).

vetor([](3, 5, 7, 9, 3, 4, 6, 7, 8, 2, 2,  2, 2, 2)).
cte(12). %%% um valor final da soma de valores do vetor acima
n_X(3).

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
      Prod_Result #= sum(Array_de_cel),  %%%% sum: Soma de Array
      writeln("Unico valor ... em um dominio" : Prod_Result).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

go :-
	    n_X(W), %% quantos valores desejados
	    cte(K), %% uma constante limite. Ex: sub-set-sum
        vetor(V),
        collection_to_list(V, L),
        
        length(L,N),
        dim(X_Decision, [N]), %% cria um array
        X_Decision #:: 0 .. 1, %% vals do dominio para este array
 
        %% R1:  
        sum( X_Decision[1 .. N] ) #=< W, 
		%% R2:
        prod_escalar_Array( X_Decision, V, Prod_Esc_X) , 
	    %% R3:
        Prod_Esc_X #= K, 
%%      K #= eval(Prod_Esc_X), %% forca a avaliacao
     
  
% 	flatten_array( X, LX ), %% converte Array versus Lista
%	array_list( X, L_X ), ?? ERA para funcionar
    collection_to_list( X_Decision, L_X ),
    search(L_X, 0, first_fail,indomain,complete,[]),
    writeln(" Temps " : [W, K, Prod_Esc_X] ),
    writeln(" Decision Array  " :  X_Decision).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
Saida:
Array de restricoes em soma: : [_1381{0 .. 3}, _1636{0 .. 5}, _1891{0 .. 7}, _2146{0 .. 9}, _2401{0 .. 3}, _2656{0 .. 4}, _2911{0 .. 6}, _3166{0 .. 7}, _3421{0 .. 8}, _3676{0 .. 2}, _3931{0 .. 2}, _4186{0 .. 2}, _4441{0 .. 2}, _4696{0 .. 2}]
Unico valor ... em um dominio : _5293{0 .. 62}
 Temps  : [3, 12, 12]
 Decision Array   : [](0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1)
 Temps  : [3, 12, 12]
 Decision Array   : [](0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1)


obs:
?- X is sum([0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1]), write(X).
X = 3
*/
