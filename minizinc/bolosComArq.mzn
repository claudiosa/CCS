int: farinha;
int: banana;
int: acucar;
int: manteiga;
int: cacau;

var 0..100: bb; %bolo de banana
var 0..100: bc; %bolo de chocolate

constraint assert(farinha >= 0, "Cara, nao existe farinha negativa!\n");
constraint assert(banana >= 0, "Cara, nao existe banana negativa!\n");
constraint assert(acucar >= 0, "Cara, nao existe acucar negativo!\n");
constraint assert(manteiga >= 0, "Cara, nao existe manteiga negativa!\n");
constraint assert(cacau >= 0, "Cara, nao existe cacau negativo!\n");

constraint 250*bb + 200*bc <= farinha;
constraint 2*bb <= banana;
constraint 75*bb + 150*bc <= acucar;
constraint 100*bb + 150*bc <= manteiga;
constraint 75*bc <= cacau;

solve maximize 450*bc + 400*bb;

output["bb = ",show(bb), "\nbc = ", show(bc)];