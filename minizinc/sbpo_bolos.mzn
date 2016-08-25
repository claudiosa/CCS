var 0..100: bc; %Bolo de chocolate: N1
var 0..100: bb; %Bolo de banana: N2

constraint 
   250*bb + 200*bc <= 4000;

constraint 
   2*bb <= 6;

constraint 
   75*bb + 150*bc <= 2000;

constraint 
   100*bb + 150*bc <= 500;

constraint 
   75*bc <= 500;

solve maximize (4500*bc + 4000*bb);

output[" Choc = ", show(bc), "\t Ban = ",show(bb)];