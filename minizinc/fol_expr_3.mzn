int: n = 3;
%%%%%%%%%%array[1..n] of var 1..3: x;
array[1..n] of var 4..6: x;
array[1..n] of var 1..3: y;
var bool : res;

constraint
       res = forall(i in 1..n) (
          x[i] > y[i]
      ) ; 

solve satisfy;

output ["  X: "  ,  show(x),"     Y: ", show(y) , "\n",
        "     res: ", show(res) , "\n"  ];
