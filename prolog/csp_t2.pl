% Computational Intelligence: a logical approach. 
% Prolog Code. 
% The scheduling problem from Example 4.21 and Figure 4.9
% Copyright (c) 1998, Poole, Mackworth, Goebel and Oxford University Press.

% This is the example after it has been made domain consistent
schedule(A,B,C,D,E) :-
    csp([dom(A,[1,2,3,4]),
         dom(B,[1,2,4]),
         dom(C,[1,3,4]),
         dom(D,[1,2,3,4]),
         dom(E,[1,2,3,4])],
        [rel([A,B], A =\= B),
         rel([B,C], B =\= C),
         rel([C,D], C < D),         
         rel([B,D], B =\= D),
         rel([A,D], A =:= D),
         rel([A,E], A > E),
         rel([B,E], B > E),
         rel([C,E], C > E),
         rel([D,E], D > E)]).

% | ?- schedule(A,B,C,D,E).
