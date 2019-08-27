



/*********************************/
	
	p(1)   .
	p(2)   .
	p(3)   .
	p(5)   .
	p(7)   .
	p(11)   .
	
	primo(Z) :- p(X), 
			    p(Y), 
			    X \== Y, 
			    Z is (X + Y) ,
			    Resto is ( Z mod 2 ),
			    Resto \== 0.
			    			    
/*********************************/	
pergunta :- primo(X), write(X), nl.

