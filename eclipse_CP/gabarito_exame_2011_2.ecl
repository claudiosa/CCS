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
	writeln( via_statistics: Tstatistics ; segundos).
	
job_shop:- 

LS = [A,B,C,D,E,F,G,H,I,J,K,L],                   % lista com os tempos iniciais das tarefas
LD = [6,8,4,4,4,12,14,6,8,16,2,12],               % lista de duração das tarefas
LE = [Afim,Bfim,Cfim,Dfim,Efim,Ffim,Gfim,Hfim,Ifim,Jfim,Kfim,Lfim],  
% lista com os tempos finais das tarefas A, B, C ... L

LR = [2,3,3,4,2,3,1,4,2,1,1,3],                   %lista de custo(recursos) das tarefas

LS :: 1..50,                                      %Um domínio de tempo de inicio 1 a 50
End :: 1..70,									  %término de 1 a 70
LE :: 1..70,
Limit :: 1..6,									  %A capacidade máxima de recurso é igual a 6

%% primeiro dizer que nenhuma tarefa termina antes de começar
after(LS,LD,LE),   %%% tinha na apostila

%% Agora Explicitar que uma tarefa precede uma outra tarefa --- seguir tabela abaixo

D #> Afim,
E #> Afim,
F #> Efim, F #> Bfim,
G #> Efim, G #> Bfim,
H #> Bfim, H #> Cfim, H #> Efim,
I #> Dfim, I #> Ffim, 
J #> Dfim, J #> Ffim, J #> Gfim, 
K #> Dfim, K #> Ffim, K #> Gfim, 
L #> Hfim, L #> Kfim, 

/*
Tarefa   Duração    Precedências     Recurso
A            6                    -                    2   
B            8                    -                    3
C            4                    -                    3                       
D            4                   A                    4
E            4                   A                    2
F            12                 B,E                 3
G            14                 B,E                 1
H            6                   B,C,E              4
I             8                   D,F                  2
J            16                  D,F,G              1
K            2                   D,F,G              1
L            12                  H,K                 3


Jonnhy tentou algo como..... mas faltaram as precedencias corretas
E1 #= A+6,
E2 #= B+8,
E3 #= C+4,
E4 #= D+4,
E5 #= E+4,
E6 #= F+12,
E7 #= G+14,
E8 #= H+6,
E9 #= I+8,
E10 #= J+16,
E11 #= K+2,
E12 #= L+12,
*/

(	%%% o maior tempo da lista de fim
	foreach(I,LS), %%% porque .... APENAS VENDO O MAIOR TEMPO
	foreach(J,LD),
	foreach(K,L_FIM)
	do
	K #= I+J
),


cumulative(LS, LD, LR, Limit),
maxlist(L_FIM,End), %%% o maior da lista

append(LS,LE,Vars), %%% agrupando as tarefas que desejo etiquetar
minimize(labeling(Vars),End),
%%%%% search(Vars, 0 , first_fail, indomain, complete, []),

	nl,
	writeln( listaINICIOS: LS),
	writeln( listaFINAIS: LE),
	writeln( recursoUSADO: Limit),
	writeln( tempoDeTermino: End).

%%% POR PRECEDENCIA DOS TEMPOS DE TERMINO DAS TAREFAS
after([],[],[]).
after([Inicio|Ls],[Duracao|Ld],[Fim|Lf]):-
	Fim #>= Inicio + Duracao,
	after( Ls, Ld, Lf).
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P3
p3:-
	cputime(T1), write(T1), nl,
	statistics(event_time, Tcpu1), writeln( tcpu1: Tcpu1),
	vinho(X), writeln( vetor: X),
	cputime(T2), write(T2), nl,
	statistics(event_time, Tcpu2), writeln( tcpu2: Tcpu2),
	T is (T2 - T1),
	Tstatistics is (Tcpu2 - Tcpu1),
	writeln( tudo_Gastou: T  ; segundos),
	writeln( via_statistics: Tstatistics ; segundos).

/* Sol do BRUNO*/
% valor inteiro de meia garrafa 
vol_garrafaCheia(1).

