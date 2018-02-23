\begin{verbatim}
% fatos sobre o problema
% numerando uma lista de células de a a i
o_quadrado([cell(a, _), cell(b, _), cell(c, _), cell(d, _),  
              cell(e, _), cell(f, _), cell(g, _), cell(h, _),
              cell(i, _)]).

% número de células
  numbers([1,2,3,4,5,6,7,8,9]).

% condição de parada
 soma_das_celulas(15).

 gerar_quadrados :-
          %  fatos do problema
          o_quadrado(Square),
          numbers(Numbers),
          % gerar quadrados
          fill_square(Numbers, Square),
          % testar quadrados
          test_square(Square),
          % saída
          display_square(Square).


  % 1 condição de parada
     fill_square([], _).
   % 2 condição recursiva 
     fill_square([Number|Tail], Cells) :-
          member(cell(_, Number), Cells),
          fill_square(Tail, Cells).

      
 test_square([cell(a, Cell_a), cell(b, Cell_b ), cell(c, Cell_c), 
              cell(d, Cell_d), cell(e, Cell_e), cell(f, Cell_f),
              cell(g, Cell_g), cell(h, Cell_h), cell(i, Cell_i)]) :-

 soma_das_celulas(Sum), % terá que ser até 15
          % testar as  linhas ===> soma da linhas igual a 15
          Sum is Cell_a + (Cell_b + Cell_c),
          Sum is Cell_d + (Cell_e + Cell_f),
          Sum is Cell_g + (Cell_h + Cell_i),
          % testar as colunas ===> soma da coluna igual a 15
          Sum is Cell_a + (Cell_d + Cell_g),
          Sum is Cell_b + (Cell_e + Cell_h),
          Sum is Cell_c + (Cell_f + Cell_i),

         % testar as duas diagonais ===> soma das duas diagonais
          Sum is Cell_a + (Cell_e + Cell_i),
          Sum is Cell_c + (Cell_e + Cell_g).

% imprimindo....
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

  % writeln/1  ===> auxiliar
     writeln(X) :- write(X) ,   nl.
\end{verbatim}
