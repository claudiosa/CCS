read_valid_key(Y_LowerCase) :- 
  flush_output,
  get_single_char(Y) , %% works fine
  atom_char(X,Y) ,     %% OK
  downcase_atom(X, Y_LowerCase), %% convert to Lower_Case

  member(Y_LowerCase,['a','b','c','d','x' ]),
  format("\n Keypressed =>  (key: ~w) (ascii code: ~w) ", [X,Y] ).


%% tty_clear
cls :- write('\e[H\e[2J').

pause :- get_single_char(_).	

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