  int: n = 4;
  int: m = 5;
  int: o = n + m;
  var set of int: x;
  var set of int: y;
  var set of int: z= x diff y;
  x = {-5, -3, 2, 5};
  y = { 0, -5, 10, 8, 3 };
  
  
  solve satisfy;
  
  output[show(z)];
  


