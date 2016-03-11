  int: n = 4;
  int: m = 5;
  int: o = n + m;
  var set of int: x;
  var set of int: y;
  var set of int: z= x diff y;
  
  x = {1,2,4,6};
  y = {4,3,7,8,9};
  
  
  solve satisfy;
  
  output[show(z)];
  


