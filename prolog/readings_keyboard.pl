%$ swipl -t main -q -f readings_keyboard.pl 

main :- menu(z).
main.

menu( e ):- format("\n EXIT \n"), halt.    /* to finish the menu */
menu( _ ) :-
    % shell('clear'),
	repeat,   nl,
	tty_clear,
	write('  <<< Menu >>>    '), nl,
	% write(' c - xxxxxxxxs                 '), nl,
	% write(' m - xxxxxx                '), nl,
	write(' e - To finish (eND)       '), nl,
	write(' Press: ^,v,>,< (right arrows) or e (exit) ==> '),
	my_read_option(R),
	action(R),
	get_single_char(_),
	menu(R).     /* recursive call */


my_read_option(X) :- 
      get_single_char(Y), %% works fine
	  atom_char(X,Y), %%% OK
	  format("\n keypressed ==> ~w ~w",[X,Y]),
	  member(X,[ e,'A','B','C','D','E' ]).
  
action('A') :- format("\n UP").    %% 65 
action('B') :- format("\n DOWN").
action('C') :- format("\n RIGHT").
action('D') :- format("\n LEFT").   % 68
action(e).	 %% END
action('E') :- format("\n EXIT \n"), halt.   % 68
