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


int: num_left_trains = 3; % numero de trens .... train number
int: num_right_trains = 3; % numero de trens  .... train number
int: num_rails = 3; % numero de trilhos  .... rails number =  num_stations - 1
int: num_stations = 4; % numero de estacoes  .... station number

int: ocupation_time = 15; % duracao de cada trem nos trilhos para cada trem
%% usage time on trail

int: min_station_time = 5; %% a minimal time for stop in intermediaries stations
int: period = 3600;

% Trains left to right ... 
% X[i,j]: train i arrives in the  station j


%%% Definitions on left trains: X
array[1 .. num_left_trains, 1 .. num_stations ] of var 0..period: X; 
% X :  trains in the left side, arrival time in station j of train i = X[i,j]

array[1 .. num_left_trains, 1 .. num_stations ] of var 0..period: departure_left_time;
array[1 .. num_left_trains] of var 0..period: travel_left_time;

%%%% Variables of right side: Y
array[1 .. num_right_trains , 1 .. num_stations] of var 0..period: Y; % trains in the right side

array[1 .. num_right_trains, 1 .. num_stations ] of var 0..period: departure_right_time;
%%% on rail RIGHT ---> LEFT 
array[1 .. num_right_trains] of var 0..period: travel_right_time;



%% AUX variables ... to disappear in the future ....

array[1 .. (num_left_trains+num_right_trains), 1 .. num_stations ] of var 0..period : AUX;
array[1 .. (num_left_trains+num_right_trains), 1 .. num_stations ] of var 0..ocupation_time : AUX_VAR_2;

%% Overall time to arrive in theirs destination
 var int : cost;

% Sem sobreposição
/*
v_end_time[i] = v_origin[i] + v_duration[i]
*/

constraint %% Trains LEFT --> RIGHT
	forall(j in 2..num_stations) (
  	forall(i in 1..num_left_trains) (
	       X[i,j] > X[i,(j-1)] + ocupation_time + min_station_time
         )
        );


constraint %% Trains RIGHT  -->  LEFT
	forall(j in 2 .. num_stations ) (
  	forall(i in 1..num_right_trains) (
	       Y[i,(j-1)] > Y[i,j] + ocupation_time + min_station_time
         )
        );


%% TIME using the rail ... could be something variable
constraint
 forall(i in 1..num_left_trains) (
	       travel_left_time[i] == ocupation_time
       );


constraint
 forall(i in 1..num_right_trains) (
	       travel_right_time[i] == ocupation_time
       );


%%% Relation between departure and arrival times (X)
constraint %% Trains  LEFT  -->  RIGHT
forall(j in 2..num_stations) (
 forall(i in 1..num_left_trains) (
	        X[i,j] == departure_left_time[i,(j-1)] + travel_left_time[i]
          %% X i,j ... train i arrives in station j
         )
         );

constraint  %% Trains RIGHT  -->  LEFT
forall(j in  1 .. (num_stations-1)) (
 forall(i in 1..num_right_trains) (
	        Y[i,j] == departure_right_time[i,(j+1)] + travel_right_time[i]
          %% Y i,j ... train i arrives in station j
         )
         );

%%%% applying disjuntive due occpation rail
%%% USING array auxs ... TO avoid it in future ....
constraint  %% Trains  LEFT  <-->  RIGHT
forall(j in 1..(num_stations-1)) (
 forall(i in 1..num_left_trains) (
	 AUX[i,j] == departure_left_time[i,j]
   ))
   /\
 forall(j in 2 .. num_stations ) (
  forall(i in 1 .. num_right_trains) (
	 AUX[(i+num_left_trains),j] == departure_right_time[i,j] 
   )
   ); 

constraint  %% Trains  LEFT  <-->  RIGHT
forall(i in 1 .. (num_left_trains + num_right_trains)) (
  forall(j in 1 .. num_stations) (
   AUX_VAR_2[i , j] == ocupation_time
  )
  );


constraint  %% Trains  LEFT  <-->  RIGHT
%forall(i in 1 .. (num_left_trains+num_right_trains)) (
 forall(j in 1..num_stations) (
	 disjunctive([AUX[i , j] | i in 1 .. (num_left_trains+num_right_trains)]
               ,  
               [AUX_VAR_2[i , j] | i in 1 .. (num_left_trains+num_right_trains)]
      )
) ;

%%%
/* 
constraint  %% Trains  LEFT  <-->  RIGHT
forall(j in 1..(num_stations-1)) (
	 disjunctive([departure_left_time[i,j]  | i in 1 .. num_left_trains],                 
   [travel_left_time[i] | i in 1 .. num_left_trains]) 
   )
   /\
   forall(j in 2 .. num_stations ) (
	 disjunctive([departure_right_time[i,j]  | i in 1 .. num_right_trains],                 
   [travel_right_time[i] | i in 1 .. num_right_trains]) 
 ); 
*/


%% The end time for all trains
constraint
   cost = sum([ X[i,num_stations] | i in 1..num_left_trains]) 
          + 
          sum([ Y[i,1] | i in 1..num_right_trains]);

%%%%%%%%%%%%%%%%%%%% SOLVER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%solve satisfy;
solve minimize cost;
%%%%%%%%%%%%%%%%%%%%%%%%%% SAIDA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

output 
   ["Meanings..... Train,Station" ++ ": Arrival and Departure Times"]
     ++
   ["\n Trains from LEFT Side: \n"]     ++
   [" "++show(i)++ "," ++ show(j) ++ ": " ++ show(fix(X[i,j]))
 ++" "++ show(departure_left_time[i,j]) ++ if j == 4 then "\n" else "\t " endif  | i in 1..3, j in 1..4]
      ++
   ["\n Trains from RIGHT Side: \n"]     ++
   [" "++show(i)++ "," ++ show(j) ++ ": " ++ show(fix(Y[i,j]))
 ++" "++ show(departure_right_time[i,j]) ++ if j == 4 then "\n" else "\t " endif  | i in 1..3, j in 1..4]
   ;


%%%%%%%%%%%%%%%%%%%%%% output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*

Meanings..... Train,Station: Arrival and Departure Times
 Trains from LEFT Side: 
 1,1: 0 21	  1,2: 36 42	  1,3: 57 72	  1,4: 87 0
 2,1: 0 6	    2,2: 21 27	  2,3: 42 57	  2,4: 72 0
 3,1: 0 36	  3,2: 51 87	  3,3: 102 108	  3,4: 123 0

 Trains from RIGHT Side: 
 1,1: 123 0	  1,2: 102 108	  1,3: 51 87	  1,4: 0 36
 2,1: 87 0	  2,2: 57 72	  2,3: 36 42	  2,4: 0 21
 3,1: 72 0	  3,2: 42 57	  3,3: 21 27	  3,4: 0 6
----------
==========
Finished in 7s 285msec

*/