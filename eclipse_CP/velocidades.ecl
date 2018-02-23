/*
https://www.ads.tuwien.ac.at/w/SS11/186811_Modeling_and_Solving_Constrained_Optimization_Problems_VU_2.0
http://www-module.cs.york.ac.uk/cop/

Yes (0.00s cpu)
?- suspend(writeln(woken(X)), 0, X->inst).
X = X
There is 1 delayed goal.
?- suspend(writeln(woken(X)), 0, X->inst), X is 3.
X = 3
Yes (0.00s cpu)
report_binding(X) :-
( var(X) ->
suspend(report_binding(X), 0, X->inst)
;
printf("Variable has been bound to %w\n", [X])
).


*/
%%%:-lib(ic).
:-lib(branch_and_bound).
:-lib(fd).  %%% tem um sort
%:-lib(ic_global).
%%:-lib(ic_search).
%%:-lib(listut).
-lib(propia).
:-lib(suspend).

veloc(1,[61,66,63,69]).
veloc(2,[70, 60, 80, 45, 75,90, 71]).
veloc(3,[90, 101,102,150, 80,70,86]).
veloc(4,[102,122,108,100,93,71]).
go :-
	 
     veloc(1,L1), modelo(L1),
     veloc(2,L2), modelo(L2).
     veloc(3,L3), modelo(L3),
     veloc(4,L4), modelo(L4)
     
     . 
      %%% odd numbers in the list
      
modelo(L) :-      
      length(L,N), writeln( n: N), writeln( l: L),
      %%sorted_list_to_dom(L, Dominio),
      sort(L, Dominio),
      %%%Dominio = L,
      writeln( dom: Dominio),
      %%sorted_list_to_dom(+List, -Dom)
     
      %%%%get_domain_as_list(Dominiox,Dom=inio),
      
      find_2_others(N, N1, N2),
      length(L1, N1)   , length(L2, N2),
      length(L3,N), %% criou N termos
      writeln( n1: N1) , writeln(l1: L1),
	  writeln( n2: N2) , writeln(l2: L2),
     % L1 #:: [59,60,100], %%% equivalente....
     % L2 #:: [59,60,100],
      write('xxxxxxxx'),
     % L1 :: Dominio,
     % L2 :: Dominio,
      L3 :: Dominio,
    
    %  member(X, [1, 2, 3]) infers most
	 member(L1, Dominio) infers most, 
	 member(L2, Dominio) infers most, 
     sum(L) #= (sum(L1) + sum(L2)),
     Diff #= abs( sum(L1) - sum(L2) ),
       
     % get_domain_as_list(L1,D1),
     % get_domain_as_list(L2,D2),
     %L1 #\= L2, 


  /*  
     sort(L, Sorted),
     suspend(append( L1, L2, L3 ),  1  , [L1, L2]->inst),
	 suspend(suspend(sort(L3, L3_Sorted),2, L3 ->inst),
	 suspend(Sorted #= L3_Sorted,3, L3_Sorted ->inst),
	         
     suspend : (
		append( L1, L2, L3 ),         
		sort(L3, L3_Sorted),
		Sorted #= L3_Sorted
		), 
     
         (N1 == N2 ->
	  (	foreach(E1, L1), %%% param(L1,L2) do
		 foreach(E2, L2)
		  do
			write("."),
			E1 #\= E2
		),
     
      (foreach(E1, L1), param(L1)
		  do
			write("."),
			not(member(E1,L1))
		),
      */  
     
     
      %%union(L1,L2,L3), 
      flatten( [L1, L2], L3 ),  
      %append( L1, L2, L3 ),         
      %%%% term_variables([L1, L2],L3), %% sao equivalentes
      %%%equal(L3 , Dominio ), %% all terms must be contained
      
      %%%% transforma ... em termos 
      %%%term_variables([L1, L2],L3),
      minimize( labeling(L3), Diff ), %%% IT works
      %%minimize(search(L3, 0, first_fail, indomain_min, complete,[backtrack(Backtracks)]) , Diff),
      %%minimize(labeling([L1,L2]), Diff), %%% does not works
      S1 is sum(L1), write("  S1: "), write(S1), writeln( l1: L1), 
	  S2 is sum(L2), write("  S2: "), write(S2), writeln( l2: L2).
	  %%writeln( num_backtrackings:  Backtracks).
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 find_2_others(N,N1,N2):-
     Int is (N // 2),
     Rem is rem(N,2),
     N1 is Int,
     N2 is (Int + Rem).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
equal([],[]).
equal([A|B], L) :-
	member(A,L),
	delete(A, L, L2),
	equal(B , L2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
intersec([X|Y],M,[X|Z]) :- member(X,M), intersec(Y,M,Z).
intersec([X|Y],M,Z) :- \+ member(X,M), intersec(Y,M,Z).
intersec([],_,[]).
 
