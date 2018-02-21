:- lib(ic).
%%:- lib(array).
:- lib(branch_and_bound).
%% sliding a window with 11..11 over an array with size N

 
casos_testes(
        [[](3, -17, 7, 9), 
        [](20, 30, -5, 40),
        [](2,  3,  -4),
        [](3,  3, -7,  40)]
       ).

go :-
	casos_testes(Lista_Testes),
	member(Matriz_Peso , Lista_Testes),
	%% Queria melhorar isto aqui...
	%modelo(Matriz_Peso ,  Xslist, Custo),
    %busca(Xslist),
    %%%%%%% separando em em modelo + busca + otimiza
    %%% quem pode fazer isto por mim ?????
    otimiza( modelo(Matriz_Peso, L_Vars , Custo) ),
    writeln("xCASO de TESTE"  : Matriz_Peso),
    writeln("xLVARs custo"  : L_Vars : Custo),
    fail.
    
go.    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modelo(Matriz_Peso, L_Vars,  MAX_Custo ) :-
    
    dim(Matriz_Peso, [N]),
    dim(V_Decisao, [N]), %% Vetor Decisao
    V_Decisao :: 0..1,
    [Begin, End] :: 1..N,
    Janela  :: 1..N, %% TAMANHO VARIAVEL da Janela
    End - Begin #= Janela - 1 , %%% intervalo .... de 1 a  N
        
    ( foreacharg(Xi, V_Decisao, I), 
        param(Begin, End) do
        Yes #= (I #>= Begin and I #=< End),
        #=(Xi, 1, Yes) ),
        %% sendo Yes verdade, entao Xi eh reifado em 1
        
        
      %%  Encontrando TotalCost para usar no BAB
     (for(I,1,N),
		param( Matriz_Peso , V_Decisao ),
		fromto( 0 , In , Out , Custo) 
    	do
    		Out #= In + (Matriz_Peso[I] * V_Decisao[I])
	),
    
    MAX_Custo #= -Custo,
   
    flatten_array(V_Decisao, Xslist), %%% VELHO
    %%%array_list(V_Decisao, Xslist), %%% QUAL EH A BIB 
    append([Begin, End, Janela], Xslist, L_Vars),
   
	%%% BUSCA
    search( L_Vars , 0, first_fail, indomain_min, complete, []).
     
    
otimiza(modelo(Matriz_Peso,  Xslist, Custo)):-
	%% Options = bb_options{strategy:dichotomic, timeout:60},
	%% Options = bb_options{delta:0.01}
	%% Options = bb_options{strategy:restart},
	Options = bb_options{strategy:continue},
    bb_min(modelo(Matriz_Peso,  Xslist, Custo), Custo, Options ).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
