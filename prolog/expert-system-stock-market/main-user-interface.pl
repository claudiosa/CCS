
% swipl -q -f  main-user-interface.pl -t run

/*
Code developed by: Claudio Cesar de Sá -- ccs1664@gmail.com
It is prototype of an Expert System for Stock Market

Based in a paper from: Integrated Intelligent Research (IIR)

Published in: International Journal of Computing Algorithm
 Volume: 04 Issue: 01 June 2015 Pages:15-18   ISSN: 2278-2397

"Rule Based Approach for Stock Selection: An Expert System"


NONE WARRANTY - It is under development
*/

%:- ensure_loaded(kb).
%:- ensure_loaded(input_output_predicates).
% consult 2 others files :
:- use_module(library(ansi_term)).
:- consult('kb.pl').
:- consult('input_output_predicates.pl').
:- dynamic(if_/2).
%% to start automactically
:- initialization(run).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%     main program      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% begin :
run :-
	welcome(X),
	menu( X ).

% make welcome :
welcome(X):-
  cls,
	write('#############################'),nl,
	write('##   Hi, it is prototype   ##'),nl,
	write('##      Stock Market       ##'),nl,
	write('##     Expert System       ##'),nl,
	write('##############################'),nl,
	nl,
  reset,
	flush_output,
  format("\n Press any key ... : "),
  get_single_char(X). 
  %read_line_to_codes(user_input,X),
  %write(Y).

% reset program :
%reset :-
%  retractall(if_/2),
%  write('Data Base Cleaned .... ').
  % reset program :
reset :-
  retract(if_(_, _)),
  fail.
reset :- write(' ==> Data Base Cleaned .... ').
%% COLORS availble
%%% black, red, green, yellow, blue, magenta, cyan, white

menu('0').    /* to finish */
menu( _ ) :-
        repeat,    /* repeat until */ 
        cls,
        ansi_format([bold,fg(green)],'\n       <<< Attributes Menu >>>    ',[]), 
        ansi_format([bold,fg(green)],'\n <<< Choice the evidences: 1 to 7 >>>    ',[]), 
        ansi_format([bold,fg( magenta)],'\n 1 - Month ...........',[]),
        ansi_format([bold,fg( magenta)],'\n 2 - Open ............',[]),
        ansi_format([bold,fg( magenta)],'\n 3 - High ............',[]),
        ansi_format([bold,fg( magenta)],'\n 4 - Low .............',[]),
        ansi_format([bold,fg( magenta)],'\n 5 - Close ...........',[]),
        ansi_format([bold,fg( magenta)],'\n 6 - Volume ..........',[]),
        ansi_format([bold,fg( magenta)],'\n 7 - Inflation Rate ..',[]),
        ansi_format([bold,fg(green)],'\n ¿ 8 - Attributes Values Collected ?',[]),
        ansi_format([bold,fg(green)],'\n ¿ 9 - Finally: would you like conclude ?',[]),
        ansi_format([bold,fg(red)],'\n 0 - To exit',[]),
        ansi_format([bold,fg(yellow)],'\n Type one of the options abore [0-9] ==> ',[]),
        read_option(Y),
        action(Y),
        menu(Y).     /* recursive call */

action('0') :- reset, 
               nl, 
               halt.
               %abort. %%%halt.

/* ACTIONS for the MENU */
action('1') :-
   retractall(if_(month,_)), %%% to assure the last input of this Attribute
   atrib_values(month, L_values), 
   print_L_values(L_values),
   read_Value(Value),
   asserta( if_(month, Value) ),
   ansi_format([bold, fg(yellow)],
  '\n This fact was added: month/~w ',[Value]),
   get_single_char(_).

action('2') :-
   retractall(if_(open,_)), %%% to assure the last input of this Attribute
   atrib_values(open, L_values),
   print_L_values(L_values),
   read_Value(Value),
   asserta(if_(open, Value) ),
   ansi_format([bold, fg(yellow)],
  '\n This fact was added: open/~w ',[Value]),
   get_single_char(_).

action('3') :-
   retractall(if_(high,_)), %%% to assure the last input of this Attribute
   atrib_values(high, L_values),
   print_L_values(L_values),
   read_Value(Value),
   asserta(if_(high, Value) ),
   ansi_format([bold, fg(yellow)],
  '\n This fact was added: high/~w ',[Value]),
   get_single_char(_).

action('4') :-
   retractall(if_(low,_)), %%% to assure the last input of this Attribute
   atrib_values(low, L_values), 
   print_L_values(L_values),
   read_Value(Value),
   asserta(if_(low, Value) ),
   ansi_format([bold, fg(yellow)],
  '\n This fact was added: low/~w ',[Value]),
   get_single_char(_).


action('5') :-
   retractall(if_(close,_)), %%% to assure the last input of this Attribute
   atrib_values(close, L_values), 
   print_L_values(L_values),
   read_Value(Value),
   asserta(if_(close, Value) ),
   ansi_format([bold, fg(yellow)],
  '\n This fact was added: close/~w ',[Value]),
   get_single_char(_).


action('6') :-
   retractall(if_(volume,_)), %%% to assure the last input of this Attribute
   atrib_values(volume, L_values), 
   print_L_values(L_values),
   read_Value(Value),
   asserta(if_(volume, Value) ),
   ansi_format([bold, fg(yellow)],
  '\n This fact was added: volume/~w ',[Value]),
   get_single_char(_).


action('7') :-
   retractall(if_(inflation_rate,_)), %%% to assure the last input of this Attribute
   atrib_values(inflation_rate, L_values), %%%[previous_month, 6_month_ago]).
   print_L_values(L_values),
   read_Value(Value),
   asserta(if_(inflation_rate, Value) ),
   ansi_format([bold, fg(yellow)],
  '\n This fact was added: inflation_rate/~w ',[Value]),
   get_single_char(_).

   
action('8') :- collecting_if_data( L ),
               ansi_format([bold, fg(green)],'\n Collected until now : ~w',[L]),
               get_single_char(_). %%% back main menu

action('9') :-
   format("\n Recomendation:"),
   conclusions(All_Conclusions),
   print_Conclusions(All_Conclusions),
   get_single_char(_), 
   reset, !.

action('9') :-
   ansi_format([bold, fg(yellow)], '\n No conclusion yet ',[]),
   ansi_format([bold, fg(yellow)], '\n Feed the evidences ',[]),
   get_single_char(_).

action(_) :- ansi_format([bold,fg(yellow)],
           '\n ##### NOT READY YET #######',[]),
           get_single_char(_).

/****************************************************************************/

/*
 NOT USED
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