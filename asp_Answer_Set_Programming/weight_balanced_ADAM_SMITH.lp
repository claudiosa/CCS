#script (python)
def multiset(*terms):
  """Convert the variable argument list into a list of tuples (index,value)"""
  result = []
  for i, term in enumerate(terms):
    result.append((i+1, term))
  return result
#end.

%% Problem instance

%item_weight(I,W) :- (I,W) = @multiset(5,3,4,6,8,-99,9,9,9,9).
item_weight(I,W) :- (I,W) = @multiset( 9, 99, 9 ).
%% Problem encoding

item(I) :- item_weight(I,W).
bounds(N/2,(N+1)/2) :- N = {item(I)}.
partition(a;b).

% Every item goes into one of the partitions.
1 { assign(I,P):partition(P) } 1 :- item(I).

% The partitions need to be sized properly.
:- partition(P), bounds(Lo,Hi), not Lo { assign(I,P) } Hi.

% Which partition is heavier?
heavier(P) :-
  partition(P),
  partition(Q),
  P != Q,
  #sum { W,I,P:assign(I,P),item_weight(I,W);
        -W,I,Q:assign(I,Q),item_weight(I,W) } > 0.

% Minimize the total weight of the heavier partition (if there even is one)
#minimize { W,I,P:heavier(P),assign(I,P),item_weight(I,W) }.

% Solution for easy parsing
sol(P,I,W) :- assign(I,P), item_weight(I,W).

#show heavier/1.
#show sol/3.
