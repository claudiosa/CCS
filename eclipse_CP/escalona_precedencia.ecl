%%%% UM Gabarito do Exame Final 2011/2 ---- quase lah

:-lib(ic).
:-lib(ic_edge_finder3).
:-lib(branch_and_bound).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p1:-

	cputime(T1), write(T1), nl,
	statistics(event_time, Tcpu1), writeln( tcpu1: Tcpu1),
	job_shop,
	cputime(T2), write(T2), nl,
	statistics(event_time, Tcpu2), writeln( tcpu2: Tcpu2),
	T is (T2 - T1),
	Tstatistics is (Tcpu2 - Tcpu1),
	writeln( tudo_Gastou: T  ; segundos),
	writeln( via_statistics: Tstatistics ; segundos)
	,
	fail.
p1.	
	
job_shop:- 

LS = [A,B,C,D,E,F,G,H,I,J,K,L],      % lista com os tempos iniciais das tarefas
LD = [6,8,4,4,4,12,14,6,8,16,2,12],  % lista de duracao das tarefas
LE = [Afim,Bfim,Cfim,Dfim,Efim,Ffim,Gfim,Hfim,Ifim,Jfim,Kfim,Lfim],  
% lista com os tempos finais das tarefas A, B, C ... L

LR = [2,3,3,4,2,3,1,4,2,1,1,3],     %lista de custo(recursos) das tarefas

LS :: 1..50,       %Um dominio de tempo de inicio 1 a 50
End :: 1..70,	%Termino de 1 a 70
LE :: 1..70,
Limit :: 1..6,	 %A capacidade maxima de recurso e igual a 6

%% primeiro dizer que nenhuma tarefa termina antes de comecar
after(LS,LD,LE),   % veja abaixo este predicaco

%% Explicitar que uma tarefa precede uma outra tarefa --- seguir tabela abaixo
A #>= 1,
D #> Afim,
E #> Afim,
F #> Efim, F #> Bfim,
G #> Efim, G #> Bfim,
H #> Bfim, H #> Cfim, H #> Efim,
I #> Dfim, I #> Ffim, 
J #> Dfim, J #> Ffim, J #> Gfim, 
K #> Dfim, K #> Ffim, K #> Gfim, 
L #> Hfim, L #> Kfim, 

/* ********************************
Esta tabela eh dado do problema
  Tarefa   Duracao    Precedencias      Recurso
	A         6            -               2   
	B         8            -               3
	C         4            -               3                       
	D         4            A               4
	E         4            A               2
	F         12           B,E             3
	G         14           B,E             1
	H         6            B,C,E           4
	I         8            D,F             2
	J         16           D,F,G           1
	K         2            D,F,G           1
	L         12           H,K             3

*******************************************************
*/

(	%%% o maior tempo da lista de fim
	foreach(I,LS), %%% porque .... APENAS VENDO O MAIOR TEMPO
	foreach(J,LD),
	foreach(K,L_FIM)
	do
	K #= I+J
),

% cumulative organiza estas listas de listas
cumulative(LS, LD, LR, Limit),
maxlist(L_FIM, End), %%% o maior da lista

append(LS,LE,Vars), %%% agrupando as tarefas que desejo etiquetar
minimize(labeling(Vars),End),
%% testar variacoes com o search ... ver manual
%%%%% search(Vars, 0 , first_fail, indomain, complete, []),

	nl,
	writeln( listaINICIOS: LS),
	writeln( listaFINAIS: LE),
	writeln( recursoUSADO: Limit),
	writeln( tempoDeTermino: End).

%%% end job_shop

%%% POR PRECEDENCIA DOS TEMPOS DE TERMINO DAS TAREFAS
after([],[],[]).
after([Inicio|Ls],[Duracao|Ld],[Fim|Lf]):-
	Fim #>= Inicio + Duracao,
	after( Ls, Ld, Lf).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%
/*

1.01
tcpu1 : 54.94
lists.eco  loaded in 0.01 seconds
Found a solution with cost 49
Found a solution with cost 46
Found no solution with cost 44.0 .. 45.0

listaINICIOS : [1, 1, 7, 11, 9, 15, 14, 27, 33, 29, 29, 34]
listaFINAIS : [7, 9, 11, 15, 13, 27, 28, 33, 41, 45, 31, 46]
recursoUSADO : 6
tempoDeTermino : 46
1.08
tcpu2 : 55.03
tudo_Gastou : 0.0700000000000001 ; segundos
via_statistics : 0.0900000000000034 ; segundos

*/
