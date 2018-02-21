%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                          %
%	Means end planner from Bratko p 407.               %
%                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                              %
%  States are represented as lists of the literals that are    %
%  true in the state. Goals are lists of literals that must    %
%  be true in the goal state.                                  %
%                                                              %
%  Needs problem specific versions of                          %
%  predicates defining the effects of actions.                 %
%                                                              %
%   add_list(+Action, -AddList)  literals that become true     %
%   delete_list(+Action, -DeleteList) literals that become     %
%       false                                                  %
%   can_do(+Action, +State)  Action is possible in this state  %
%                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                                                


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%	plan(+InitialState,                                         %
%	     +Goals,		% description of the goal state     %
%	     -Plan,		% The plan !                        %
%	     -FinalState).                                          %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


plan(State, Goals, [], State) :-
	satisfied(State, Goals).	% Already there

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	If not already there then 
%   choose a subgoal (Goal)  from the list of goals
%   and an action (Action) that achives this subgoal.
%   The Plan then consists (PrePlan) of reaching a state where
%   the action can be taken. After the action 
%   (PostPlan) we plan to reach the Goal.
%
%   
%

plan(State, Goals, Plan, FinalState) :-
	append(PrePlan, [Action |PostPlan], Plan),  % Plan has three parts
	select(State, Goals, Goal),		    % Select a sub goal
	achieves(Action, Goal),			    % Choose an action
	can_do(Action, Condition),
	plan(State, Condition, PrePlan, MidState1), % Get to where  Action can be done.
	apply(MidState1, Action, MidState2),        % do the action
	plan(MidState2, Goals, PostPlan, FinalState).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                       %
%     satisfied(+State, +Goal)          %
%                                       %
%   Goal is satisfied in State          %
%                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


satisfied(State, []).		% Nothing to prove.

%  Check that each Goal is true in (ie a member of) State

satisfied(State, [Goal |RestOfGoals]) :-       
	member(Goal, State),
	satisfied(State, RestOfGoals).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                          %
%   select(+State, +Goals, -SubGoal)       %
%                                          %
%   Choose a SubGoal that is currently     %
%   not satisfied.                         %
%                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

select(State, Goals, SubGoal) :-
	member(SubGoal, Goals),
	not member(SubGoal, State).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                           %
%   achieves(+Action, +Goal)                %
%                                           %
%   Action makes Goal true. These effects   %
%   are in the Addlist of Action            %
%                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

achieves(Action, Goal) :-
	add_list(Action, AddList),
	member(Goal, AddList).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                            %
%    apply(+State, +Action, -NewState)       %
%                                            %
%  NewState is the result of applying        %
%  Action in State.                          %
%                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


apply(State, Action, NewState) :-
	delete_list(Action, DeleteList),       % what does Action make untrue.
	delete(State, DeleteList, State1), !,  % No going back
        add_list(Action, AddList),             
        append(AddList, State1, NewState).     % Add in new truths.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                              %
%   delete(+List1, +List2, -Difference)        %
%                                              %
%  Difference is set difference List1 - List2  %
%                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delete([], _, []).		% all done
delete([X|L1], L2, Diff) :-
	member(X, L2),!,	% X goes
        delete(L1,L2, Diff).
delete([X|L1], L2, [X|Diff]) :-
	delete(L1, L2, Diff).		% X stays.