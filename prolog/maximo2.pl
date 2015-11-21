%max( [] ,0) :- !.
%max( [f_r(a,M/b)] , M ) :- !.
%max( [ f_r(a,M/b) , f_r(c,O/d) ] , M ) :- M >= O , !.
%max( [ f_r(a,M/b)|f_r(z,R/e)] , T ) :- max( [f_r(z,R/e) , f_r(c,O/d)] ) , max( [f_r(c,O/d) , f_r(a,M/N)] , T).
