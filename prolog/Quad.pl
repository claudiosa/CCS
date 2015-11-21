===> dcc2ccs@joinville.udesc.br
===> c_cesar@netville.com.br


     % facts about the domain

     squares( [cell(a, _), cell(b, _), cell(c, _), cell(d, _),  
              cell(e, _), cell(f, _), cell(g, _), cell(h, _),
              cell(i, _)] ).

     numbers([1,2,3,4,5,6,7,8,9]).

     sum_of_row(15).

     generate_square :-
          % retrieve facts about the domain
          squares(Square),
          numbers(Numbers),
          % generate square
          fill_square(Numbers, Square),
          % test square
          test_square(Square),
          % output square
          display_square(Square).


     % 1 boundary condition
     fill_square([], _).
     % 2 recursive condition
     fill_square([Number|Tail], Cells) :-
          member(cell(_, Number), Cells),
          fill_square(Tail, Cells).

/*
     test_square([cell(a, Cell_a), cell(b, Cell_b), cell(c, Cell_c), 
                  cell(d, Cell_d), cell(e, Cell_e), cell(f, Cell_f),
                  cell(g, Cell_g), cell(h, Cell_h), cell(i, Cell_i)]) :-
*/      
     test_square([cell(a, Cell_a), cell(b, _ ), cell(c, Cell_c), 
                  cell(d, _), cell(e, Cell_e), cell(f, _),
                  cell(g, Cell_g), cell(h, _), cell(i, Cell_i)]) :-
          sum_of_row(Sum),
          % test rows
%          Sum is Cell_a + (Cell_b + Cell_c),
%          Sum is Cell_d + (Cell_e + Cell_f),
%          Sum is Cell_g + (Cell_h + Cell_i),
          % test columns
%          Sum is Cell_a + (Cell_d + Cell_g),
%          Sum is Cell_b + (Cell_e + Cell_h),
%          Sum is Cell_c + (Cell_f + Cell_i),
          % test diagonals
          Sum is Cell_a + (Cell_e + Cell_i),
          Sum is Cell_c + (Cell_e + Cell_g).


     display_square([cell(a, Cell_a), cell(b, Cell_b), cell(c, Cell_c), 
                     cell(d, Cell_d), cell(e, Cell_e), cell(f, Cell_f),
                     cell(g, Cell_g), cell(h, Cell_h), cell(i, Cell_i)]) :-
          tab(10),
          writeln('-------------'),
          tab(10),          write('| '),
          write(Cell_a),
          write(' | '),
          write(Cell_b),
          write(' | '),
          write(Cell_c),
          writeln(' |'),
          tab(10),
          writeln('-------------'),
          tab(10),
          write('| '),
          write(Cell_d),
          write(' | '),
          write(Cell_e),
          write(' | '),
          write(Cell_f),
          writeln(' |'),
          tab(10),
          writeln('-------------'),
          tab(10),
          write('| '),
          write(Cell_g),
          write(' | '),
          write(Cell_h),
          write(' | '),
          write(Cell_i),
          writeln(' |'),
          tab(10),
          writeln('-------------').


     % utilities

     % member/2 
     % 1 boundary condition
     member(Elem, [Elem|_]).
     % 2
     member(Elem, [_|Tail]) :-
          member(Elem, Tail).

     % writeln/1
     writeln(Arg) :-
          write(Arg), 
          nl.
