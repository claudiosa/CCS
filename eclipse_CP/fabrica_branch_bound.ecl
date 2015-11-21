
:- lib(ic).
:- lib(branch_and_bound).

%%% Matriz custo tipo: Trabalhador (Men) X Tarefa (Weight)
dados(M1,M2,M3,M4):-     	
/*               W1 W2 W3  W4            */
     	M1 =  [](7, 6, 4, 9),
     	M2 =  [](6, 4, 3, 7),
     	M3 =  [](5, 8, 1, 8),
     	M4 =  [](9, 2, 12, 10).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imp_fab:-	
        aplica_bb( (I:M1, J:M2, K:M3, L:M4), Custo),
		W1 is M1[I], W2 is M2[J], W3 is M3[K], W4 is M4[L],
		printf("\n M1 na task/tipo: %w custo: %w", [I,W1]),
		printf("\n M2 na task/tipo: %w custo: %w", [J,W2]),
		printf("\n M3 na task/tipo: %w custo: %w", [K,W3]),
		printf("\n M4 na task/tipo: %w custo: %w", [L,W4]),
		printf("\n Custo ....: %w \n\n", [Custo]).      

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aplica_bb((I:M1, J:M2, K:M3, L:M4), Custo):-
	%% Options = bb_options{strategy:dichotomic, timeout:60},
	%% Options = bb_options{delta:0.01}
	%% Options = bb_options{strategy:restart},
	Options = bb_options{strategy:continue},
	bb_min( modelo_fab( (I:M1, J:M2, K:M3, L:M4), Custo), Custo , Options ).
	%% OU
	%% minimize(labeling([I,J,K,L]), Custo).%% todas sol


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modelo_fab( (I:M1, J:M2, K:M3, L:M4), Custo ) :-    
     	 [I,J,K,L] :: [1 .. 4],
         dados(M1,M2,M3,M4), %% leu matriz acima

/* Estimando uma cota minima desta matriz?  COMO? */
%% UMA Ideia: menor valor por linha
%% 4 + 4 + 5 + 10 = 19 (uma estimativa)
%% 1/3 + 2/2 + 3/1 + 4/4  (trab/Index -- IJKL) 
%% Contudo sabemos que nao eh a melhor cota 
%% veja com cuidado a tabela ...  
   	alldifferent([I,J,K,L]),
   
    %%% TEM que VALORAR antes DO CORTE ... e LIMITAR
	search([I,J,K,L], 0, input_order, indomain_min, complete, []),
	%% input_order: vai tomar I->J->K->L (razoavel)
	%% indomain_random: aleatorio nos dominios, index 1 a 4
	M1[I] + M2[J] + M3[K] + M4[L] #= Custo.

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
