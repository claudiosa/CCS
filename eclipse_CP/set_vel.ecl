



:-lib(fd).  
:-lib(fd_sets).
%%:-lib(branch_and_bound).


%% data
veloc(1,[61,66,63,69]).
veloc(4,[12,122,18,1,9,7]).

go :-
     veloc(1,L1), model(L1). 
     %%veloc(4,L4), model(L4).
           
model(L) :-      
      length(L,N), writeln( n: N), writeln( l: L),
      sort(L, Dominio),
      writeln( dom: Dominio),

      find_2_others(N, N1, N2),
     
      writeln( n1: N1) , 
      writeln( n2: N2) , 
      Weights = [](1, 1),

       fd_sets:(L1 :: [] .. Dominio),
       fd_sets:(L2 :: [] .. Dominio),
       fd_sets:(L3 :: [] .. Dominio),
       
	 #(L1, N1),
	 #(L2, N2),
     #(L3, N),

%%%%  HOW TO WORKs?
%%%%  weight(L1, Weights, W),).

     %% I need for THESE TWO CONSTRAINTS
     %%sum(L) #= (sum(L1) + sum(L2)),
     %%fd_sets:(Diff #= abs( sum(L1) - sum(L2) )),

     fd_sets:(union(L1, L2, L3)),

     label_sets([L1, L2]),
     
     write('Solutions: ........'), nl,
     writeln( solL1: L1) , 
     writeln( solL2: L2).
     
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
label_sets([]).
	label_sets([S|Ss]) :-
	insetdomain(S,_,_,_),
	%%%Instantiate Set to a possible value
	label_sets(Ss).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 find_2_others(N,N1,N2):-
     Int is (N // 2),
     Rem is rem(N,2),
     N1 is Int,
     N2 is (Int + Rem).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
