
?- string_to_list(abc,L).

L = [97, 98, 99] 

Yes
?- string_to_list("abc",L).

L = [97, 98, 99] 

Yes
?- string_to_list(S,[99,100, 101,99]).

S = "cdec" 

Yes
?- string_to_list(S,[32, 99,100, 101,99, 32]).

S = " cdec " 

Yes