calc(A, B, D):- vol_garrafaCheia(V), D #= A*2*V + B*V.
resp(N, A, B, C):- 
	write('Aluno '), write(N), write(': ['), write(A), write(', '),
	write(B), write(', '), write(C), write('] = '), 
	calc(A, B, T), write(T), write(' litros.'), nl.

branco(0):- !.
branco(X):- write(' '), X1 is X - 1, branco(X1).


vinho(Garrafa):-
	Garrafa = [Ax, Ay, Az, Bx, By, Bz, Cx, Cy, Cz],
	Garrafa :: 0..7,
	
	Xt #= Ax + Ay + Az,
	Yt #= Bx + By + Bz,
	Zt #= Cx + Cy + Cz,
	
	Xt #= 7,
	Yt #= 7,
	Zt #= 7,
	
	Ax + Bx + Cx #=< 7,
	Ay + By + Cy #=< 7,
	Az + Bz + Cz #=< 7,
	
	calc(Ax, Ay, A),
	calc(Bx, By, B),
	calc(Cx, Cy, C),

	A #= B,
	B #= C,
	C #= A,
	
	labeling(Garrafa),
	
	resp(1, Ax, Ay, Az),
	resp(2, Bx, By, Bz),
	resp(3, Cx, Cy, Cz),
	branco(15), 
	write(Xt), write(', '), write(Yt), write(', '), write(Zt), nl.
/*

?- vinho(X).
X = [1, 5, 1, 3, 1, 3, 3, 1, 3]
Yes (0.00s cpu, solution 1, maybe more)

Aluno 1: [1, 5, 1] = 14 litros.
Aluno 2: [3, 1, 3] = 14 litros.
Aluno 3: [3, 1, 3] = 14 litros.
			   7, 7, 7
*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P4

p4:-
	cputime(T1), write(T1), nl,
	statistics(event_time, Tcpu1), writeln( tcpu1: Tcpu1),
	quad(X), writeln( vetor: X),
	cputime(T2), write(T2), nl,
	statistics(event_time, Tcpu2), writeln( tcpu2: Tcpu2),
	T is (T2 - T1),
	Tstatistics is (Tcpu2 - Tcpu1),
	writeln( tudo_Gastou: T  ; segundos),
	writeln( via_statistics: Tstatistics ; segundos).
	
/* Sol do BRUNO*/	
adj(_, []):- !.
adj(N, [H|T]):- N #< H - 1, adj(N, T);
				N #> H + 1, adj(N, T).


quad(Quad):-
	Quad = [Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8],
	Quad :: 1..8,
	
	adj(Q1, [Q2, Q3, Q4, Q5]),
	adj(Q2, [Q4, Q5, Q6]),
	adj(Q3, [Q4, Q7]),
	adj(Q4, [Q5, Q7, Q8]),
	adj(Q5, [Q6, Q7, Q8]),
	adj(Q6, [Q8]),
	adj(Q7, [Q8]),
	
	alldifferent([Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8]),
	
	labeling(Quad).
/*
  P4
  
 considerar:
 
   Q1 Q2
Q3 Q4 Q5 Q6
   Q7 Q8
    
Saida:
	?- quad(Q).
	Q = [3, 5, 7, 1, 8, 2, 4, 6]
	Yes (0.00s cpu, solution 1, maybe more)
	Q = [4, 6, 7, 1, 8, 2, 3, 5]
	Yes (0.00s cpu, solution 2, maybe more)
	Q = [5, 3, 2, 8, 1, 7, 6, 4]
	Yes (0.02s cpu, solution 3, maybe more)
	Q = [6, 4, 2, 8, 1, 7, 5, 3]
	Yes (0.03s cpu, solution 4, maybe more)


exemplo do resultado:
	   3 5
	 7 1 8 2
	   4 6
	   
	   4 6
	 7 1 8 2
	   3 5
	   
	   5 3
	 2 8 1 7
	   6 4
	   
	   6 4
	 2 8 1 7
	   5 3
*/



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
