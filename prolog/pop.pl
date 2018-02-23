%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%	This partial order planner is adapted form Shoham's book.
%	Artificial Intelligence Techniques in Prolog
%     
%     In particular the cost considerations are ommitted.
%
%  This is very innefficent. You are advised not to use it.
%

%    Symbol Table is a list of (Name, Op) pairs. So the steps of the plan.
%    Safety is the list of order constraints
%    CausalLinks the list of Causal Links
%    


non_lin_plan(SymbolTable, Safety, CausalLinks) :-
	find_completion([(start, begin), (finish, end)], [(start, finish)], [],
	SymbolTable, Safety, CausalLinks).

find_completion(SymbolTable, Safety, CausalLinks, NewSymbols, NewSafety, NewCausals) :-
	order_consistent(Safety),
	( complete(SymbolTable, Safety, CausalLinks),
        NewSymbols = SymbolTable,
	  NewSafety = Safety,
        Newcausals = CausalLinks
       ;
        (member((S,P,W), CausalLinks),
         step_threat(SymbolTable, V,S,P,W),
         not member((V,S), Safety),
         not member((W,V), Safety),
         (TmpSafety = [(V,S) |Safety] ; TmpSafety = [(W,V) | Safety]),
	 find_completion(SymbolTable, TmpSafety, CausalLinks,
                      NewSymbols, NewSafety, NewCausals))
       ;
        (prec_unsatisfied(SymbolTable, CasualLinks, W,P),
          (step_adds(SymbolTable, S, P),
           TmpSymbols = SymbolTable,
           member((S,O), SymbolTable)
          ;
           adds(O,P), O \== begin,
           make_step_op(SymbolTable, O,S, TmpSymbols)),
        (member((S,W), Safety), TmpSafety = Safety 
          ; TmpSafety = [(S,W) |Safety]),
        find_completion(TmpSymbols, TmpSafety, [(S,P,W) |CausalLinks],
        NewSymbols, NewSafety, NewCausals).

step_threat(SymbolTable, V,S, P, W) :-
	(step_adds(SymbolTable, V, P),
       ; step_dels(SymbolTable, V,P)),
      V \==S, V \== W.


step_adds(SymbolTable, Name, P) :-
	step_op(SymbolTable, Name, Op), adds(Op, P).

step_dels((SymbolTable, Name, P) :-
	step_op(SymbolTable, Name, Op), dels(Op, P).

step_op(SymbolTable, Name, Op) :-
	member((Name, Op), SymbolTable).

prec_unsatisfied(SymbolTable, CasualLinks, Name, Prec) :-
	member((Name, Op), SymbolTable),
	prec(Op, Prec),
      not member((_,Prec, Name), CausalLinks).

make_step_op(SymbolTable, Op, Step, [(Step, Op) | SymbolTable]) :-
	max_step(SymbolTable, Max),
	Step is Max + 1.

max_step([], 0).
max_step([(StepName, _) | Symbols], Max) :-
	max_step(Symbols, TailMax),
	(StepName = start, Max = TailMax
       ; StepName = finish, Max = TailMax
       ; TailMax > StepName , Max = TailMax
       ; Max = StepName), !.

order_consistent(Safety) :-
	not member((_, start), Safety),
      not member((finish, _), Safety),
      acyclic(Safety).

acyclic(Arcs) :-  not  has_cycle(Arcs), !.

has_cycle(Arcs) :-
	member((X,Y), Arcs),
	(member((Y,X), Arcs) ;
       path(Y,X, Arcs, [])).

path(A,A, _, _).
path(A,B, G, Used) :-
	member(A, C, G),
      not member(C, Used),
      path(C, B, G, [C|Used]).

complete(SymbolTable, Safety, CausalLinks) :-
	all_prereq_satisfied(SymbolTable, CausalLinks),
	all_threats_defused(SymbolTable, Safety, CausalLinks).

all_prereq_satisfied([], _).
all_prereq_satisfied([(Name, Op) |SymbolTable], CausalLinks) :-
	preclist(Op, PreConds),
	not(( member(Prec, OpPrec), not(member((_,Prec, Name), CausalLinks)))),
      all_prereq_satisfied(SymbolTable, CausalLinks).

all_threats_defused(_,_,[]).
all_threats_defused(SymbolTable, Safety, {(S,P,W) |CausalLinks]) :-
	findall(V, step_threat(SymbolTable, V,S,P,W), Threats),
      these_threats_defused(Threats, S,W,Safety),
	all_threats_defused(SymbolTable, Safety, CausalLinks).


 these_threats_defused([],_,_,_). 
these_threats_defused([Threat|Threats], S,W,Safety) :-
	(member((Threat,S), Safety) ; member((W, Threat), Safety))
     these_threats_defused(Threats, S,W,Safety).



       
	


 

         
	



