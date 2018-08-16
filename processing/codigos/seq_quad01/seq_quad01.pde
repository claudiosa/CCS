  
  int x =10;
  int y = 100;
  int largura = 20, altura = 20;
  
  size(800 , 800 )      ;
  //stroke(35, 225, 30)   ; // cor de borda VERDE
  //fill(35, 225, 30)   ;
  strokeWeight(2)      ;  // Beastly
      
for (int conta = 0; conta < 30; conta = conta+1)
{
       rect(x,y,largura, altura)    ;
       x = x + largura + 5;
       
}      
