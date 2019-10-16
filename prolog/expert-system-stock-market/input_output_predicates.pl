/*
:- set_prolog_flag(answer_write_options,
                   [ quoted(true),
                     portray(true),
                     spacing(next_argument)
                   ]).
*/
read_option(Y_LowerCase) :- 
  flush_output,
  get_single_char(Y) , %% works fine
  atom_char(X,Y) ,     %% OK
  downcase_atom(X, Y_LowerCase), %% convert to Lower_Case
  member(Y_LowerCase, ['0','1','2','3', '4', '5', '6', '7', '8','9' ]),
  %format("\n Keypressed =>  (key: ~w) (ascii code: ~w) ", [X,Y] ),
  write(Y_LowerCase), ! .

read_option(Keypressed) :-
  format("\n Please, press something from 0 up to 9 ", [] ),
  get_single_char(Keypressed).

%%% show the options of each attribute
print_L_values([]) :- ansi_format([bold,fg(yellow)],
                  '\n =================== END VALUES ===================', []).
print_L_values([First|Rest]) :-
 %   format("\n => ~w", First),
     ansi_format([bold,fg(yellow)],'\n => ~w', [First]),
     print_L_values(Rest). 

print_Conclusions([]) :- ansi_format([bold,fg(yellow)],
                    '\n =================== END CONCLUSIONS ===================', []).
print_Conclusions([First|Rest]) :-
    ansi_format([bold,fg(yellow)],'\n => ~w', [First]),
    print_Conclusions(Rest). 

%%%% without syntax verification ----
%read_Value([First|Rest], Value) :-
read_Value( Value ) :-
    ansi_format([bold,fg(red)],'\n Experimental readings ... must be improved in the', []),
    format("\n TYPE EXACTLY as written ABOVE and Enter (^) =>  "),
    read_line_to_codes(user_input, VarCodes), %%% read and jump line
    atom_codes(Value, VarCodes).

%% tty_clear
cls :- write('\e[H\e[2J').


pause(X) :-
  ttyflush,
  get_single_char(X),
  flush_output.

%%?- tspy(equivalen_lists).
equivalent_lists([],[]) :-!.
equivalent_lists(L1,L2) :- are_equiv(L1,L2), 
                           are_equiv(L2,L1).
%%%% SUB-SET
are_equiv([],[] ) :- !.
are_equiv([A|L1],L2) :-
              member(A,L2)  ,
              delete(L2, A, L3) , 
              are_equiv(L1, L3) .


%pause :- get_single_char(_).	

/*
upcase_atom(+AnyCase, -UpperCase)
Converts, similar to downcase_atom/2, an atom to uppercase.
?- upcase_atom('e',X).
X = 'E'.

?- upcase_atom('eer',X).
X = 'EER'.

?- downcase_atom('eer',X).
X = eer.

?- downcase_atom('eerXXXXX',X).
X = eerxxxxx.

?- 
*/