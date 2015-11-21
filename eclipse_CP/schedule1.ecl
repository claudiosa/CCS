
:- lib(ic).
:- lib(ic_cumulative).
:- lib(branch_and_bound).
:- lib(lists).

schedule(Ss, End,Capacity) :-
        length(Ss, 7),
        Ds = [16, 6,13, 7, 5,18, 4],
        Ss :: 1..30,

        Rs = [ 2, 9, 3, 7,10, 1,11],
        End :: 1..50,

        after(Ss, Ds, End),
        cumulative(Ss, Ds, Rs, Capacity),
        %% APENAS INCLUI a VARIAVEL End no SEARCH
        append(Ss, [End], L_Vars),
       
        minimize(labeling(L_Vars), End).

after([], [], _).
after([S|Ss], [D|Ds], E) :- E #>= S+D, 
                            after(Ss, Ds, E).


go :- 
        Capacity is 13,
        schedule(Ss, End, Capacity),
        write(capacity: Capacity),nl,
        write([Ss, End]),
        nl.
        
/******************************************************/
