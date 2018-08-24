// Caminhante Bêbado
// -----------------
// A cada passo em seu caminho, às vezes pende a um lado, e às vezes ao outro.

size(400, 400);
int x = 10;
int y = 100;
// LACO
for (int i = 0; i < 30; i = i+1)
{
  float moeda = random(-1,1);
  if (moeda > 0) 
  {
    //   stroke(255);
     stroke(35, 225, 30); // VERDE
     fill(0);
    //x+=5 == x = x+5
    //x = x+5;
    //y = y+5;
    line(x, y, x = x+10, y = y+10 );
    ellipse(x, y, 5, 5);
  } else 
  {
    stroke(0);
    line(x, y, x=5+x, y =  y - 5);
    ellipse(x, y, 2, 2);
  }
}
