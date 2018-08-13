void setup() {
  //int largura = 200, altura = 200; 
  size(400, 400);
  //fill(0 ,   #0000FF   );
   fill(0, 102);
  //MediumAquamarine  #66CDAA  (102,205,170)
} 

void draw() {
} // Empty draw() keeps the program running

void mousePressed() {
  int largura = 70, altura = 70; 
  rect(mouseX, mouseY, largura, altura);
}
