set of int: A = {4,5,7,13};
set of int: B = 1 .. 3 union {7} union {13}; %% DOM descontinuos
%set of int: B = {1,2,3,7,13}; 

var set of   1 .. 100 : Var_Uniao;
var set of   1 .. 100 : Var_Inters ;
var bool : Var_Bool;
var int : X_Var;

constraint  Var_Uniao = B union A;

constraint  Var_Inters = B intersect A;

constraint  Var_Bool <-> (7 in A) /\ (7 in B); %% = ou <->

constraint  true <-> (X_Var in A) /\  (X_Var in B);
          
solve satisfy;

%% Na saida tudo eh convertido para String: show_int, show_float ...
output 
     ["VAR_Uniao = "  , show(Var_Uniao), "\n",
      "VAR_Inters = " , show(Var_Inters),"\n",
      "Var_Bol = "    , show(Var_Bool ),  "\n",
      "X_Var = "      , show_int(fix(X_Var), X_Var)];

%% fix: mais adiante ... mas aqui "fixa" a variavel para imprimir