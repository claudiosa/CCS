%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-lib(ic).
% Ideia retirada de http://eclipseclp.org/doc/bips/lib/ic/search-6.html
% 
% Problema eh bem conhecido
% Dado 4 valores de moedas distintas .... a sua soma dah 7,11
% e a multiplicacao entre estes 4 valores, tabmém é 7,11
/*
 1o.: fugir dos reais ... logo multiplicar 7,11 x 100 = 711 
 2o.: lembrar que dois num frac 0,.. x 0,... => 10^-2, isto é, 0,0... 
 3o.: multiplicando pelo 3o. num frac 0,.. x 0,0... => 10^{-2} x 0,... => 10^{-3}
 4o.: multiplicando pelo 4o. num frac 0,.. x 0,00... => 10^{-3} x 0,... => 10^{-4} 

Logo, se estamos considerando valores entre 1 e 711 como o novo DOMINIO
temos A+B+C+D #=711 - OK ... sem problemas para soma, mas quanto a
multiplicacao, temos que considerar todas potencias acima, no caso:

A+B+C+D #=711x10^{4}x100=  711 * 10^{6}= 711 *1000000

*/
go:-
	%% Inclua outros metodos se convier... ou retire os que nao sao bons....
	%% como saber combinacoes ruins e boas?
	%% depende do PROBLEMA e tem EXECUTAR .... veja as diferencas 
	%% no modelo ... e trabalho com as melhores opcoes....
	member(Selec_Var,[first_fail
                      % , 
		              %anti_first_fail,
						%most_constrained,
						%occurrence,	
						%smallest,
						%largest,
						%input_order,
						%max_regret
                        ]),
	member(Escolha_Dom,
		       [%indomain,
	            %indomain_min,
		       %indomain_max,
		       indomain_middle,
		       indomain_median
		       %indomain_split,
		       %indomain_random
               ]),
	%%% Ha outro metodos ... veja o link acima
	member(Metodo_Busca,[complete]), 
	%%% tal como:
	%%lds(2),credit(64,5),bbs(1000),dbs(5,10)]),
	%% OLHAR NO MANUAL ESTAS OPCOES ... validas para minimizacao ?

	cputime(T1), %write(T1), nl,
	statistics(event_time, Tcpu1), %writeln( tcpu1: Tcpu1),
	
	%% chama modelo
	meu_modelo( Selec_Var, Escolha_Dom, Metodo_Busca, Num_Backs, Resposta),
	%% imprime resultados
    writeln("................................................................"),
	writeln("Selec_Var" : Selec_Var),
	writeln("Escolha_Dom" : Escolha_Dom),
	writeln("Metodo_Busca " :  Metodo_Busca),
	writeln("Num_Backs" :Num_Backs),
	writeln("Resposta ........." :Resposta),
	cputime(T2), %write(T2), nl,
	statistics(event_time, Tcpu2), %writeln( tcpu2: Tcpu2),
	T is (T2 - T1),
	Tstatistics is (Tcpu2 - Tcpu1),
	writeln( esta_resposta_Gastou: T  : segundos),
	writeln( via_statistics: Tstatistics : segundos),
	fail. %% ; true.
	
go:- writeln("ENFIM ......... OK ").

%%% voces podem melhorar o esquema acima


%% algo como member(Dados,[711,987,345]).
%% incluam esta linha no trecho acima com os dados que querem testar.

meu_modelo(Selec_Var, Escolha_Dom, Metodo_Busca, Num_Backs, Moedas):-
	  
      Moedas = [A, B, C, D],
      % A #> 0, B #> 0, C #> 0, D #> 0,
      Moedas #:: [1..711],
      Sum #= 711 and Product #= 711,
      A + B + C + D #= Sum,
      A * B * C * D #= Product * 1000000,
      %%% QUEBRA DE SIMETRIA
      A #< B,
      B #< C,
      C #< D,
      %%% tendo uma funcao custo a minimizacao poderia ser aplicada 	
      search(Moedas ,0, Selec_Var, Escolha_Dom, Metodo_Busca, [backtrack(Num_Backs)]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
lists.eco  loaded in 0.00 seconds
......................................................................
Selec_Var : first_fail
Escolha_Dom : indomain
Metodo_Busca  : complete
Num_Backs : 88
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 4.39 ; segundos
via_statistics : 4.42999999999999 ; segundos
......................................................................
Selec_Var : first_fail
Escolha_Dom : indomain_min
Metodo_Busca  : complete
Num_Backs : 88
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 2.0 ; segundos
via_statistics : 2.00999999999999 ; segundos
......................................................................
Selec_Var : first_fail
Escolha_Dom : indomain_random
Metodo_Busca  : complete
Num_Backs : 42
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 1.8 ; segundos
via_statistics : 1.81 ; segundos
......................................................................
Selec_Var : anti_first_fail
Escolha_Dom : indomain
Metodo_Busca  : complete
Num_Backs : 88
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 13.31 ; segundos
via_statistics : 13.36 ; segundos
......................................................................
Selec_Var : anti_first_fail
Escolha_Dom : indomain_min
Metodo_Busca  : complete
Num_Backs : 88
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 5.42 ; segundos
via_statistics : 6.11 ; segundos
......................................................................
Selec_Var : anti_first_fail
Escolha_Dom : indomain_random
Metodo_Busca  : complete
Num_Backs : 36
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 5.56 ; segundos
via_statistics : 5.75 ; segundos
......................................................................
Selec_Var : smallest
Escolha_Dom : indomain
Metodo_Busca  : complete
Num_Backs : 88
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 13.28 ; segundos
via_statistics : 13.31 ; segundos
......................................................................
Selec_Var : smallest
Escolha_Dom : indomain_min
Metodo_Busca  : complete
Num_Backs : 88
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 6.06 ; segundos
via_statistics : 6.06999999999999 ; segundos
......................................................................
Selec_Var : smallest
Escolha_Dom : indomain_random
Metodo_Busca  : complete
Num_Backs : 48
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 6.64 ; segundos
via_statistics : 6.67000000000002 ; segundos
......................................................................
Selec_Var : largest
Escolha_Dom : indomain
Metodo_Busca  : complete
Num_Backs : 6
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 0.0300000000000011 ; segundos
via_statistics : 0.0400000000000205 ; segundos
......................................................................
Selec_Var : largest
Escolha_Dom : indomain_min
Metodo_Busca  : complete
Num_Backs : 6
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 0.0300000000000011 ; segundos
via_statistics : 0.0300000000000011 ; segundos
......................................................................
Selec_Var : largest
Escolha_Dom : indomain_random
Metodo_Busca  : complete
Num_Backs : 7
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 0.100000000000009 ; segundos
via_statistics : 0.120000000000005 ; segundos
......................................................................
Selec_Var : max_regret
Escolha_Dom : indomain
Metodo_Busca  : complete
Num_Backs : 88
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 13.23 ; segundos
via_statistics : 13.24 ; segundos
......................................................................
Selec_Var : max_regret
Escolha_Dom : indomain_min
Metodo_Busca  : complete
Num_Backs : 88
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 6.07000000000001 ; segundos
via_statistics : 6.09 ; segundos
......................................................................
Selec_Var : max_regret
Escolha_Dom : indomain_random
Metodo_Busca  : complete
Num_Backs : 12
Resposta ......... : [120, 125, 150, 316]
esta_resposta_Gastou : 1.84999999999999 ; segundos
via_statistics : 1.84999999999999 ; segundos
ENFIM ......... OK 
*/

