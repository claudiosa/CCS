:- lib(ic).
:- lib(ic_cumulative).
:- lib(branch_and_bound).
:- lib(lists).

x :- modelo([X, Y, Z]), write(X), nl, write(Y), nl, write(Z), nl. 


r6([X,Y,Z]) :- -X + 3*Y -3*Z #>= 4.

r7([X,Y,X]) :-  X + 2*Y #>= 8.

r8([X,Y,Z]) :-  2*X + 3*Y + X #=< 10. 



mod1([X, Y, Z]) :-
    % Variaveis = [X,Y,Z],
	% Variaveis :: 0 .. 100,
    X :: 0 .. 100,
    Y :: 0 .. 100,
    Z :: 0 .. 100,
    
    X + Y + Z  #=< 8,
    
    nl,
    nl,
    write('after R1'),
    nl,    
    
    get_domain(X, Dx1), nl, write( dx_dominioDX: Dx1),
    get_domain(Y, Dy1), nl, write( dy_dominioDY: Dy1),
    get_domain(Z, Dz1), nl, write( dz_dominioDZ: Dz1),    

    X - Y + (2 * Z) #>= 2, 

    nl,
    nl,
    write('after R2'),
    nl,    

    get_domain(X, Dx2), nl, write( dx_dominioDX: Dx2),
    get_domain(Y, Dy2), nl, write( dy_dominioDY: Dy2),
    get_domain(Z, Dz2), nl, write( dz_dominioDZ: Dz2),
        
    X + (4 * Y) - Z #>= 16,

    nl,
    nl,
    write('after R3'),
    nl,    

    get_domain(X, Dx3), nl, write( dx_dominioDX: Dx3),
    get_domain(Y, Dy3), nl, write( dy_dominioDY: Dy3),
    get_domain(Z, Dz3), nl, write( dz_dominioDZ: Dz3),    
    
    ((-1) * X) + (4 * Y) - (4 * Z) #>= 3,
    
    nl,
    nl,
    write('after R4'),
    nl,        
    
    get_domain(X, Dx4), nl, write( dx_dominioDX: Dx4),
    get_domain(Y, Dy4), nl, write( dy_dominioDY: Dy4),
    get_domain(Z, Dz4), nl, write( dz_dominioDZ: Dz4),    
    
    (4 * X) - (3 * Y) + (8 * Z) #=< 16,

    nl,
    nl,
    write('after R5'),
    nl,        
    
    get_domain(X, Dx5), nl, write( dx_dominioDX: Dx5),
    get_domain(Y, Dy5), nl, write( dy_dominioDY: Dy5),
    get_domain(Z, Dz5), nl, write( dz_dominioDZ: Dz5),    
    
    nl,
    nl,
    
    labeling([X, Y, Z]).

/* 

a) 

 a.1  X = 2, 
   Y = 4, 
   Z = 2

  2 +   4 +   2 ≤  8
  2 -   4 + 2*2 ≥  2
  2 + 4*4 -   2 ≥ 16
 -2 + 4*4 - 4*2 ≥  3
4*2 - 3*4 + 8*2 ≤ 16

a.2

   X = 5, 
   Y = 3,
   Z = 0

  5 +   3 +   0 ≤  8
  5 -   3 + 2*0 ≥  2
  5 + 4*3 -   0 ≥ 16
 -5 + 4*3 - 4*0 ≥  3
   4*5 - 3*3 + 8*0 ≤ 16

b) Não força fixação de nenhuma variável.

c) A restrição R7: x + 2y ≥ 8 é equivalente a restrição R4: -x + 4y - 4z ≥ 3

d) Ao descomentar (2 * X) + (3 * Y) + Z #=< 10 não é encontrado nenhum dominio.

e)

after R1

dx_dominioDX : 0 .. 8
dy_dominioDY : 0 .. 8
dz_dominioDZ : 0 .. 8

after R2

dx_dominioDX : 0 .. 8
dy_dominioDY : 0 .. 8
dz_dominioDZ : 0 .. 8

after R3

dx_dominioDX : 0 .. 5
dy_dominioDY : 3 .. 8
dz_dominioDZ : 0 .. 5

after R4

dx_dominioDX : 0 .. 5
dy_dominioDY : 3 .. 8
dz_dominioDZ : 0 .. 5

after R5

dx_dominioDX : 0 .. 5
dy_dominioDY : 3 .. 8
dz_dominioDZ : 0 .. 5
*/

