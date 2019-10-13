
% swipl -q -f main_tictactoe_game.pl -t main

:- use_module(library(ansi_term)).

%% to start automactically
:- initialization(main).

:- ensure_loaded(knowledge).

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
:- consult('kb.pl').


% tool for saving users answers :
:- dynamic(progress/2).

% make welcome :
welcome:-
	write('######################################'),nl,
	write('##   Hi ,                      ##'),nl,
	write('##   It is prototype -- Stock Market. ##'),nl,
	write('##   Expert System  ##'),nl,
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


menul(2):-
    nl,nl,
    write('Podaj chorobe, aby sprawdzic czy mamy ja w bazie:'), nl,
    read_line_to_codes(user_input,MenuCodes),
    wyszukaj(MenuCodes),
    halt

start:-
    write('Jak masz na imie?'), nl,
    read_line_to_codes(user_input,Codes1),
    capitalize(Codes1,Codes2)
    ->
    atom_codes(Name,Codes2),
    write('Ile masz lat?'), nl,
    read_line_to_codes(user_input,WiekPacjenta),
    atom_codes(WiekPacjenta2,WiekPacjenta),
    atom_number(WiekPacjenta2, WiekPac),
    istBiggerThen(WiekPac,50),
    repeat,
    abolish(known/3),
    dynamic(known/3),
    retractall(known/3),
    diagnose(Name), nl, nl,
    write('Chcesz sprobowac ponownie? (t/n)'), nl,
    read_line_to_codes(user_input,MenuCodes),
    string_codes(Resp,MenuCodes),
    \+ Resp= "t", nl, nl,
    write('Dzieki za wspolprace'),
    abolish(known,3),
    abolish(wiek,1),
    halt.










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
