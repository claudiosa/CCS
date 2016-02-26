solve satisfy;

function int:
columns (array[int, int] of int: matrix) = length (row (matrix, 0));

function int:
rows (array[int, int] of int: matrix) = length (col (matrix, 0));

function string:
matrix2 (array[int, int] of int: matrix, int: a, int: b) =
  if b != 0
    then
      matrix2 (matrix, a, b - 1) ++ "," ++ show (matrix [a, b])
    else ""
  endif;

function string:
matrix1 (array[int, int] of int: matrix, int: a) =
  if a != 0
    then
      matrix1 (matrix, a - 1) ++ "\n" ++
      matrix2 (matrix, a, columns (matrix))
    else ""
  endif;

function string:
matrix (array[int, int] of int: matrix) =
  matrix1(matrix, rows (matrix));

%prefixed
function set of $a: punion(set of $a: a, set of $a: b) =
  a union b;

set of int: A211 = {1, 2, 4, 6};
set of int: B211 = {4, 3, 7, 8, 9};

set of int: A212 = {0, -1, 1, 5};
set of int: B212 = {0, -5, 10, 8, 3};

set of int: A232 = {-5, -3, 2, 5};

function int : fibonacci (int: a) =
  if a = 0
    then 0
    else
      if a = 1
        then 1
        else fibonacci (a - 1) + fibonacci (a - 2)
      endif
  endif;
int: a = fibonacci (5);

function array[int] of int: fibonaccis (int: a) =
  if a = -1
    then []
    else
      fibonaccis (a - 1) ++ [fibonacci (a)]
  endif;

function bool: is_prime2 (int: a, int: b) =
  if b < 1
    then false
    else
      if b = 1
        then true
        else
          if a mod b = 0
            then false
            else is_prime2 (a, b - 1)
          endif
      endif
  endif;

function bool: is_prime (int: a) =
  is_prime2 (a, a - 1);

function int: prime2 (int: a, int: b) =
  if a = -1
    then b - 1
    else
      if is_prime (b)
        then
          prime2 (a - 1, b + 1)
        else
          prime2 (a, b + 1)
      endif
  endif;

function int: prime (int: a) =
  prime2 (a, 0);

function array[int] of int: list_of_primes (int: a) =
  if a = -1
    then []
    else
      list_of_primes (a - 1) ++ [prime (a)]
  endif;


function array[int] of int: duples1 (array[int,int] of int: a, array[int,int] of int: b, int: c) =
  if c = 0
    then []
    else
      duples1 (a, b, c - 1) ++ [a [c, 1]] ++ [b [c, 2]]
  endif;

function array[int,int] of int: duples (array[int,int] of int: a, array[int,int] of int: b) =
  array2d (1 .. rows (a), 1 .. 2, duples1 (a, b, rows (a)));


output [
show(punion(A211, B211)) ++ "\n"
++show(A212 union B212) ++ "\n"
++show(A211 intersect B211) ++ "\n"
++show(A212 intersect B212) ++ "\n"
++show(A211 diff B211) ++ "\n"
++show(A232 diff B212) ++ "\n"
++show(fibonacci (5)) ++ "\n"
++show(fibonacci (9)) ++ "\n"
++show(fibonaccis (5)) ++ "\n"
++show(fibonaccis (9)) ++ "\n"

++show(is_prime (0)) ++ "\n"
++show(is_prime (1)) ++ "\n"
++show(is_prime (2)) ++ "\n"
++show(is_prime (3)) ++ "\n"
++show(is_prime (4)) ++ "\n"

++show(prime (0)) ++ "\n"
++show(prime (1)) ++ "\n"
++show(prime (2)) ++ "\n"
++show(prime (3)) ++ "\n"
++show(prime (4)) ++ "\n"
++show(prime (5)) ++ "\n"
++show(prime (6)) ++ "\n"

++show(list_of_primes (6)) ++ "\n"

++matrix(duples ([|0, 5,|
                  1, 7,|
                  -3, 5,|
                  -5, 8,|],[|-1, 0,|
                             0, -1,|
                             5, 4,|
                             2, 9,|
                             -7, -6,|]))
];
