:- lib(ic).
%% sliding a window with 11..11 over an array with size N

go :-
	Size_Array = 8,
	Size_Window = 5,
    model(Size_Window, Size_Array, Xslist),
    search(Xslist),
    writeln(Xslist),
    fail.
go.    

model(SizeWindow, N, Xslist) :-
    
    dim(Xs, [N]),
    Xs :: 0..1,
    [Begin, End] :: 1..N,
    End - Begin #= SizeWindow-1,
    ( foreacharg(Xi, Xs, I), 
        param(Begin, End) do
        Yes #= (I #>= Begin and I #=< End),
        #=(Xi, 1, Yes) ),
        %% sendo Xi verdade, entao Yes eh reifado em 1
    array_list(Xs, Xslist) %% newest
    %% flatten_array(Xs, Xslist)
    .

search(Xslist) :-   
    labeling(Xslist).


/*
SAIDA:

[0, 0, 0, 1, 1, 1, 1, 1]
[0, 0, 1, 1, 1, 1, 1, 0]
[0, 1, 1, 1, 1, 1, 0, 0]
[1, 1, 1, 1, 1, 0, 0, 0]

*/
