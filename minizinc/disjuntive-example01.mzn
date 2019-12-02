% ORIGEM; http://pastebin.com/raw.php?i=jUTaEDv0
% Optimizing speakers for a conference in MiniZinc.
% Produced by Stackoverflow.com user Igor K
% Based on MiniZinc model created by Hakan Kjellerstrand, hakank@bonetmail.com. http://www.hakank.org/minizinc
%
/*
Task: There is a conference which has 6x time slots. There are 3 speakers attending the conference who are each available at certain slots. Each speaker will present for a predetermined number of slots.
Objective: Produce the schedule that has the earliest finish of speakers.
Example: Speakers A, B & C. Talk durations = [1, 2, 1]
Speaker availability:

+---+------+------+------+
|   | Sp.A | Sp.B | Sp.C |
+---+------+------+------+
| 1 |      | Busy |      |
| 2 | Busy | Busy | Busy |
| 3 | Busy | Busy |      |
| 4 |      |      |      |
| 5 |      |      | Busy |
| 6 | Busy | Busy |      |
+---+------+------+------+

*/ 
include "globals.mzn";

int: num_speakers = 3; % number of teachers
int: num_slots = 6; % number of slots
int: max_talk_duration = 3; % the maximum length of any talk (in slots)
array[1..num_speakers] of set of 1..num_slots: speaker_availability; % the slots a speaker is available
array[1..num_speakers] of 1..max_talk_duration: app_durations; % the duration of speaker talks
array[1..num_speakers] of var 1..num_slots: starting_slot; % the allocated starting slot
array[1..num_speakers] of var 1..num_slots: ending_slot; % the allocated ending slot

% no overlapping slots function
predicate no_overlap(var int:s1, int:d1, var int:s2, int:d2) = s1 + d1 <= s2 \/ s2 + d2 <= s1;

% ensure allocated slots don't overlap and the allocated slot is free for the speaker
constraint 
	forall(i in 1..num_speakers) (
		ending_slot[i] = starting_slot[i] + app_durations[i] - 1
	) /\
	forall(i,j in 1..num_speakers where i < j) (
		no_overlap(starting_slot[i], app_durations[i], starting_slot[j], app_durations[j])
	) /\
	forall(i in 1..num_speakers) (
		forall(j in 1..app_durations[i]) (
			starting_slot[i]+j-1 in speaker_availability[i]
		)
	) 
;

% objective is to finish the talks as early as possible
solve minimize max(i in 1..num_speakers) (ending_slot[i]);


output
[
   "Starting:  ", show(starting_slot), "\n",
   "Durations: ", show(app_durations), "\n",
   "Ends:      ", show(ending_slot), "\n",
];


% DATA BELOW HERE
% the slots a speaker is available to give their talk
speaker_availability = [
    {1,4,5},  
    {4,5},  
    {1,3,4,6}  
];

% the duration of each speaker's talk
app_durations = [1,2,1];

/*
Expected solution:

+---+----------+----------+----------+
|   |   Sp.A   |   Sp.B   |   Sp.C   |
+---+----------+----------+----------+
| 1 | SELECTED | Busy     |          |
| 2 | Busy     | Busy     | Busy     |
| 3 | Busy     | Busy     | SELECTED |
| 4 |          | SELECTED |          |
| 5 |          | SELECTED | Busy     |
| 6 | Busy     | Busy     |          |
+---+----------+----------+----------+
*/

