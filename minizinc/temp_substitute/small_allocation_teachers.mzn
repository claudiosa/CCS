
include "globals.mzn"; 

par int : n_substitutes;
par int : n_lessons;


set of int: Substitutes = 1..n_substitutes; 
set of int: Lessons = 1..n_lessons; 

%% 60 x 18 = 1280 -- max end time
array [Substitutes,1..2] of int: unavailabilities;
array [Lessons,1..2] of int: lessons ;

%%% VAR : time-table ... which substitute in which lesson
array[ Lessons ] of var Substitutes : time_table ;


constraint
    forall ( i in Lessons )
    (
     exists ( j in Substitutes )
      (
          
       ( time_table[i] = j ) <->    
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
 exists ( i, j in Lessons where i < j)
% forall ( i, j in Lessons where i < j)
  (
   ( time_table[i] = time_table[j] )   <->   
     no_overlap_lessons(lessons[i,1], lessons[i,2],
                      lessons[j,1], lessons[j,2])
  );


% no overlapping slots function
predicate  no_overlap_lessons(int: start_1, int: end_1, int: start_2, int: end_2) = 

  (end_1 <= start_2) \/ (end_2  <= start_1);



/*
constraint forall(s1, s2 in SQUARE where s1 < s2)
                 (x[s1] + s1 <= x[s2] \/
                  x[s2] + s2 <= x[s1] \/  
                  y[s1] + s1 <= y[s2] \/ 
                  y[s2] + s2 <= y[s1]);

*/
solve satisfy;


output [ show(unavailabilities) ++ "\n"++
         show(lessons) ++ "\n"++
         show(time_table)
       ] ;
