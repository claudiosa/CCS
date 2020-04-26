
s_X([], _, S, _, S ):-  
   writeln('s_X.....paradaOK' :S) ,!.

s_X([X| L_x], L_y, L1, L_Geometry, S1 ) :-
    %%% cada X vai iterar sobre L_Y
    
    s_Y( X , L_y, L1, L_Geometry, S2 ),
    s_X( L_x, L_y, S2, L_Geometry, S3 ).

%%% one X in  Y List -- an interaction

%% Halting
%s_Y( X, [], S, L_Geometry, S ):- !.
s_Y( _ , [], S , _,  S ):- !.
    %writeln('s_Y.....paradaOK' :S) ,!.

s_Y( X, [Y | L_y ] , L1, L_Geometry, S1 ) :-
    
    /**************** COLLISION CONDITION HERE *****/
    member( (X,Y), L_Geometry),
    %%% added in solution
    s_Y(X, L_y, [(X,Y)| L1], L_Geometry, S2 )
    , !.   %%% DO NOT FORGET ....  THERE IS ANOTHER CLAUSE TO TRY

%%% fail last call -- 
s_Y( X, [Y | L_y ] , L1, L_Geometry, S2 ) :-
    
    /************** NOT COLLISION CONDITION HERE *****/
    not(member( (X,Y), L_Geometry) ),
    %%% added in solution
    s_Y(X, L_y,  L1, L_Geometry, S2 ).
