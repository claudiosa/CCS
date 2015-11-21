% Computational Intelligence: a logical approach. 
% Prolog Code. 
% A CSP solver using arc consistency (Figure 4.8)
% Copyright (c) 1998, Poole, Mackworth, Goebel and Oxford University Press.
                                    
% csp(Domains, Relations) means that each variable has
% an instantiation to one of the values in its Domain 
% such that all the Relations are satisfied.
% Domains represented as list of 
% [dom(V,[c1,...,cn]),...]
% Relations represented as [rel([X,Y],r(X,Y)),...]
%  for some r
csp(Doms,Relns) :-
   ac(Doms,Relns).

% ac(Dom,Relns) is true if the domain constrants
% specified in Dom and the binary relations
% constraints specified in Relns are satisfied.
ac(Doms,Relns) :-
   make_arcs(Relns,A),
   consistent(Doms,[],A,A).

% make_arcs(Relns, Arcs) makes arcs Arcs corresponding to
% relations Relns. There are acrs for each ordering of
% variables in a relations.
make_arcs([],[]).
make_arcs([rel([X,Y],R)|O],
          [rel([X,Y],R),rel([Y,X],R)|OA]) :-
   make_arcs(O,OA).

% consistent(Doms,CA,TDA,A) is true if
% Doms is a set of domains
% CA is a set of consistent arcs,
% TDA is a list of arcs to do
% A is a list of all arcs
consistent(Doms,CA,TDA,A) :-
   consider(Doms,RedDoms,CA,TDA),
   solutions(RedDoms,A).            

% consider(D0,D1,CA,TDA)
% D0 is the set of inital domains
% D1 is the set of reduced domains
% CA = consistent arcs, 
% TDA = to do arcs
consider(D,D,_,[]).
consider(D0,D3,CA,[rel([X,Y],R)|TDA]) :-
   choose(dom(XV,DX),D0,D1),X==XV,
   choose(dom(YV,DY),D1,_),Y==YV, !,
   prune(X,DX,Y,DY,R,NDX),
   ( NDX = DX
   ->
     consider(D0,D3,[rel([X,Y],R)|CA],TDA)
   ; acc_todo(X,Y,CA,CA1,TDA,TDA1),
     consider([dom(X,NDX)|D1],D3,
              [rel([X,Y],R)|CA1],TDA1)).

% prune(X,DX,Y,DY,R,NDX)
% variable X had domain DX
% variable Y has domain DY
% R is a relation on X and Y
% NDX = {X in DX | exists Y such that R(X,Y) is true}
prune(_,[],_,_,_,[]).
prune(X,[V|XD],Y,YD,R,XD1):-
   \+ (X=V,member(Y,YD),R),!,
   prune(X,XD,Y,YD,R,XD1).
prune(X,[V|XD],Y,YD,R,[V|XD1]):-
   prune(X,XD,Y,YD,R,XD1).

% acc_todo(X,Y,CA,CA1,TDA,TDA1)
% given variables X and Y,
% updates consistent arcs from CA to CA1 and
% to do arcs from TDA to TDA1
acc_todo(_,_,[],[],TDA,TDA).        
acc_todo(X,Y,[rel([U,V],R)|CA0],
         [rel([U,V],R)|CA1],TDA0,TDA1) :-
   ( X \== V
   ; X == V,
     Y == U),   
   acc_todo(X,Y,CA0,CA1,TDA0,TDA1).
acc_todo(X,Y,[rel([U,V],R)|CA0],
         CA1,TDA0,[rel([U,V],R)|TDA1]) :-
   X == V,
   Y \== U,
   acc_todo(X,Y,CA0,CA1,TDA0,TDA1).

% solutions(Doms,Arcs) given a reduced set of
% domains, Dome, and arcs Arcs, solves the CSP.
solutions(Doms,_) :-
   solve_singletons(Doms).
solutions(Doms,A) :-
   select(dom(X,[XV1,XV2|XVs]),Doms,ODoms),
   split([XV1,XV2|XVs],DX1,DX2),
   acc_todo(X,_,A,CA,[],TDA),
   ( consistent([dom(X,DX1)|ODoms],CA,TDA,A)
   ; consistent([dom(X,DX2)|ODoms],CA,TDA,A)).

% solve_singletons(Doms) is true if Doms is a
% set of singletom domains, with the variables
% assigned to the unique values in the domain
solve_singletons([]).
solve_singletons([dom(X,[X])|Doms]) :-
   solve_singletons(Doms).

% select(E,L,L1) selects the first element of
% L that matches E, with L1 being the remaining
% elements.
select(D,Doms,ODoms) :-
   remove(D,Doms,ODoms), !.

% choose(E,L,L1) chooses an element of
% L that matches E, with L1 being the remaining
% elements.
choose(D,Doms,ODoms) :-
   remove(D,Doms,ODoms).

% split(L,L1,L2) splits list L into two lists L1 and L2
% with the about same number of elements in each list.
split([],[],[]).
split([A],[A],[]).
split([A,B|R],[A|R1],[B|R2]) :-
   split(R,R1,R2).
