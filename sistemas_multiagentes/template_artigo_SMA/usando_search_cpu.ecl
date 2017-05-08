%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-lib(ic).
% Ideia retirado de http://eclipseclp.org/doc/bips/lib/ic/search-6.html
% 
go:-
	%% Inclua outros metodos se convier... ou retire os que nao sao bons....
	%% como saber combinacoes ruins e boas?
	%% depende do PROBLEMA e tem EXECUTAR .... veja as diferencas 
	%% no modelo ... e trabalho com as melhores opcoes....
	member(Selec_Var,[first_fail,
		          anti_first_fail,
			  %most_constrained,
			  %occurrence,	
			  smallest,
			  largest,
			 %input_order,
			  max_regret]),
	member(Escolha_Dom,
		       [indomain,
	               indomain_min,
		       %indomain_max,
		       %indomain_middle,
		       %indomain_median,
		       %indomain_split,
		       indomain_random]),
	%%% Ha outro metodos ... veja o link acima
	member(Metodo_Busca,[complete]), 
	%%% tal como:
	%%lds(2),credit(64,5),bbs(1000),dbs(5,10)]),
	%% OLHAR NO MANUAL ESTAS OPCOES ... validas para minimizacao ?

	cputime(T1), %write(T1), nl,
	statistics(event_time, Tcpu1), %writeln( tcpu1: Tcpu1),
	%% dados
	dados(Dados),
	%% chama modelo
	meu_modelo(Dados, Selec_Var, Escolha_Dom, Metodo_Busca, Num_Backs, Resposta),
	%% imprime resultados
        writeln("......................................................................"),
	writeln("Selec_Var" : Selec_Var),
	writeln("Escolha_Dom" : Escolha_Dom),
	writeln("Metodo_Busca " :  Metodo_Busca),
	writeln("Num_Backs" :Num_Backs),
	writeln("Resposta ........." :Resposta),
	cputime(T2), %write(T2), nl,
	statistics(event_time, Tcpu2), %writeln( tcpu2: Tcpu2),
	T is (T2 - T1),
	Tstatistics is (Tcpu2 - Tcpu1),
	writeln( esta_resposta_Gastou: T  ; segundos),
	writeln( via_statistics: Tstatistics ; segundos),
	fail.
	
go:- writeln("ENFIM ......... OK ").

%%% voces podem melhorar o esquema acima
%%% fazendo a mesma ideia para dados.
dados(711).
%% algo como member(Dados,[711,987,345]).
%% incluam esta linha no trecho acima com os dados que querem testar.

meu_modelo(Dados, Selec_Var, Escolha_Dom, Metodo_Busca, Num_Backs, Prices):-
      Sum = Dados,
      Product = Dados,
      Prices = [A, B, C, D],
      % A #> 0, B #> 0, C #> 0, D #> 0,
      Prices :: [1..711],
      A + B + C + D #= Sum,
      A * B * C * D #= Product * 1000000,
      A #< B,
      B #< C,
      C #< D,
      %%% tendo uma funcao custo a minimizacao poderia ser aplicada 	
      search(Prices ,0, Selec_Var, Escolha_Dom, Metodo_Busca, [backtrack(Num_Backs)]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
