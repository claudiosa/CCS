
// modificado por CCS
// Explicando o IF....
// para habilitar o uso de mouse e outros
void setup() {
  size(300, 300);
  noStroke();
  fill(255);
}

// para habilitar o uso de mouse e outros
void draw() {
  background(129);
 // frameRate(12);
  if (mouseX < 100) {
    rect(0, 0, 100, 300); // Left
    println(mouseX + " : " + mouseY);
    } 
  else if (mouseX < 200) {
    rect(100, 0, 100, 300); // Middle
    println(mouseX + " : " + mouseY);
    } 
   else {
    rect(200, 0, 100, 300); // Right
    println(mouseX + " : " + mouseY);
  }
}
