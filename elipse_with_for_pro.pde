void setup() {
  int i, j;
  size(640, 360);
 
  for(i = 0; i< 3 ; i++)
  {
   j = i*50 + 100;
   ellipse(j, j,  155, 55);
  }
}
