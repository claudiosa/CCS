%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%     main program      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% begin :
run:-
	welcome,
	undo_reset,
    search_solution(X),
    print_solution(X).
% end.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   program process    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% begin :

% consult K-Base :
:- consult('K-Base.pl').

% tool for saving users answers :
:- dynamic(progress/2).

% make welcome :
welcome:-
	write('######################################'),nl,
	write('##   Bienvenu,                      ##'),nl,
	write('##   Vous pouvez choisir un numéro. ##'),nl,
	write('######################################'),nl,
	nl.

% reset program :
undo_reset :-
  retract(progress(_, _)),
  fail.
undo_reset.

% search solution :
search_solution(X) :- 
    solution(X),!. 

% question mechanism :
ask(Question, Answer, Choices) :-
  print_question(Question),
  choices_list(Choices, 0),
  read(Index),
  parse(Index, Choices, Response),
  asserta(progress(Question, Response)),
  Response = Answer.

% make a list of choices :
choices_list([], _).
choices_list([First|Rest], Index) :-
  write('>> '),
  write(Index),
  write(' - '),  
  choice(First), 
  nl,
  NextIndex is Index + 1,
  choices_list(Rest, NextIndex).


% make a parse process :
parse(0, [First|_], First).
parse(Index, [_|Rest], Answer) :-
  Index > 0,
  NextIndex is Index - 1,
  parse(NextIndex, Rest, Answer).

% end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   program domaines    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% begin :
% 1° :
strategie(Answer) :-
  progress(strategie, Answer).
strategie(Answer) :-
  \+ progress(strategie, _),
  ask(
  	  strategie, 
  	  Answer, 
  	  [strategie_choice_1, 
  	  strategie_choice_2, 
  	  strategie_choice_3,
  	  strategie_choice_4,
  	  strategie_choice_5,
  	  rien_de_tout_cela]
  	).
  	
% 2° :
marketing(Answer):-
	progress(marketing, Answer).
marketing(Answer):-
	\+ progress(marketing,_),
	ask(
		marketing,
		Answer,
		[marketing_choice_1,
		marketing_choice_2,
		marketing_choice_3,
		marketing_choice_4,
		marketing_choice_5,
		marketing_choice_6,
		marketing_choice_7,
		marketing_choice_8,
		rien_de_tout_cela]
	).

% 3° :
finances(Answer):-
	progress(finances, Answer).
finances(Answer):-
	\+ progress(finances,_),
	ask(
		finances,
		Answer,
		[finances_choice_1,
		finances_choice_2,
		finances_choice_3,
		finances_choice_4,
		rien_de_tout_cela]
	).
	
% 4° :
ressources_humaines(Answer):-
	progress(ressources_humaines, Answer).
ressources_humaines(Answer):-
	\+ progress(ressources_humaines,_),
	ask(
		ressources_humaines,
		Answer,
		[ressources_humaines_choice_1,
		ressources_humaines_choice_2,
		ressources_humaines_choice_3,
		ressources_humaines_choice_4,
		ressources_humaines_choice_5,
		rien_de_tout_cela]
	).
	
% 5° :
technologie_equipement(Answer):-
	progress(technologie_equipement, Answer).
technologie_equipement(Answer):-
	\+ progress(technologie_equipement,_),
	ask(
		technologie_equipement,
		Answer,
		[technologie_equipement_choice_1,
		technologie_equipement_choice_2,
		technologie_equipement_choice_3,
		rien_de_tout_cela]
	).
	
% 6° :
exploitation(Answer):-
	progress(exploitation, Answer).
exploitation(Answer):-
	\+ progress(exploitation,_),
	ask(
		exploitation,
		Answer,
		[exploitation_choice_1,
		exploitation_choice_2,
		exploitation_choice_3,
		exploitation_choice_4,
		rien_de_tout_cela]
	).
% end.