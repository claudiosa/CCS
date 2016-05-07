int: num_cores = 3;

var 1..num_cores: norte;
var 1..num_cores: nordeste;
var 1..num_cores: centro_oeste;
var 1..num_cores: sudeste;
var 1..num_cores: sul;

constraint norte != nordeste;
constraint norte != centro_oeste;
constraint nordeste != centro_oeste;
constraint nordeste != sudeste;
constraint centro_oeste != sudeste;
constraint centro_oeste != sul;
constraint sudeste != sul;

solve satisfy;

output["norte: " ++ show(norte) ++
     "\nnordeste: " ++ show(nordeste) ++
     "\ncentro_oeste: " ++ show(centro_oeste) ++
     "\nsudeste: " ++ show(sudeste) ++
     "\nsul: " ++ show(sul)];