%%%%%%%%%%%%%%%%%%%%% TRAIN PROBLEM %%%%%%%%%%%%%%%%%%%%%%%%

/*
num_left_trains -->                                                  <--num_right_trains
Station 1 =========== Station 2 ============ Station 3 ============= Station 4

ONLY ONE TRAIN is ALLOWED to OCCUPY the ONE RAIL during its trip between 2 stations
In the stations the others trains must wait for the rail liberation

rails number =  num_stations - 1

*/
include "globals.mzn";

%%%%%%%%%%%%%%%%%%%%% DECLARACAO DAS VARIAVEIS %%%%%%%%%%%%%%%%%%%%%
%% Station 1 =========== Station 2 ============ Station 3 ============= Station 4
/*
Description:
num_left_trains = 3; in Station 1
int: num_right_trains = 3; % Station 4
Objective:
Trains from left side must be reach the Station 4
Trains from right side must be reach the Station 1
Constraint:

The rail must occupied for one only train, independent of the sense
there is only ONE RAIL between stations

*/


%rails number =  num_stations - 1
int: num_stations = 4; % numero de estacoes  .... station number

int: ocupation_time = 15; % duracao de cada trem nos trilhos para cada trem
%% usage time on trail

int: min_station_time = 2; %% a minimal time for stop in intermediaries stations
int: period = 600;

% Trains left to right ... 
% X[i,j]: train i arrives in the  station j

int: num_left_trains = 3; % train's number in the left side
int: num_right_trains = 3; % train's number >>> right

int: num_trains = num_left_trains + num_right_trains;
int: K = num_left_trains;

%%% Definitions on left trains: X
array[1 .. num_trains, 1 .. num_stations] of var 0..period: T_arrival; 
array[1 .. num_trains, 1 .. num_stations] of var 0..period: T_departure; 

%% Overall time to arrive in theirs destination
 var int : cost;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Initializations 
constraint %% Trains LEFT --> RIGHT
  	forall( i in 1 .. K ) (
	       T_arrival[i, 1] == 0
         );
%%% Initializations
constraint %% Trains LEFT <-- RIGHT
  	forall( i in K+1 .. num_trains ) (
	       T_arrival[i, num_stations] == 0
         );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Trens com tempo crescente entre estacoes
constraint %% Trains LEFT --> RIGHT
	forall( j in 1.. (num_stations-1) ) (
  	forall( i in 1..K ) (
	       T_arrival[i,(j+1)] >= T_departure[i,j] + ocupation_time 
         )
        );

%%% ESTES ITERATORES FUNCIONAM BEM ... PARA CIMA ... ORDEM CRESCENTE
%% sentido contrario
constraint %% Trains LEFT <-- RIGHT
	forall(j in 1 .. (num_stations-1) ) (
  	forall(i in (K+1) .. num_trains) (
	       T_arrival[i,j] >= T_departure[i , (j+1)] + ocupation_time
         )
        );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% os trens da ESQUERDA NAO PODEM SAIR NO MESMO MOMENTO ENTRE PARTIDA ENTRE OS TRENS

constraint %% Trains LEFT <-- RIGHT
	forall(j in 1 .. (num_stations-1) ) (
  	forall(i in 1 .. (K-1)) (
	       T_departure[i,j] >= T_departure[(i+1),j] + ocupation_time 
         )
        );

%%% os trens da DIREITA NAO PODEM SAIR ou partir AO MESMO MOMENTO
constraint %% Trains LEFT <-- RIGHT
	forall(j in 2 .. num_stations ) (
  	forall(i in K+1 .. (num_trains-1)) (
	       T_departure[i,j] >= T_departure[(i+1),j] + ocupation_time 
         )
        );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% 
%%% Waiting time in station j from LEFT
constraint %% Trains RIGHT  -->  LEFT
	forall(j in 1 .. num_stations-1 ) (
  	forall(i in 1 .. K) (
	       T_departure[i,j] >= T_arrival[i,j] + min_station_time 
         )
        );

%%% Waiting time in station j ...
constraint %% Trains   LEFT <-- RIGHT
	forall(j in 2 .. num_stations ) (
  	forall(i in K+1 .. num_trains) (
	       T_departure[i,j] >= T_arrival[i,j] + min_station_time 
         )
        );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% THE TRICK IS HERE
constraint  %% Trains  LEFT  <-->  RIGHT
 forall(j in 1 .. (num_stations-1) ) (
   forall(i in 1 .. K, m in (K+1) .. num_trains) (
	   disjunctive([ T_departure[i , j], T_departure[m , j+1 ] ]
                 ,
                 [ocupation_time , ocupation_time]
               
      )
   )
) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% The end time for all trains
constraint
   cost = sum([ T_arrival[i,num_stations] | i in 1..K]) 
          + 
          sum([ T_arrival[i,1] | i in (K+1)..num_trains]);

%%%%%%%%%%%%%%%%%%%% SOLVER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%solve satisfy;
solve minimize cost;
%%%%%%%%%%%%%%%%%%%%%%%%%% SAIDA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

output 
   ["Meanings..... Train,Station" ++ ": Arrival and Departure Times"]
     ++
   ["\n >> Trains from LEFT Side: \n"]     ++
   [" "++show(i)++ "," ++ show(j) ++ ": " ++ show(fix(T_arrival[i,j]))
 ++" "++ show(T_departure[i,j]) ++ if j == num_stations then "\n" else "\t " endif  | i in 1..K, j in 1..num_stations]
      ++
   ["\n << Trains from RIGHT Side: \n"]     ++
   [" "++show(i)++ "," ++ show(j) ++ ": " ++ show(fix(T_departure[i,j]))
 ++" "++ show(T_arrival[i,j]) ++ if j == num_stations then "\n" else "\t " endif  | i in (K+1) .. num_trains, j in 1 .. num_stations]
   ++
  ["\n Sum of all arrivals time: " ++ show(cost)]   
   ;


%%%%%%%%%%%%%%%%%%%%%% output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
COM OTIMIZACAO

Meanings..... Train,Station: Arrival and Departure Times
 Trains from LEFT Side: 
 1,1: 0 66	  1,2: 81 94	  1,3: 109 111	  1,4: 126 0
 2,1: 0 17	  2,2: 32 79	  2,3: 94 96	  2,4: 111 0
 3,1: 0 2	  3,2: 17 49	  3,3: 64 66	  3,4: 81 0

 Trains from RIGHT Side: 
 4,1: 0 96	  4,2: 81 79	  4,3: 64 47	  4,4: 32 0
 5,1: 0 66	  5,2: 51 49	  5,3: 34 32	  5,4: 17 0
 6,1: 0 51	  6,2: 36 34	  6,3: 19 17	  6,4: 2 0
----------
==========
FAZER O DESENHO PARA CONFERIR O RESULTADO


SEM OTIMIZACAO

Meanings..... Train,Station: Arrival and Departure Times
 Trains from LEFT Side: 
 1,1: 0 81	  1,2: 96 98	  1,3: 113 115	  1,4: 130 0
 2,1: 0 17	  2,2: 32 79	  2,3: 94 96	  2,4: 111 0
 3,1: 0 2	  3,2: 17 64	  3,3: 79 81	  3,4: 96 0

 Trains from RIGHT Side: 
 4,1: 0 81	  4,2: 66 64	  4,3: 49 47	  4,4: 32 0
 5,1: 0 66	  5,2: 51 49	  5,3: 34 32	  5,4: 17 0
 6,1: 0 51	  6,2: 36 34	  6,3: 19 17	  6,4: 2 0
----------
Finished in 24msec

*/