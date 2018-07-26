  
void setup() {
  size(200, 200); 
} 

void draw() {
  background(#12E0E7);
  int x=50, y=50;
  if (mousePressed == true) {
    fill(#E712BC); //Veja no Geany
  } else {
    fill(0); // Black
  }
  rect(x, y, 90, 90); 
  /*
  seguem uma logica ...
  */
}
