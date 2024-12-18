%%% this KB was build in according of paper mentioned
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%     knowledge base      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 7 variables or atributes
atributes([month, open, high, low, close, volume, inflation_rate]).

%%% Values of each variables -- attributes
%%% Format: atrib_values(name_of_attribute, [value01, value02, ... value0n] ). 
%% HERE TO BE IMPROVE --- I kicked following my intuition
atrib_values(month, [previous_month, six_month_ago] ). %%
atrib_values(open, [is_rising, at_same, is_going_down] ).
atrib_values(high, [is_rising, at_same, is_going_down] ).
atrib_values(low, [is_rising, at_same, is_going_down] ).
atrib_values(close, [is_rising, at_same, is_going_down] ).
atrib_values(volume, [high, at_same, low] ).
atrib_values(inflation_rate, [increases, at_same, decreases] ).

%%% the rules extract from the paper ... interpreted by me
%%% Some of these rules are not tested yet
%%%
/*
Rule 1: IF open price of share rises from the previous month
then invest money for particular month.
*/
rule(if_([open/is_rising, month/previous_month]), 
	then_('... invest money for particular month ')).

/*
Rule 2: IF open price of share falls from previous month then
do not invest money for particular month.
*/
rule(if_([open/is_going_down, month/previous_month]), 
	then_('... do not invest money for particular month. ')).

/*
Rule 3: IF open price and low price rise and at the same time
high price of share also rising then invest money for particular
share.
*/
rule(if_([open/is_rising, low/is_rising, high/is_rising]), 
	then_('... invest money for particular share. ')).

/*
Rule 4: IF open piece and low price rise and at the same time
close price also rising then investing money for particular
month may be harmful.
*/
rule(if_([open/is_rising, low/is_rising, close/is_rising]), 
	then_('... investing money for particular month may be harmful. ')).


/*
Rule 5: IF volume and open price of share increase then share
prices also increase i.e. sell share and earn profit.
*/
rule(if_([volume/high, open/is_rising]), 
	then_('... share prices also increase i.e. sell share and earn profit. ')).

/*
Rule 6: IF open price and close price rising and at the same
time low price also rising then buy company‘s share at low
price.
*/
rule(if_([open/is_rising, close/is_rising, low/is_rising]), 
	then_('... buy company‘s share at low price. ')).


/*
Rule 7: IF volume and close price falls down then do not invest
money.
*/
rule(if_([volume/low, close/is_going_down]), 
	then_('... do not invest money. ')).

/*
Rule8:IF inflation rate increases then economical growth of the
country also increases i.e. share market performs outstanding.
*/
rule(if_([inflation_rate/increases]), 
	then_('... economical growth of the country also increases i.e. share market performs outstanding. ')).


/*
Rule 9: IF inflation rate decreases then share price also
decreases that shows the recession period of country.
*/
rule(if_([inflation_rate/decreases]), 
	then_('... share price also decreases that shows the recession period of country ')).

/*
Rule 10: IF close price of share is rising and check also open
price and high price also rising with the same ratio then sell
share and earn money
*/
rule(if_([close/is_rising, open/is_rising, high/high, inflation_rate/at_same]),
     then_('... sell share and earn money')). 


%%%%%%%%%%%%%%% END OF RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% very trick ... atom_chars

%%% collecting_if_data -- PARTIAL
collecting_if_data(L) :-
  findall(X/Y, if_(X,Y), L),!. 
collecting_if_data([]). %%% exception

 %findall(X/A, (if_(X,Y), atom_chars(A,[Y])), L). 

%%% collecting_ FINAL DATA
conclusions(All_Conclusions):- 
   collecting_if_data( L_Facts ),
   write(L_Facts),
   findall(Recomendation, 
   ( rule( if_(L), then_(Recomendation) ) , are_equiv(L,L_Facts)),
  	All_Conclusions).
   
/********************************************************************/



