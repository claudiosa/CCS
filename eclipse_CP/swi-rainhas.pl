/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   N Queens animation demo.
   Written Feb. 2008 by Markus Triska (triska@gmx.at)
   Public domain code.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
:- use_module(library(clpfd)).
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Constraint posting
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

n_queens(N, Qs) :-
        length(Qs, N),
        Qs ins 1..N,
        safe_queens(Qs).

safe_queens([]).
safe_queens([Q|Qs]) :- safe_queens(Qs, Q, 1), safe_queens(Qs).

safe_queens([], _, _).
safe_queens([Q|Qs], Q0, D0) :-
        Q0 #\= Q,
        abs(Q0 - Q) #\= D0,
        D1 is D0 + 1,
        safe_queens(Qs, Q0, D1).


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Animation.

   For each N of the domain of queen Q, a reified constraint of the form

      Q #= N #<==> B

   is posted. When N vanishes from the domain, B becomes 0. A frozen
   goal then emits PostScript instructions for graying out the field.
   When B becomes 1, the frozen goal emits instructions for placing
   the queen. On backtracking, the field is cleared.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

animate(Qs) :- length(Qs, N), animate(N, Qs).

animate(0, _)  :- !.
animate(N, Qs) :-
        animate_(Qs, 1, N),
        N1 is N - 1,
        animate(N1, Qs).

animate_([], _, _).
animate_([Q|Qs], C, N) :-
        freeze(B, queen_value_truth(C,N,B)),
        Q #= N #<==> B,
        C1 is C + 1,
        animate_(Qs, C1, N).

queen_value_truth(Q, N, 1) :- format("~w ~w q\n", [Q,N]).
queen_value_truth(Q, N, 0) :- format("~w ~w i\n", [Q,N]).
queen_value_truth(Q, N, _) :- format("~w ~w c\n", [Q,N]), fail.


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   PostScript definitions.

   Sample instructions, with these definitions loaded:

   2 init   % initialize a 2x2 board
   1 1 q    % place a queen on 1-1
   1 2 q
   1 2 c    % remove the queen from 1-2
   2 2 i    % gray out 2-2
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

postscript("systemdict /.setlanguagelevel known { 2 .setlanguagelevel} if \
 /init {  /N exch def 322 N div dup scale -1 -1 translate \
          /Palatino-Roman findfont 0.8 scalefont setfont \
          0 setlinewidth \
          1 1 N { 1 1 N { 1 index c } for pop } for } bind def \
 /showtext { 0.5 0.28 translate dup stringwidth pop -2 div 0 moveto
          1 setgray show} bind def \
 /i { gsave translate .5 setgray 0 0 1 1 4 copy rectfill 0 setgray rectstroke \
    grestore } bind def \
 /q { gsave translate 0 0 1 1 rectfill (Q) showtext grestore } bind def \
 /c { gsave translate 1 setgray 0 0 1 1 4 copy rectfill 0 setgray rectstroke \
    grestore } bind def\n").


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Putting it all together: Set up communication with gs.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

show(Options, N, Qs) :-
        open(pipe('gs -dNOPAUSE -g680x680 -q -'), write,
             Out, [buffer(false),alias(gs)]),
        tell(Out),
        integer(N), N > 0,
        format("2 2 scale\n"),
        postscript(Ps),
        format(Ps),
        format("~w init\n", [N]),
        n_queens(N, Qs),
        animate(Qs),
        labeling(Options, Qs),
        finish.
show(_, _, _) :- finish, close(gs), fail.

finish :-
        format("copypage\n"),
        % fill the buffer to make 'gs' process all generated output
        ignore((between(1,500,_),
                format("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n"),
                fail)),
        flush_output.


%?- between(0, inf, N), show([ff], N, Qs).

%?- show([], 8, Qs).
