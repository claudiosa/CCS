	
// Click on the image to give it focus,
// and then press any key.

// Note: The rectangle in this example may 
// flicker as the operating system may 
// register a long key press as a repetition
// of key presses.
// fazer um size aqui
void draw() {
  if (keyPressed == true) {
    fill(0);
     rect(25, 25, 50, 50);
  } else {
    fill(255);
     rect(125, 125, 50, 50);
  }
 
}
