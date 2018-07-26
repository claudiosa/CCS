// Caminhante Determinado
// ----------------------
// Cada passo seu é certo.

size(200, 200);
int x = 100;
int y = 10;

for (int i = 0; i < 30; i++) {
  stroke(0);
  line(x, y, x, y+=5);
  ellipse(x, y, 2, 2);
}
