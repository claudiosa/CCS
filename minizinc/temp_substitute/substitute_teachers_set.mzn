
%%% THIS MODEL was initialized by HAKAN
/*

FOR FURTHER IMPROVEMENTS and extension....
 
￼
￼

*/
include "globals.mzn"; 

set of int: Timeslots = 1..8; %%% 1..4 -- MORNING .... 5..8 : AFTERNON
set of int: Teachers = 1..3; 

array[Teachers] of set of int: unavailble_teacher;

unavailble_teacher = [ {1,2,3,4}, 
                       {1,2,7,8}, 
                       {5,6}
                     ] ;
                     
 
set of int: ONE_DAY = 1..8;

 % Decision variables
 % Which teacher has this presentation
 array[ONE_DAY] of var Teachers: which_is_teacher;

 % Which timeslot for this presentation
 array[ONE_DAY] of var Timeslots: where_is_time;


/*

  % Which combination of teacher and timeslot for a presentation, if any
 array[Teachers, Timeslots] of var {0} union Presentations: timetable;


 constraint

   alldifferent_except_0(array1d(timetable))
   % This constraint is not needed now
   % /\ sum([timetable[t,ts]>0 | t in Teachers, ts in Presentations]) = card(Presentations)

   /\ % connect timetable and presentation_teacher and presentation_time
  forall(p in Presentations) (
     timetable[ presentation_teacher[p], presentation_time[p] ] = p
  )
 ;

*/

solve satisfy;



output [ show(which_is_teacher) ++ "\n"++
         show(unavailble_teacher)
 % "Teacher " ++ show(t) ++ " has these presentations" ++ show([p | p in Presentations where fix(presentation_teacher[p]) = t]) ++ "\n"
 % | t in Teachers
 
 
]
;