% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only


% Simple automotive expert system

% Menu that obtains 'yes' or 'no' answer

get_yes_or_no(Result) :- get(Char),              % read a character
                         get0(_),                % consume the Return after it
                         interpret(Char,Result),
                         !.                      % cut -- see text

get_yes_or_no(Result) :- nl,
                         write('Type Y or N:'),
                         get_yes_or_no(Result).

interpret(89,yes).  % ASCII 89  = 'Y'
interpret(121,yes). % ASCII 121 = 'y'
interpret(78,no).   % ASCII 78  = 'N'
interpret(110,no).  % ASCII 110 = 'n'

%
% Main control procedures
%

start :-
   write('This program diagnoses why a car won''t start.'),nl,
   write('Answer all questions with Y for yes or N for no.'),nl,
   clear_stored_answers,
   try_all_possibilities.

try_all_possibilities :-     % Backtrack through all possibilities...
   defect_may_be(D),
   explain(D),
   fail.

try_all_possibilities.       % ...then succeed with no further action.


%
% Diagnostic knowledge base
%   (conditions under which to give each diagnosis)
%

defect_may_be(drained_battery) :-
   user_says(starter_was_ok,yes),
   user_says(starter_is_ok,no).

defect_may_be(wrong_gear) :-
   user_says(starter_was_ok,no).

defect_may_be(starting_system) :-
   user_says(starter_was_ok,no).

defect_may_be(fuel_system) :-
   user_says(starter_was_ok,yes),
   user_says(fuel_is_ok,no).

defect_may_be(ignition_system) :-
   user_says(starter_was_ok,yes),
   user_says(fuel_is_ok,yes).


%
% Case knowledge base
%   (information supplied by the user during the consultation)
%

:- dynamic(stored_answer/2).

   % (Clauses get added as user answers questions.)


%
% Procedure to get rid of the stored answers
% without abolishing the dynamic declaration
%

clear_stored_answers :- retract(stored_answer(_,_)),fail.
clear_stored_answers.


%
% Procedure to retrieve the user's answer to each question when needed,
% or ask the question if it has not already been asked
%

user_says(Q,A) :- stored_answer(Q,A).

user_says(Q,A) :- \+ stored_answer(Q,_),
                  nl,nl,
                  ask_question(Q),
                  get_yes_or_no(Response),
                  asserta(stored_answer(Q,Response)),
                  Response = A.


%
% Texts of the questions
%

ask_question(starter_was_ok) :-
   write('When you first started trying to start the car,'),nl,
   write('did the starter crank the engine normally? '),nl.

ask_question(starter_is_ok) :-
   write('Does the starter crank the engine normally now? '),nl.

ask_question(fuel_is_ok) :-
   write('Look in the carburetor.  Can you see or smell gasoline?'),nl.


%
%  Explanations for the various diagnoses
%

explain(wrong_gear) :-
   nl,
   write('Check that the gearshift is set to Park or Neutral.'),nl,
   write('Try jiggling the gearshift lever.'),nl.

explain(starting_system) :-
   nl,
   write('Check for a defective battery, voltage'),nl,
   write('regulator, or alternator; if any of these is'),nl,
   write('the problem, charging the battery or jump-'),nl,
   write('starting may get the car going temporarily.'),nl,
   write('Or the starter itself may be defective.'),nl.

explain(drained_battery) :-
   nl,
   write('Your attempts to start the car have run down the battery.'),nl,
   write('Recharging or jump-starting will be necessary.'),nl,
   write('But there is probably nothing wrong with the battery itself.'),nl.

explain(fuel_system) :-
   nl,
   write('Check whether there is fuel in the tank.'),nl,
   write('If so, check for a clogged fuel line or filter'),nl,
   write('or a defective fuel pump.'),nl.

explain(ignition_system) :-
   nl,
   write('Check the spark plugs, cables, distributor,'),nl,
   write('coil, and other parts of the ignition system.'),nl,
   write('If any of these are visibly defective or long'),nl,
   write('overdue for replacement, replace them; if this'),nl,
   write('does not solve the problem, consult a mechanic.'),nl.

