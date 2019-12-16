
include "globals.mzn"; 

par int : n_substitutes;
par int : n_lessons;


set of int: Substitutes = 1..n_substitutes; 
set of int: Lessons = 1..n_lessons; 

%% 60 x 18 = 1280 -- max end time
array [Substitutes,1..2] of int: unavailabilities;
array [Lessons,1..2] of int: lessons ;

%%% VAR : time-table ... which substitute in which lesson
array[ Lessons ] of var Substitutes : schedule_profs ;
var int:   Num_Subs;

constraint
    forall ( i in Lessons )
    (
     exists ( j in Substitutes )
      (
          
       ( schedule_profs[i] = j ) <->    
        (
         ( 
% the start lesson is AFTER of  the end unavailability time
           lessons[i,1] >= unavailabilities[j,2])
          \/
% the end lesson is BEFORE  of  the start unavailability time
         (lessons[i,2] <= unavailabilities[j,1])
        )  
       ) 
     );     


constraint
 forall ( i, j in Lessons where i < j)
  (
  (no_overlap_lessons(lessons[i,1], lessons[i,2],
                     lessons[j,1], lessons[j,2]) == false
  )  %%% if some overlaped lesson == true ... ===> VIOLATION
  
                                    
%  (overlap_lessons(lessons[i,1], lessons[i,2],
%                   lessons[j,1], lessons[j,2]) == true)
%% it does not works yet ....

    ->                    
   ( schedule_profs[i] != schedule_profs[j] )   
   %%% true if some lesson is overlaped
  );


constraint
   Num_Subs = nvalue(schedule_profs);
%%%function var int: nvalue(array [int] of var int: x)
%% return Returns the number of distinct values in x .


% no overlapping slots function
predicate  no_overlap_lessons(int: start_1, int: end_1, int: start_2, int: end_2) = 
   ((end_1 <= start_2) \/ (end_2  <= start_1))
  ;


predicate  overlap_lessons(int: start_1, int: end_1, int: start_2, int: end_2) = 
  (
   ((end_1 <= start_2) == true)
   \/ 
   ((end_2  <= start_1) == true)
  ) 
   %%% some of shifts time were violated
  ;



%%%%%%%%%%%%%% ALL PAR due DATA par
function par int: get_Hour_time(par int: time   )
                  = time div 60 ;


function par int: get_Min_time( par int: time )
                  = time - 60 * get_Hour_time (time) ;


%%%% all the optimization possible  
 solve satisfy;
%solve maximize  Num_Subs;
% solve minimize  Num_Subs;

output [ show(unavailabilities) ++ "\n"++
         show(lessons) ++ "\n"++
         show(schedule_profs)++ "\n Number of Substitutes: "++
         show( Num_Subs)++ "\n"++            
         "\n START Hour:" ++
         show(get_Hour_time(lessons[4,1]))++"\t Min:"++                 
         show( get_Min_time(lessons[4,1]))
         ++"\n END Hour:"++
         show(get_Hour_time(lessons[4,2]))++"\t Min:"++                 
         show( get_Min_time(lessons[4,2]))
       ] ;
