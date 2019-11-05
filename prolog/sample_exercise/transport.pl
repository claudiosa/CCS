/*
Example of exercise: 
Different subtasks to travel from one city to another.
*/
%Database:
boat(tallinn, helsinki, 120).
boat(tallinn, stockholm, 480).
bus(tallinn, riia, 300).
train(riia, berlin, 680).
plane(tallinn, helsinki, 30).
plane(helsinki, paris, 180).
plane(paris, berlin, 120).
plane(paris, tallinn, 120).

/*
1. Write recursive rule travel/2 to find if it is possible to travel from one city to another. finding a connection may require to combine different transportation.(e.g bus + plane + train)
- travel(From, To).
*/

travel(From, To) :- 
        trip(From, To, Dist),
        format("\n From => ~w \t To => ~w \t Cost: ~d", [From, To, Dist]). 

direct(X,Y,D) :-  boat(X,Y,D) ;  
                  bus(X,Y,D) ;
                  train(X,Y,D) ;
                  plane(X,Y,D) .


trip(X,Y,D) :- direct(X,Y,D).
trip(X,Y,D) :- direct(X,Z,D1), 
               trip(Z,Y,D2),
               D is (D1+D2).


/*
?- ['transport.pl'].
true.
?- travel(paris,X).

 From => paris 	 To => berlin 	 Cost: 120
X = berlin ;

 From => paris 	 To => tallinn 	 Cost: 120
X = tallinn ;
........
*/


