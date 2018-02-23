%%%%%%%%%%%%%%%%%%%%% TRAIN PROBLEM %%%%%%%%%%%%%%%%%%%%%%%%
include "globals.mzn";

%%%%%%%%%%%%%%%%%%%%% DECLARACAO DAS VARIAVEIS %%%%%%%%%%%%%%%%%%%%%
%% Station 1 =========== Station 2 ============ Station 3
/*
The rail must occupied for one only train, independent of the sense
there is only ONE RAIL between stations
*/

int: ocupation_time = 10; % duracao de cada trem nos trilhos para cada trem
%% usage time on trail

int: period = 100;

%
var 0..period: A0; 
var 0..period: A1; 
var 0..period: A2; 
var 0..period: B0; 
var 0..period: B1; 
var 0..period: B2; 

%% Overall time to arrive in theirs destination
var int : cost;

constraint
  A0 == 0 /\
  B0 == 15;

constraint
  A1 >= A0 + ocupation_time /\
  A2 >= A1 + ocupation_time ;
 

constraint
  B2 >= B1 + ocupation_time /\
  B1 >= B0 + ocupation_time ;
 

constraint  %% Trains  LEFT  <-->  RIGHT
   %%% Generalize esta ideia....
	 disjunctive([A0,B1] , [ocupation_time , ocupation_time]) 
   /\
   disjunctive([A1,B0] , [ocupation_time , ocupation_time]) 
 ; 

%% The end  time for all trains
constraint
   cost = A2 +  B2 ;

/*

train([A0,A1,A2,B0,B1,B2]) :-
    [A0,A1,A2,B0,B1,B2] :: 0..100,%A0: saida do trem A da estacao 0
    D  #= 10,    % duracao da viagem por cada seccao
    B0 #= 15,    % forcar a saida do trem B da estacao 0 para 15
    
    A1 #>= A0 + D,
    A2 #>= A1 + D,
    B1 #>= B0 + D,
    B2 #>= B1 + D,
    
    disjunctive([A0,B1], [D,D]),   % trilho 1
    disjunctive([A1,B0], [D,D]),   % trilho 2
    
    Cost #= A2 + B2, %A2 e B2 = tempo de chegada na ultima estacao

    minimize(labeling([A0,A1,A2,B0,B1,B2]), Cost).
*/  


%%%%%%%%%%%%%%%%%%%% SOLVER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%solve satisfy;
solve minimize cost;
%%%%%%%%%%%%%%%%%%%%%%%%%% SAIDA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

output 
   ["Meanings..... Station" ++ ": Arrival and Departure Times"]
     ++
   ["\n Trains from LEFT Side: \n"]     ++
   [" "++show(A0)++ " >>>> " ++ show(A1) ++ " >>>> " ++ show(A2)]
     ++
   ["\n Trains from RIGHT Side: \n"]     ++
   [" "++show(B0)++ " >>>> " ++ show(B1) ++ " >>>> " ++ show(B2)] 
     ++
   ["\n COST: " ++ show(cost)]     
   ;


%%%%%%%%%%%%%%%%%%%%%% output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
Meanings..... Station: Arrival and Departure Times
 Trains from LEFT Side: 
 0 >>>> 25 >>>> 35
 Trains from RIGHT Side: 
 15 >>>> 25 >>>> 35
 COST: 70
----------
==========
*/