var 0..100: bb; %bolo de banana
var 0..100: bc; %bolo de chocolate

constraint 250*bb + 200*bc <= 4000;
constraint 2*bb <= 6;
constraint 75*bb + 150*bc <= 2000;
constraint 100*bb + 150*bc <= 500;
constraint 75*bc <= 500;

solve maximize 450*bc + 400*bb;

output["bb = ",show(bb), "\nbc = ", show(bc)];