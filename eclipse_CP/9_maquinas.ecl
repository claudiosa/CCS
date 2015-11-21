:- lib(ic).

top([O1,O2,O3]) :-

    [O1,O2,O3] :: 1..5,
    [K1,K2,K3] :: 1..10,
    alldifferent([O1,O2,O3]),
    
    element(O1, [  1, 11,  5,  7, 13], K1),
    element(O2, [  4,  6,  2,  8, 10], K2),
    element(O3, [  6,  3,  9, 12, 15], K3),
    
    K1+K2+K3 #=< 10,
    
    labeling([K1, K2, K3]).
