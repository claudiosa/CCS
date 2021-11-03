
%% From https://stackoverflow.com/questions/43163232/how-to-sum-in-clingo
%% Cool example of CLINGO
food_a(bagel, 245).
food_a(sandwich, 200).
food_a(salad,300).
food(bagel).
food(sandwich).
food(salad).

% allow any combination of foods to be selected
{ selected(P) } :- food(P).
% sum calories on selected foods
total(S) :- S = #sum{ I : food_a(P,I), selected(P) }.
% limit total calories
:- total(S), S>=500.

#show selected/1.
#show total/1.
