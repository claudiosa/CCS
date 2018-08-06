// Caminhante Bêbado
// -----------------
// A cada passo em seu caminho, às vezes pende a um lado, e às vezes ao outro.

size(200, 200);
int x = 10;
int y = 100;

for (int i = 0; i < 30; i++) {
  float moeda = random(-1,1);

  if (moeda > 0) {
    stroke(255);
    //x+=5 == x = x+5
    //x = x+5;
    //y = y+5;
    line(x, y, x = x+5, y = y+5 );
    ellipse(x, y, 2, 2);
  } else {
    stroke(0);
    line(x, y, x+=5, y-=5);
    ellipse(x, y, 2, 2);
  }
}
