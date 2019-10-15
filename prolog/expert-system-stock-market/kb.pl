
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%     knowledge base      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% begin k-base :

%%% 7 variables or atributes
atributes([month, open, high, low, close, volume, inflation_rate]).

%%% values of each variables
%atrib_values(month,[previous_month, six_month_ago]). %%
atrib_values(month,[bbb,aa,ccd]) . %%
atrib_values(open,[is_rising, at_same, is_going_down]).
atrib_values(high,[high, at_same, low]).
atrib_values(low,[high, at_same, low]).
atrib_values(close,[is_rising, at_same, is_going_down]).
atrib_values(volume,[high, at_same, low]).
atrib_values(inflation_rate,[increases, at_same, decreases]).

%%% FAKE RULEs
rule(if_([month/bbb] ), then_('yyyyyyyyyyyyyyyyyy')).
rule(if_([month/aa] ), then_('xxxxxxxxxxxxxxxxxx')).



/*
Rule 9: IF inflation rate decreases then share price also
decreases that shows the recession period of country.
*/
rule(if_([inflation_rate/decreases]), then_('share price also
decreases that shows the recession period of country')).

/*
Rule 10: IF close price of share is rising and check also open
price and high price also rising with the same ratio then sell
share and earn money
*/
rule(if_([close/is_rising, open/is_rising, high/is_rising, inflation_rate/at_same]),
     then_('sell share and earn money')). 





%%% very trick ... atom_chars
collecting_data(L) :-
  findall(X/Y, if_(X,Y), L),!. 
collecting_data([]). %%% exception

 %findall(X/A, (if_(X,Y), atom_chars(A,[Y])), L). 





