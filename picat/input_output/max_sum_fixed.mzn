%% soma a maior subsequencia de tamanho fixo  ::: fixed_window = 3
int: n; 
n = 5;
int : fixed_window = 3;

array[1 .. n] of var 0..1 : x_decision;
array[1 .. n] of int :  vector;

vector = [144,  5, 8,  7, 15] ;

var int: total_SUM= sum(i in 1..n) ( x_decision[i]  *  vector[i]);

%
% exacly one  SUM has fixed size then ...
constraint  
        sum(j in 1 .. n) ( x_decision[j]) = fixed_window 
        ;

constraint
%% MUITO ELEGANTE
forall(j in 1 .. n) (
     ( x_decision[j]  == 1)
     ->
     (x_decision[j+1] == 1) \/ (x_decision[j-1] ==1)
     )
     ;


% minimize total_cost
solve maximize total_SUM;

output [
    "total_SUM: " ++ show(total_SUM) ++"\n"++
     show( x_decision )
    ++ "\n" ++ show( vector )
    ];
