
:-lib(ic).
:-lib(ic_edge_finder3).
:-lib(branch_and_bound).

go:-
	cputime(T1), write(T1), nl,
	statistics(event_time, Tcpu1), writeln( tcpu1: Tcpu1),
	vinho,
	cputime(T2), write(T2), nl,
	statistics(event_time, Tcpu2), writeln( tcpu2: Tcpu2),
	T is (T2 - T1),
	Tstatistics is (Tcpu2 - Tcpu1),
	writeln( tudo_Gastou: T  ;  segundos),
	writeln( via_statistics: Tstatistics ; segundos).

/* Solucao do BRUNO */
% valor inteiro de MEIA garrafa 
vol_meia_garrafa(1).

calc(A, B, D):-  vol_meia_garrafa(V),  
			     D #= A*2*V + B*V.

resp(N, A, B, C):- 
	write('Aluno '), write(N), write(': ['), write(A), write(', '),
	write(B), write(', '), write(C), write('] = '), 
	calc(A, B, T), write(T), write(' litros.'), nl.

branco(0):- !.
branco(X):- write(' '), X1 is (X - 1), branco(X1).

vinho:-
	Garrafa = [Ax, Ay, Az, Bx, By, Bz, Cx, Cy, Cz],
	% Notacao: x: garrafa CHEIA, y: meia cheia, z: vazia
	%          A, B e C: alunos
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
	write(Xt), write(', '), write(Yt), write(', '), write(Zt), nl,
         writeln( vetor: Garrafa).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vinhoCC:-
	QT_Garrafas = [Ax, Ay, Az, Bx, By, Bz, Cx, Cy, Cz],
	QT_Garrafas :: 0..7,
    Vol_Garrafas = [VAx, VAy, VBx, VBy, VCx, VCy],
	Vol_Garrafas :: [5] ,
	
	7 #= Ax + Ay + Az, %% QT de garrafas do estudante A
	7 #= Bx + By + Bz,
	7 #= Cx + Cy + Cz,
       
	Ax + Bx + Cx #= 7, %% Qt de garrafas do tipo CHEIAS
	Ay + By + Cy #= 7, %% Qt de garrafas do tipo 1/2 CHEIAS
	Az + Bz + Cz #= 7, %% Qt de garrafas do tipo VAZIAS
	
	calc_vol(Ax, Ay, VAx, VAy, A),
	calc_vol(Bx, By, VBx, VBy, B),
	calc_vol(Cx, Cy, VCx, VCy, C),
    
    %%% VOLUME TOTAL POR ESTUDANTE
	A #= B,
	B #= C,
%	C #= A,
	%% juntando as listas para search
	append(QT_Garrafas, Vol_Garrafas, Vars ),
	labeling(Vars),
	
	respCC(1, Ax, Ay, Az, VAx, VAy),
	respCC(2, Bx, By, Bz, VBx, VBy),
	respCC(3, Cx, Cy, Cz, VCx, VCy),
    writeln( vetorQT: QT_Garrafas ;  vetorVol:  Vol_Garrafas).

calc_vol(A, B, VA,VB, D) :-  D #= (2*A*VA + B*VB).


respCC(N, A, B, C, Full, Half):- 
	write('Aluno '), write(N), write(': ['), write(A), write(', '),
	write(B), write(', '), write(C), write(']  =    '),
	Temp is (2*A*Full + B*Half)/5,
    write(Temp), write(' litros.'), nl.

