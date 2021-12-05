
%% INSPIRED in ADAM SMITH IDEAS -- getting Python functions in ASP
#script (python)
def my_size(*terms):
    i=0
    for term in enumerate(terms):
       i+=1
    return i
#end.
%%% for enumerate: https://www.geeksforgeeks.org/enumerate-in-python/

#script (python)
def multiset( *terms ):
  """Convert the variable argument list into a list of tuples (index,value)"""
  result = []
  for i , term in enumerate(terms):
    """ List of Pairs """
    result.append( (i+1, term) )
  return result
#end.
%% Problem instance

%%% using these Python's functions in ASP
weights(I,W) :- (I,W) = @multiset( 23, 45, -34, 12, 0, 98, -99, 4, 189, -1, 4 ).
size(S) :- S = @my_size(1,2,3,4,9999999999).
%% Problem encoding

#show weights/2.
#show size/1.
%%% Attention, as output these values are missing the "." at the end.