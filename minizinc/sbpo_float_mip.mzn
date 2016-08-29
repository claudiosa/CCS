var float: x1;   var float: x2;   var float: x3;

var 0..4: x4 ;  %% UM INTEIRO   ou var int: x4 ;   

%% LIMITES
constraint  (0.0 <= x1 )  /\ (x1 <= 40.0);
constraint  (0.0 <= x2 ); % /\ (x2 <= 1000.0); %% lim sup aberto
constraint  (0.0 <= x3 ); % /\ (x3 <= 1000.0); %% lim sup aberto
constraint  (2 <= x4 ) /\  (x4 <= 3);
%% RESTRICOES
constraint  -x1 + x2 + x3 + 10*x4 <= 20.0;
constraint  x1 - 3.0*x2 + x3 <= 30.0;
constraint  x2 - 3.5 * x4 == 0;

%% OTIMIZAR
solve maximize x1 + 2.0*x2 + 3.0*x3 + x4;

output  ["x1: ", show(x1), "\t x2: ", show(x2),
         "\t x3: ", show(x3), "\t x4: ", show(x4)];
