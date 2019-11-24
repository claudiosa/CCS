


 include "globals.mzn"; 
 set of int: Timeslots = 1..3;
 set of int: Teachers = 1..3; 
 set of int: Presentations = 1..5;

 % Decision variables
 % Which teacher has this presentation
 array[Presentations] of var Teachers: presentation_teacher;

 % Which timeslot for this presentation
 array[Presentations] of var Timeslots: presentation_time;

 % Which combination of teacher and timeslot for a presentation, if any
 array[Teachers, Timeslots] of var {0} union Presentations: timetable;


 constraint

   alldifferent_except_0(array1d(timetable))
   % This constraint is not needed now
   % /\ sum([timetable[t,ts]>0 | t in Teachers, ts in Presentations]) = card(Presentations)

   /\ % connect timetable and presentation_teacher and presentation_time
  forall(p in Presentations) (
     timetable[presentation_teacher[p],presentation_time[p]] = p
  )
 ;



solve satisfy;



output [
  "Teacher " ++ show(t) ++ " has these presentations" ++ show([p | p in Presentations where fix(presentation_teacher[p]) = t]) ++ "\n"
  | t in Teachers
]
;