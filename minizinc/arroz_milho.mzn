var 0..100: areaArroz;
var 0..100: areaMilho;
var int : lucro;

constraint 
  areaArroz <= 3;
constraint 
  areaMilho <= 4;

constraint 
  1*areaArroz + 2*areaMilho <=9;

%%% FUNCAO DE OTIMIZACAO
constraint 
   lucro == 5*areaArroz + 2*areaMilho;

%solve maximize lucro;
solve satisfy;

output ["Area Arroz: ",show(areaArroz),"\nArea Milho: ",show(areaMilho), "\nLUCRO: ",show(lucro)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
