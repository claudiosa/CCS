/*
Mulheres:         a,b,c,d,e   1,2,3,4,5
Homens:           f,g,h,i,j   6,7,8,9,10 
Estudantes:       a,b,c,j     1,2,3,10
Servidores:       e,f         5,6 
Professores:      d,g,h,i     4,7,8,9
*/


:- lib(ic).
:- lib(branch_and_bound).
:- lib(lists).

go :-   modelo(L),
        write(uma_solucao_com: L).
              

y :- findall(X, modelo(X), L), 
     nl, 
     write(L).


modelo(L):- 
	
    Comp :: 1..5,
	X1 :: 1..5,
	X2 :: 6..10,
	X3 :: [1,2,3,10],
	X4 :: 5..6,
	X5 :: [4,7,8,9],
		
	nl, get_domain(X4, Dx4), write(dx4: Dx4),
    nl, get_domain(X5, Dx5), write(dx5: Dx5),
    
    remove_dupl([X1,X2,X3,X4,X5], L),
    alldifferent(L),
    length(L,Comp),
    %%%%% bb_min(length(L,Comp), L, 0).
    Comp  #= FUNCAO_CUSTO,
    minimize(labeling(L), FUNCAO_CUSTO).
    
   
   %% minimize(labeling(L),Comp).
    
    %
    % Comp #=< 3.
    % bb_min(member(X,[9,6,8,4,7,2,4,7]), X, O)
    % bb_min(length(L,Comp), L, bb_options with [strategy:dichotomic, from:0]).
    
 remove_dupl([], []).
 remove_dupl([X|L1], L2) :- member(X,L1), remove_dupl(L1, L2).
 remove_dupl([X|L1], [X|L2]) :-  remove_dupl(L1, L2). 