mod2([A,B,C,D,E,F,G]):-
                        [A,B,C,D,E,F,G] :: 1 .. 7 ,
                        [P1,P2,P3,P4,P5,P6,P7] :: 12 .. 91,
                        alldifferent([A,B,C,D,E,F,G]),
                        element(A,[15 , 45 , 56 , 13 , 45 , 23 , 76],P1),
                        element(B,[23 , 76 , 45 , 45 , 49 , 25 , 98],P2),
                        element(C,[43 , 32 , 87 , 34 , 18 , 29 , 56],P3),
                        element(D, [27 , 39 , 75 , 51 , 48 , 39 , 41],P4),
                        element(E, [76  ,72 , 34 , 52 , 58 , 52 , 34],P5),
                        element(F, [43 , 37 , 76 , 21 , 98 , 41 , 76],P6),
                        element(G, [91 , 48 , 29 , 76 , 23 , 12 , 77],P7),
                        MENORCUSTO #= P1+P2+P3+P4+P5+P6+P7,
                        minimize(labeling([P1,P2,P3,P4,P5,P6,P7]),MENORCUSTO).
                        /*X = [4, 1, 5, 7, 3, 2, 6]
                         Yes (0.00s cpu) */

INCOMPLETO





exerc5:-
        findall(LD, build(LD),L),
        writeln(L),
        length(L, Len),
        writeln(len - Len).


%%% ....

build(LD) :-
        length(Ss, 7),
        Ds = [6,8,4,4,4,12,14,6,8,16,2,12],
        Ss :: 1..50,

        Rs = [2,3,3,4,2,3,1,4,2,1,1,3],
        End :: 1..70,

        LD = [TAI, TAF, TBI, TBF, TCI, TCF, TDI, TDF, TEI, TEF, TFI, TFF, TGI, TGF, THI, THF, TII, TIF, TJI, TJF, TKI, TKF, TLI, TLF],
        LD :: 0..70,

	TAI #>= 0,
	TBI #>= 0,
	TCI #>= 0,
	TAF #>= TAI + 6,
	TBF #>= TBI + 8,
	TCF #>= TCI + 4,
	TDI #>= TAF,
	TDF #>= TDI + 4,
	TEI #>= TAF,
	TEF #>= TEI + 4,
	TFI #>= TBF,
	TFI #>= TEF,
	TFF #>= TFI + 12,
	TGI #>= TBF,
	TGI #>= TEF,
	TGF #>= TFI + 14,
	THI #>= TBF,
	THI #>= TCF,
	THI #>= TEF,
	THF #>= THI + 6,
	TII #>= TDF,
	TII #>= TFF,
	TIF #>= TII + 8,
	TJI #>= TDF,
	TJI #>= TFF,
	TJI #>= TGF,
	TJF #>= TJI + 16,
	TKI #>= TDF,
	TKI #>= TFF,
	TKI #>= TGF,
	TKF #>= TKI + 2,
	TLI #>= THF,
	TLI #>= TKF,
	TLF #>= TLI + 12,

        % writeln([tai-TAI, taf-TAF, tbi-TBI, tbf-TBF, tci-TCI, tcf-TCF, tdi-TDI, tdf-TDF, tei-TEI, tef-TEF, tfi-TFI, tff-TFF, tgi-TGI, tgf-TGF, thi-THI, thf-THF, tii-TII, tif-TIF, tji-TJI, tjf-TJF, tki-TKI, tkf-TKF, tli-TLI, tlf-TLF])

        after(Ss, Ds, End),
        cumulative(Ss, Ds, Rs, Capacity),
        append(Ss, [End], Vars),

        minimize(labeling(Vars),End).
