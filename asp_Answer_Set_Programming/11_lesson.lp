p(1..2, 1..8).

%%% As restricoes NAO podem
%%% confrontar com que jah eh
%%% uma VERDADE
:- p(X,_) , X > 2.
:- p(_ , Y) , Y > 8.


