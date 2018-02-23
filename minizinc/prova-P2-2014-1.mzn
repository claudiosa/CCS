%P_2 : \langle  x < y, z < y; x \in \{1, 2, 3, 4\}, y \in \{3, 4\}, z \in \{2, 3, 4\} \rangle $  \\


var 1  .. 4 : x;
var 3  .. 4 : y;
var 2  .. 4 : z;

constraint
     x <  y /\
     z <  y
     ;

solve ::
    int_search(
    [x,y,z],%% Explore it
    %% Variable Choice
    first_fail,
    %largest, %smallest,  %input_order %first_fail,
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Domain Choice
    indomain_min, 
    %indomain_split,
		complete
	)
	satisfy;


output	["P2: CP version:\n" ++
         "   X: "  ,  show(x),
         "   Y: "  , show(y) ,
         "   Z: "  , show(z) ,
         "\n" ];

/*
Compiling prova-P2-2014-1.mzn
Running prova-P2-2014-1.mzn
P2: CP version:
   X: 1   Y: 3   Z: 2
----------
P2: CP version:
   X: 2   Y: 3   Z: 2
----------
P2: CP version:
   X: 1   Y: 4   Z: 2
----------
P2: CP version:
   X: 2   Y: 4   Z: 2
----------
P2: CP version:
   X: 3   Y: 4   Z: 2
----------
P2: CP version:
   X: 1   Y: 4   Z: 3
----------
P2: CP version:
   X: 2   Y: 4   Z: 3
----------
P2: CP version:
   X: 3   Y: 4   Z: 3
----------
==========
*/

