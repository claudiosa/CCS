
:-   lib(ic).

go  :-
	cputime(T1),  
	%write(T1), nl,
	statistics(event_time, Tcpu1),
    %writeln( tcpu1: Tcpu1),
	mapa,
	cputime(T2), 
	%write(T2), nl,
	statistics(event_time, Tcpu2), 
	% writeln( tcpu2: Tcpu2),
	T is (T2 - T1),
	Tstatistics is (Tcpu2 - Tcpu1),
	writeln( tudo_Gastou: T  ;  segundos),
	writeln( via_statistics: Tstatistics ; segundos).

%    fail.
% go. 

mapa :-
      mapa_model(ESTADOS),
      writeln( cores-dos-estados : ESTADOS ).

mapa_model(ESTADOS) :-
    %%Identificar um DOMINIO ... cores = [ 1, 2, 3, 4 ],
    %% Declarando VARIAVEIS do problema ....
    [ RS, SC, PR, SP, MS ]  :: 1 .. 4, %% algo de 1 a 4 

    %%%%  AS RESTRICOES ... estruturas chaves do problema
    %%% DECLARANDO O PROBLEMA
    
     get_domain(SC,Dsc),
     writeln( domSC1 : Dsc),
    RS  #\= SC    , 
    SC  #\= PR    ,
       % pegar varios estados e testar ...
     % ....
    PR  #\= SP,
    PR  #\= MS,
    SP  #\= MS,
      get_domain(SC,Dsc),
     writeln( domSC2 : Dsc),
 
    ESTADOS = [ RS, SC, PR, SP, MS ] ,
    search( ESTADOS , 0, first_fail, indomain_max, complete, []).
   

