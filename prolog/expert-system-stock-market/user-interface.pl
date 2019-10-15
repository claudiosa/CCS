
% swipl -q -f main_tictactoe_game.pl -t main

:- use_module(library(ansi_term)).

%% to start automactically
%:- initialization(main).

%:- ensure_loaded(kb).
%:- ensure_loaded(input_output_predicates).
% consult K-Base :
:- reconsult('kb.pl').
:- reconsult('input_output_predicates.pl').
:- dynamic(if_/2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%     main program      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% begin :
run:-
	welcome(X),
	menu( X ).
%	undo_reset,
%%    search_solution(X),
 %   print_solution(X).
% end.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   program process    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% begin :


% tool for saving users answers :


% make welcome :
welcome(X):-
  cls,
	write('#############################'),nl,
	write('##   Hi,  it is prototype  ##'),nl,
	write('##      Stock Market       ##'),nl,
	write('##     Expert System       ##'),nl,
	write('##############################'),nl,
	nl,
  reset,
	flush_output,
  get_single_char(X). 
  %read_line_to_codes(user_input,X),
  %write(Y).
	


% reset program :
reset :-
  retractall(if_/2),
  write('Data Base Cleaned .... ').
  
%% COLORS availble
%%% black, red, green, yellow, blue, magenta, cyan, white

menu('0').    /* para terminar este menu principal */
menu( _ ) :-
        repeat,    /* repeat until */ 
        cls,
        ansi_format([bold,fg(green)],'\n     <<< Attributes Menu >>>    ',[]), 
        ansi_format([bold,fg(green)],'\n   <<< Choice the Evidences >>>    ',[]), 
        ansi_format([bold,fg( magenta)],'\n 1 - Month ',[]),
        ansi_format([bold,fg( magenta)],'\n 2 - Open ',[]),
        ansi_format([bold,fg( magenta)],'\n 3 - High ',[]),
        ansi_format([bold,fg( magenta)],'\n 4 - Low ',[]),
        ansi_format([bold,fg( magenta)],'\n 5 - Close ',[]),
        ansi_format([bold,fg( magenta)],'\n 6 - Volume ',[]),
        ansi_format([bold,fg( magenta)],'\n 7 - Inflation Rate ',[]),
        ansi_format([bold,fg(green)],'\n 8 - More evidences ?',[]),
        ansi_format([bold,fg(green)],'\n 9 - Would you like conclude ?',[]),
        ansi_format([bold,fg(red)],'\n 0 - To exit',[]),
        ansi_format([bold,fg(yellow)],'\n Type one of the options abore [0-9] ==> ',[]),
        read_option(Y),
       % trace,
        action(Y),
       % notrace,
        menu(Y).     /* chamada recursiva */



action('0') :- nl, 
               abolish(if_/2), 
               abort. %%%halt.

action('1') :-

   atrib_values(month, L_values), %%%[previous_month, 6_month_ago]).
   print_L_values(L_values),
   read_Value(Value),
   asserta( if_(month, Value) ),
   ansi_format([bold, fg(yellow)],
  '\n This fact was added: month/~w ',[Value]),
   get_single_char(_).
   
action('8') :- true. %%% back main menu

action('9') :-
   format("\n Recomendation:"),
   collecting_data( L ),
   write(L),
   rule( if_(L), then_(Recomendation) ),
   ansi_format([bold, fg(yellow)], '\n => ~w',[Recomendation]),
   get_single_char(_), 
   abolish(if_/2), !.

action('9') :-
   ansi_format([bold, fg(yellow)], '\n No conclusion yet ',[]),
   ansi_format([bold, fg(yellow)], '\n Feed the evidences ',[]),
   get_single_char(_).

action(_) :- ansi_format([bold,fg(yellow)],
           '\n ##### NOT READY YET #######',[]),
           get_single_char(_).


/*


menul(2):-
    nl,nl,
    write('Podaj chorobe, aby sprawdzic czy mamy ja w bazie:'), nl,
    read_line_to_codes(user_input,MenuCodes),
    wyszukaj(MenuCodes),
    halt.

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
*/