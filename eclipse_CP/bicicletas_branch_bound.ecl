
:- lib(ic).
:- lib(branch_and_bound).

%%% Matriz custo tipo: Meninas (M) X Bicicletas (Weight)
dados(M1,M2,M3,M4):-     	
/*               B1 B2 B3  B4            */
     	M1 =  [](7, 6, 4, 9),
     	M2 =  [](6, 4, 3, 7),
     	M3 =  [](5, 8, 1, 8),
     	M4 =  [](9, 2, 12, 10).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
go :-	
  aplica_bb( (I:M1, J:M2, K:M3, L:M4), Custo),
  B1 is M1[I], B2 is M2[J], B3 is M3[K], B4 is M4[L],
  printf("\n M1 escolhe a bicicleta: %w custo da pref: %w", [I,B1]),
  printf("\n M2 escolhe a bicicleta: %w custo da pref: %w", [J,B2]),
  printf("\n M3 escolhe a bicicleta: %w custo da pref: %w", [K,B3]),
  printf("\n M4 escolhe a bicicleta: %w custo da pref: %w", [L,B4]),
  printf("\n Custo ....: %w \n\n", [Custo]).      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aplica_bb((I:M1, J:M2, K:M3, L:M4), Custo):-
	%% Options = bb_options{strategy:dichotomic, timeout:60},
	%% Options = bb_options{delta:0.01}
	%% Options = bb_options{strategy:restart},
	Options = bb_options{strategy:continue},
	bb_min( modelo_bike((I:M1,J:M2,K:M3,L:M4),Custo),Custo,Options ).
	%% OU
	%% minimize(labeling([I,J,K,L]), Custo).%% todas sol

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modelo_bike( (I:M1, J:M2, K:M3, L:M4), Custo ) :-    
     	 [I,J,K,L] :: [1 .. 4],
         dados(M1,M2,M3,M4), %% leu matriz acima
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* Estimando uma cota minima desta matriz?  COMO? */
%% UMA Ideia: menor valor por linha
%% 4 + 4 + 5 + 10 = 23 (uma estimativa)
%% 1/3 + 2/2 + 3/1 + 4/4  (trab/Index -- IJKL) 
%% Contudo sabemos que nao eh a melhor cota 
%% veja com cuidado a tabela ...  
   	alldifferent([I,J,K,L]),
          
    %%% TEM que VALORAR (etiquetar) antes DO CORTE no BB
	search([I,J,K,L], 0, input_order, indomain_min, complete, []),
	%% input_order: vai tomar I->J->K->L (razoavel)
	%% indomain_random: aleatorio nos dominios, index 1 a 4
	 M1[I] + M2[J] + M3[K] + M4[L] #= Custo.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
