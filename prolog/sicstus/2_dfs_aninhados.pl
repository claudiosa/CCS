    %%% Iterar a lista L_x sobre L_Y
    %%s_X(L_x , L_y, ElementsCrash_INIT, L_Geometry, ElementsCrash ).    
    %% NAO ESTA OK
    %%%
tx:- s_X([1,3], [5,7], [],    [(1,3), (1,5), (2,6),(3,7), (10,20), (5,10)],Sol), 
     writeln('..........sol' :Sol).

ty1:- 
    Init = [], 
    s_Y(1, [3,20], Init,  [(1,3), (3,7), (2,6),(3,5), (1,20), (1,10)], Sol), 
    writeln('..........sol' :Sol).


ty3:- 
    Init = [], 
    s_Y(3, [5,7], Init,  [(3,3), (3,7), (2,6),(3,5), (3,20), (5,10)], Sol), 
    writeln('..........sol' :Sol).
%% Halting condition for Axis X

%s_X([], L_y, S, L_Geometry, S ):- !.
s_X([], _, S, _, S ):-  
     
    writeln('s_X.....paradaOK' :S) ,!.
 
 s_X([X | L_x], L_y, L1, L_Geometry, S3 ) :-
     %%% cada X vai iterar sobre L_Y
    s_Y( X , L_y, L1, L_Geometry, S2 ),
    append(L1, S2, L1_NEW),
    s_X( L_x, L_y, L1_NEW, L_Geometry, S4 ).
 
 %%% one single X in  Y List -- an interaction
 %s_Y( X, [], S, L_Geometry, S ):- !.
 s_Y( _ , [], S , _,  S1 ):- 
    append(S, [], S1),
    % trace,
    writeln('s_Y.....parada_OK' :S1 ) , !.
 
s_Y( X, [Y | L_y ] , L1, L_Geometry, S1 ) :-
    
    member( (X,Y), L_Geometry),

    s_Y(X, L_y, [(X,Y)| L1], L_Geometry, S2 ),
    !. 
 
s_Y( X, [Y | L_y ] , L1, L_Geometry, S2 ) :-
    not(member( (X,Y), L_Geometry) ),
     %avanca em L_y
    s_Y(X, L_y,  L1, L_Geometry, S3 ).
 