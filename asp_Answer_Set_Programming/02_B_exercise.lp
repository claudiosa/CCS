
% to run $ clingo 02_B_exercise.lp 0
%Rewrite Π1 and Π2 to comply clingo syntax, and run them using clingo. Do these two program have the same answer set?

% Π2: 
-prof(alice). 
-adult(bob). 

-adult(X) :- -prof(X). 
% adult(X) :- prof(X). ==> NOT ALLOWED ... because the fact starts in -adult

:- -adult(X) ; not -adult(X) . 
is_prof(X) :- -prof(X) . %%% is_prof is the same of -prof
%:- is_prof(X) ; not is_prof(X).  %%% optional

%%%% Comment the output desired
#show is_prof/1. %% to show only the profs
#show -prof/1. %% to show only the -profs
#show -adult/1.