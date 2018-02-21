%$P_1 :\langle  x <  y, x <  z; x \in  \{1, 2, 3, 4\}, y \in \{3, 4\}, z %\in \{2, 3, 4\} \rangle  $ \\


var 1  .. 4 : x;
var 3  .. 4 : y;
var 2  .. 4 : z;

constraint
     x <  y /\
     x <  z
     ;

solve ::
	int_search(
		[x,y,z],%% Explore it
    first_fail,
		%largest, %smallest,  %input_order %first_fail,
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		indomain_min, 
    %indomain_split,
		complete
	)
	satisfy;


output	["For CP version:\n" ++
         "   X: "  ,  show(x),
         "   Y: "  , show(y) ,
         "   Z: "  , show(z) ,
         "\n" ];

/*
==========
Compiling prova-P1-2014-1.mzn
Running prova-P1-2014-1.mzn
For CP version:
   X: 1   Y: 3   Z: 2
----------
For CP version:
   X: 1   Y: 3   Z: 3
----------
For CP version:
   X: 1   Y: 3   Z: 4
----------
For CP version:
   X: 2   Y: 3   Z: 3
----------
For CP version:
   X: 2   Y: 3   Z: 4
----------
For CP version:
   X: 1   Y: 4   Z: 2
----------
For CP version:
   X: 1   Y: 4   Z: 3
----------
For CP version:
   X: 1   Y: 4   Z: 4
----------
For CP version:
   X: 2   Y: 4   Z: 3
----------
For CP version:
   X: 2   Y: 4   Z: 4
----------
For CP version:
   X: 3   Y: 4   Z: 4
----------
==========

*/

