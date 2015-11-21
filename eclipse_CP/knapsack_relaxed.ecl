:- lib(ic).
:- lib(branch_and_bound).

 %%%% Objetos a serem carregados na mochila
casos_de_testes(
        [[](45/3, 30/5, 45/9, 10/5)]
        ).

go :-
   	casos_de_testes(Lista_Testes),
	member( Array_Set , Lista_Testes),
	
	Knapsack_Size is 16, %%% Tamanho  DA MOCHILA
	
     modelo( Array_Set , Knapsack_Size , Custo , LX_Solucao ) ,
     %% busca + otimizacao
     otimiza(  LX_Solucao , Custo  ), 
     my_print( Array_Set, LX_Solucao,  Knapsack_Size , Custo),  
    fail.
    
go.    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modelo(Matriz_Valor_Peso, K , SOMA_NEG  , L_Vars)  :-
    dim(Matriz_Valor_Peso, [N]),
%%%%
%%% UM VETOR PARA PESO OUTRO PARA VALOR DO ITEM
%%%
    
    dim(V_Decisao, [N]), %% Vetor Decisao
    V_Decisao :: 0..1,
  %%%%% ALGO PARA PESO      
    %%  Encontrando a  UMA SOMA
     (for(I,1,N),
		param( Matriz_Valor_Peso , V_Decisao ),
		fromto( 0 , In , Out , SOMA_PESOS) 
    	do
    		Out #= In + (Matriz_Valor_Peso[I] * V_Decisao[I])
    ),

    SOMA_PESOS #=< K, %%% POSTANDO A RESTRICAO DA MOCHILA
     
  %%%%% ALGO PARA VALOR


        %%  Encontrando a  UMA SOMA
     (for(I,1,N),
		param( Matriz_Valor_Peso , V_Decisao ),
		fromto( 0 , In , Out , SOMA_VALORES) 
    	do
    		Out #= In + (Matriz_Valor_Peso[I] * V_Decisao[I])
    ),
  %%%%

     % prepare for maximization
      SOMA_VALORES   #= -SOMA,
      %%%% Este eh o a ser maximizado e o peso eh apenas a restricao
      
      array_list(V_Decisao, L_Vars). 
     %%% FIM DO MODELO

 %%%%%%%%%%%%%%%%%%%% A busca + a otimizacao  nesta ordem
otimiza(  LX_Solucao , Custo  ) :-
   %% Options = bb_options{strategy:dichotomic, timeout:60},
	%% Options = bb_options{delta:0.01}
	%% Options = bb_options{strategy:restart},
	%% Options = bb_options{strategy:continue, from: (-500000), to: 0} 
    Options = bb_options{strategy:continue},
	bb_min(  search( LX_Solucao , 0, first_fail, indomain_max, complete, []) , Custo, Options ).
     %% OU   minimize(search(LX_Solucao , 0,first_fail,indomain,complete,[]),  Custo),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%my_print( Array_Set, LX_Solucao,  Knapsack_Size , Custo),  
my_print(Array_Teste , LX_Sol ,  Knapsack_Size , Custo):-
   	dim(Array_Teste , [N]),
   	writeln( conjunto_Teste : Array_Teste ),
     array_list(Array_Sol , LX_Sol),	%%% BIDIRECIONAL ... MUITO BOM
   	writeln( decision_Vector : Array_Sol ),
 	(for( I , 1 , N ),
	 param( Array_Sol  , Array_Teste  )
	 do
	   ( XX_truque is Array_Sol[I], %% TAKE CARE  it is ARRAY
	     YY_truque is Array_Teste[I], 
	     XX_truque == 1 -> printf(" Vetor[%d] : %d " , [I, YY_truque]) ;
	     write(" . ")
	   )	   
    ),
    Custo_Pos is (-1)*Custo,
    printf("\n Valor da Soma : %d   e a  Mochila era: %d", [Custo_Pos, Knapsack_Size]),
    printf(output, "\n======================================\n " , [] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
