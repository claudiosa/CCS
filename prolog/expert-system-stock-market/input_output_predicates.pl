

pause(X) :-
    ttyflush,
	get_single_char(X),
	flush_output.


read_option(Y_LowerCase) :- 
  flush_output,
  get_single_char(Y) , %% works fine
  atom_char(X,Y) ,     %% OK
  downcase_atom(X, Y_LowerCase), %% convert to Lower_Case
  member(Y_LowerCase, ['0','1', '2', '3', '4', '5', '6', '7', '8','9' ]),
  format("\n Keypressed =>  (key: ~w) (ascii code: ~w) ", [X,Y] ),!.

read_option(Keypressed) :-
  format("\n Please, press something from 0 up to 9 ", [] ),
  get_single_char(Keypressed).



read_valid_key(Y_LowerCase) :- 
  flush_output,
  get_single_char(Y) , %% works fine
  atom_char(X,Y) ,     %% OK
  downcase_atom(X, Y_LowerCase), %% convert to Lower_Case

  member(Y_LowerCase,['a','b','c','d','x' ]),
  format("\n Keypressed =>  (key: ~w) (ascii code: ~w) ", [X,Y] ).


%% tty_clear
cls :- write('\e[H\e[2J').

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