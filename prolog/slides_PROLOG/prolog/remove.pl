removeall :-
        current_predicate(_, M:Head),
        \+ predicate_property(M:Head, builtin),
        funcor(Head, Name, Arity),
        abolish(M:Name/Arity),
        fail.
removeall.