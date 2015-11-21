

concatena([],L,L).
concatena([A|As],B,[A|Cs]) :- concatena(As,B,Cs).

distribui([],E,[]) :- !.
distribui([(A,B)|Ps],E,[(A,B,E)|Ts]) :-
distribui(Ps,E,Ts).

combina(ListaPares,[],[]) :- !.
combina(ListaPares,[E|Es],Resp) :-
      distribui(ListaPares,E,ListaTriplas),
      combina(ListaPares,Es,RespEs),
      concatena(ListaTriplas,RespEs,Resp). 


/* marcelo da FACOM.ufu */
combina3(ListaPares,Elementos,Resp) :-
mapeia(Elementos,ListaPares,ListaPares,Resp).


mapeia([],M,_,[]) :-!.
mapeia([A|As],M,[],Ac) :-
     mapeia(As,M,M,Ac).
mapeia([A|As],M,[(C1,C2)|Bs],[(C1,C2,A)|Ac]) :-
     mapeia([A|As],M,Bs,Ac). 

merge([],L,L).  
merge([H|T],L,[H|M]) :- merge(T,L,M).

% The first clause states that merging the empty list onto a list has no effect.
% The second clause says, the result of merging a list of the form [H|T] onto
% a list L is of the form [H|M] where M is the result of (recursively) merging
% T onto L.

% finding the smallest number in a list of numbers:  
% Want: "min(X,L)" if and only if X is the smallest number in list L:
min([X],X).    % the smallest number of a singleton list is the single element
min([A,B|T],M) :- (A < B), min([A|T],M).
min([A,B|T],M) :- (B =< A), min([B|T],M).

% reversing a list:
% Want: "reverse(A,B)" iff A is the reverse of list B.
reverse([],[]).
reverse([H|T],L) :- reverse(T,S), merge(S,[H],L).

% Deleting all occurance of an element from a list:
% Want: "delete(X,L,M)" iff M is L with all occurences of X removed:
delete(X,[],[]).
delete(X,[X|T],R) :- delete(X,T,R).
delete(X,[H|T],[H|R]) :- not(X = H), delete(X,T,R).

% Removing duplicates
% Want "remdups(L,M)" iff M is L with all duplicate elements removed - e.g,
% remdups([3,4,3,5],X) will return true with X = [3,4,5]:

remdups([],[]).
remdups([H|T],[H|R]) :- delete(H,T,S), remdups(S,R).



combine([],[],Old,New) :-
        New = Old.
combine([Head | Tail],[Head2 | Tail2],Old,New):-
        New1 = [[Head,Head2] | Old],
        combine(Tail,Tail2,New1,New).

