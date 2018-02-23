%Problema 03 - Funções, Predicados e Ad-hocs

%Considere um dominio Dx = {2, 3, 4}, Dy = {3, 4, 5} construa funções que faz a interpretação logica das formulas 

var set of int: X = {2,3,4};
var set of int: Y = {3,4,5};

var bool: resultA;
var bool: resultB;
var bool: resultC;
var bool: resultD;

function var bool: a(var set of int: X, var set of int: Y) = 
let {
  var bool: valor = forall(i in X)(exists(j in Y)(i<j));

    }in valor;

function var bool: b(var set of int: X, var set of int: Y) = 
let {
  var bool: valor = exists(i in X)(forall(j in Y)(i<j));

    }in valor;

function var bool: c(var set of int: X, var set of int: Y) = 
let {
  var bool: valor = forall(i in X)(exists(j in Y)(pow(i,2)!=j));

    }in valor;

function var bool: d(var set of int: X, var set of int: Y) = 
let {
  var bool: valor = exists(i in X)(forall(j in Y)(pow(i,2)!=j));

    }in valor;

constraint resultA = a(X,Y);
constraint resultB = b(X,Y);
constraint resultC = c(X,Y);
constraint resultD = d(X,Y);

solve satisfy;

output["resultado: ", show(resultA)," ",show(resultB)," ",show(resultC)," ",show(resultD)];

%saida:
% nesses conjuntos usados como exemplo:
% resultado: true true true true

%%  solutions:     1
%%  variables:     4
%%  propagators:   0
%%  propagations:  0
%%  nodes:         1