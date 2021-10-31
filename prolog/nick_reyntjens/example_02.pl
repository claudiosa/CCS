%%% circumcription logic (world closed)
% default logic
% propositional and first order
/*
Nick Reyntjens <nick.reyntjens@gmail.com>
*/
trick_for_dynamics([node/1, r/2, i/2, p/2,s/2 ]).
:- trick_for_dynamics(L), dynamic(L).
%:-dynamic ([node/1, r/2, i/2, p/2,s/2 ]).
:- discontiguous([node/1, r/2, i/2, p/2,s/2 ]).

list_all_nodes :-
  findall(X, node(X), Bag),
  length(Bag, N_nodes),
  format("\n Number of Nodes: ~w", N_nodes),
  format("\n All nodes: ~w", [Bag]),
  w_l(Bag, 1).
  


%%% Nodes as facts --- but I think that should Dynamic
node(0).
node(1).
node(2).
node(3).
node(4).
node(5).


%%% Immediate Relatations
%% 
%% there's relation r(A,B) means A -> B, A to B
r(3,1). 
%% Equal to inverse? 
i(5,2).

%% there's path p(A,B) means A -> B, A to B ???
p(1, 0).
p(2, 0).
p(4, 2).
p(3, 2).
p(5, 0).


%%% means X -> Y or Y -> X ... there's an immediate connection
% inverse relationships
node(r(X,Y)) :- r(X,Y).
p(r(X,Y), Z) :- Z = Y, none_VAR(X,Y,Z).
s(r(X,Y), Z) :- Z = X, none_VAR(X,Y,Z).

% inheritence relationships
node(i(X,Y,Z)) :- i(X,Y), p(Z,Y), 
  none_VAR(X,Y,Z).
%%%node(i(_,_,_)) :- !.

p(i(X,Y,Z), U) :- U = X, none_VAR(X,Y,Z).
s(i(X,Y,Z), U) :- U = Z, none_VAR(X,Y,Z).
% specializatoin is inheritence
i(X,Y) :- s(X,Y).

%%%% Meaning: X, Y and ... MUST BE INSTANCED
none_VAR(X,Y,Z) :- 
  nonvar(X),
  nonvar(Y),
  nonvar(Z), !.
%%%% to be evalueted in the future
none_VAR(_,_,_) :- fail.

%i(X,Y) :- p(X,Y).
%i(X,Y) :- p(X,Z), i(Z,Y).

%%% PRINTING A LISTING STARTING FROM X ...  
w_l([],_) :- !.
w_l([A|B], X) :-
  format("\n Node ~w : ~w", [X,A]),
  X1 is (X+1),
  w_l(B, X1). 



/********* FOR THE FUTURE >>>>> */
%% removing a predicate -- facts tested
del_a_predicate(Name/Arity) :-  
  functor(Template, Name, Arity) , 
  retractall(Template) , 
  fail.
del_a_predicate(_) .  /* A grounding term */

%% removing all facts dynamics
del_ALL_dynamics:-
  trick_for_dynamics(L), %%% TRICK meanwhile
  maplist(del_a_predicate, L),
  format("\n A dynamic predicates were removed sucessfully!!!").
  
/*

        current_predicate(Functor/Arity),
        functor(Template, Functor, Arity),
        predicate_property(Template, (dynamic)),


%% works for rules ....
retractall(Head) :-
  retract((Head :- _)),
  fail.                  % failure-driven loop to retract the whole shebang
retractall(_).            % "make this a success" catchall
*/
/*
retract_all_facts :- 
    member(Pred/Arity , 
      [
        predicate/1 , 
        predicate/2,
         predicate/3  
      ]) , 
    functor(Template, Pred, Arity) , 
    retractall(Template) , 
    fail.
  
  retract_all_facts :- 
    write("\n Success"),   
    !.
  */
