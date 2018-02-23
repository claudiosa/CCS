%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%								%%
%%     	Alunos: Mário César Borba				%%
%%		Tânia Mara Moreno				%%
%%								%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



:- lib(ic).

peso(avanilde,90,1).
peso(bernardo,80,1).
peso(claudio,60,1).
peso(damiani,40,1).
peso(mantimento,20,0).

%%condicao de parada.
go( state(esquerda,esquerda,esquerda,esquerda, esquerda, esquerda), state(direita,direita,direita,direita, direita, direita) ).

 x  :- inicio(state(esquerda,esquerda,esquerda,esquerda,esquerda, esquerda),state(direita,direita,direita,direita,direita, direita)),
  write('Travessia não efetuada!!!\n') ;
  write('Termino da travessia!!!\n').
  		
  inicio(Largada , Destino):- caminho(Largada,Destino,[Largada],Caminho),
                              write('Resposta:\n'),
                              write_caminho(Caminho).  
  
  caminho(Largada,Destino,CaminhoVisitado,Caminho):-
        movimento(Largada,NextState),  
       	not( membro(NextState,CaminhoVisitado) ), 
		caminho( NextState,Destino,[NextState|CaminhoVisitado],Caminho),!.
  caminho(Destino,Destino,Caminho,Caminho).	%%condição de parada.
    
%%travessias possíveis.
   movimento(state(X,X,X,X,X, X), state(Y,Y,Y,Y,Y, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(bernardo,P2,R2), peso(claudio,P3,R3), peso(damiani,P4,R4), peso(mantimento,P5,R5),(P1+P2+P3+P4+P5) =< 100, (R1+R2+R3+R4+R5) > 0.

   movimento(state(A,X,X,X,X, X), state(A,Y,Y,Y,Y, Y)):- oposto(X,Y), peso(bernardo,P1,R1), peso(claudio,P2,R2) , peso(damiani,P3,R3),peso(mantimento,P4,R4),(P1+P2+P3+P4) =< 100, (R1+R2+R3+R4) > 0.
   movimento(state(X,B,X,X,X, X), state(Y,B,Y,Y,Y, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(claudio,P2,R2) , peso(damiani,P3,R3),peso(mantimento,P4,R4),(P1+P2+P3+P4) =< 100, (R1+R2+R3+R4) > 0.
   movimento(state(X,X,C,X,X, X), state(Y,Y,C,Y,Y, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(bernardo,P2,R2), peso(damiani,P3,R3),peso(mantimento,P4,R4),(P1+P2+P3+P4) =< 100, (R1+R2+R3+R4) > 0.
   movimento(state(X,X,X,D,X, X), state(Y,Y,Y,D,Y, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(bernardo,P2,R2), peso(claudio,P3,R3),peso(mantimento,P4,R4),(P1+P2+P3+P4) =< 100, (R1+R2+R3+R4) > 0.
   movimento(state(X,X,X,X,M, X), state(Y,Y,Y,Y,M, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(bernardo,P2,R2), peso(claudio,P3,R3),peso(damiani,P4,R4),   (P1+P2+P3+P4) =< 100, (R1+R2+R3+R4) > 0.
        
   movimento(state(A,X,X,X,M, X), state(A,Y,Y,Y,M, Y)):- oposto(X,Y), peso(bernardo,P1,R1), peso(claudio, P2,R2), peso(damiani,P3,R3),   (P1+P2+P3) =< 100, (R1+R2+R3) > 0.
   movimento(state(A,X,X,D,X, X), state(A,Y,Y,D,Y, Y)):- oposto(X,Y), peso(bernardo,P1,R1), peso(claudio, P2,R2), peso(mantimento,P3,R3),(P1+P2+P3) =< 100, (R1+R2+R3) > 0.
   movimento(state(A,X,C,X,X, X), state(A,Y,C,Y,Y, Y)):- oposto(X,Y), peso(bernardo,P1,R1), peso(damiani, P2,R2), peso(mantimento,P3,R3),(P1+P2+P3) =< 100, (R1+R2+R3) > 0.
   movimento(state(A,B,X,X,X, X), state(A,B,Y,Y,Y, Y)):- oposto(X,Y), peso(claudio, P1,R1), peso(damiani, P2,R2), peso(mantimento,P3,R3),(P1+P2+P3) =< 100, (R1+R2+R3) > 0.
   movimento(state(X,B,C,X,X, X), state(Y,B,C,Y,Y, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(damiani, P2,R2), peso(mantimento,P3,R3),(P1+P2+P3) =< 100, (R1+R2+R3) > 0.
   movimento(state(X,B,X,X,M, X), state(Y,B,Y,Y,M, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(claudio, P2,R2), peso(damiani,P3,R3),   (P1+P2+P3) =< 100, (R1+R2+R3) > 0.
   movimento(state(X,B,X,D,X, X), state(Y,B,Y,D,Y, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(claudio, P2,R2), peso(mantimento,P3,R3),(P1+P2+P3) =< 100, (R1+R2+R3) > 0.
   movimento(state(X,X,C,D,X, X), state(Y,Y,C,D,Y, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(bernardo,P2,R2), peso(mantimento,P3,R3),(P1+P2+P3) =< 100, (R1+R2+R3) > 0.
   movimento(state(X,X,C,X,M, X), state(Y,Y,C,Y,M, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(bernardo,P2,R2), peso(damiani,P3,R3),   (P1+P2+P3) =< 100, (R1+R2+R3) > 0.
   movimento(state(X,X,X,D,M, X), state(Y,Y,Y,D,M, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(bernardo,P2,R2), peso(claudio,P3,R3),   (P1+P2+P3) =< 100, (R1+R2+R3) > 0.
    
   movimento(state(A,X,X,D,M, X), state(A,Y,Y,D,M, Y)):- oposto(X,Y), peso(bernardo,P1,R1), peso(claudio,P2,R2),   (P1+P2) =< 100, (R1+R2) > 0.
   movimento(state(A,X,C,X,M, X), state(A,Y,C,Y,M, Y)):- oposto(X,Y), peso(bernardo,P1,R1), peso(damiani,P2,R2),   (P1+P2) =< 100, (R1+R2) > 0.
   movimento(state(A,X,C,D,X, X), state(A,Y,C,D,Y, Y)):- oposto(X,Y), peso(bernardo,P1,R1), peso(mantimento,P2,R2),(P1+P2) =< 100, (R1+R2) > 0.
   movimento(state(A,B,X,X,M, X), state(A,B,Y,Y,M, Y)):- oposto(X,Y), peso(claudio, P1,R1), peso(damiani,P2,R2),   (P1+P2) =< 100, (R1+R2) > 0.
   movimento(state(A,B,X,D,X, X), state(A,B,Y,D,Y, Y)):- oposto(X,Y), peso(claudio, P1,R1), peso(mantimento,P2,R2),(P1+P2) =< 100, (R1+R2) > 0.
   movimento(state(A,B,C,X,X, X), state(A,B,C,Y,Y, Y)):- oposto(X,Y), peso(bernardo,P1,R1), peso(mantimento,P2,R2),(P1+P2) =< 100, (R1+R2) > 0.
   movimento(state(X,B,X,D,M, X), state(Y,B,Y,D,M, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(claudio,P2,R2),   (P1+P2) =< 100, (R1+R2) > 0.
   movimento(state(X,B,C,X,M, X), state(Y,B,C,Y,M, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(damiani,P2,R2),   (P1+P2) =< 100, (R1+R2) > 0.
   movimento(state(X,B,C,D,X, X), state(Y,B,C,D,Y, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(mantimento,P2,R2),(P1+P2) =< 100, (R1+R2) > 0.
   movimento(state(X,X,C,D,M, X), state(Y,Y,C,D,M, Y)):- oposto(X,Y), peso(avanilde,P1,R1), peso(bernardo,P2,R2),  (P1+P2) =< 100, (R1+R2) > 0.
   
   movimento(state(A,X,C,D,M, X), state(A,Y,C,D,M, Y)):- oposto(X,Y), peso(bernardo,P1,R1),  P1 =< 100, (R1) > 0.
   movimento(state(A,B,X,D,M, X), state(A,B,Y,D,M, Y)):- oposto(X,Y), peso(claudio,P1,R1),   P1 =< 100, (R1) > 0.
   movimento(state(A,B,C,X,M, X), state(A,B,C,Y,M, Y)):- oposto(X,Y), peso(damiani,P1,R1),   P1 =< 100, (R1) > 0.
   movimento(state(A,B,C,D,X, X), state(A,B,C,D,Y, Y)):- oposto(X,Y), peso(mantimento,P1,R1),P1 =< 100, (R1) > 0.
   movimento(state(X,B,C,D,M, X), state(Y,B,C,D,M, Y)):- oposto(X,Y), peso(avanilde,P1,R1),	 P1 =< 100, (R1) > 0.    
  
      
  oposto(esquerda,direita).
  oposto(direita,esquerda).
  
  membro(X,[X|_]):-!.
  membro(X,[_|L]):-membro(X,L).

  write_caminho( [H1,H2|T] ) :-
        write_movimento(H1,H2),
        write_caminho([H2|T]).
  write_caminho( [] ).

%%imprime travessias.
  write_movimento( state(X,B,C,D,M, X), state(Y,B,C,D,M,Y) ) :-!,
        write('Avanilde atravessou o rio '), 

	write(' da '),write(X), write(' para '),write(Y), nl.
 
  write_movimento( state(A,X,C,D,X, X), state(A,Y,C,D,Y,Y) ) :-!,
        write('Bernardo e mantimento atravessaram o rio '), 

	write(' da '), write(X), write(' para '),write(Y), nl.
	
  write_movimento( state(A,B,X,X,M, X), state(A,B,Y,Y,M,Y) ) :-!,
        write('Claudio e Damiani atravessaram o rio '), 

	write(' da '), write(X), write(' para '),write(Y), nl.
	
  write_movimento( state(A,B,X,D,X, X), state(A,B,Y,D,Y,Y) ) :-!,
        write('Claudio e Mantimento atravessaram o rio '), 

	write(' da '), write(X), write(' para '),write(Y), nl.
	
  write_movimento( state(A,B,C,X,X, X), state(A,B,C,Y,Y,Y) ) :-!,
        write('Damiani e Mantimento atravessaram o rio '), 

	write(' da '), write(X), write(' para '),write(Y), nl.
	
  write_movimento( state(A,X,C,D,M, X), state(A,Y,C,D,M,Y) ) :-!,
        write('Bernardo atravessou o rio '), 

	write(' da '), write(X), write(' para '),write(Y), nl.
  
  write_movimento( state(A,B,X,D,M, X), state(A,B,Y,D,M,Y) ) :-!,
        write('Claudio atravessou o rio '), 

	write(' da '), write(X), write(' para '),write(Y), nl.
  
  write_movimento( state(A,B,C,X,M, X), state(A,B,C,Y,M,Y) ) :-!,
        write('Damiani atravessou o rio '), 

	write(' da '), write(X), write(' para '),write(Y), nl.	

/*--------------------------------------------------------------*/

/*
?- x.
Yes (0.03s cpu)
Resposta:
Bernardo e mantimento atravessaram o rio  da direita para esquerda
Bernardo atravessou o rio  da esquerda para direita
Claudio e Damiani atravessaram o rio  da direita para esquerda
Damiani e Mantimento atravessaram o rio  da esquerda para direita
Bernardo e mantimento atravessaram o rio  da direita para esquerda
Claudio e Mantimento atravessaram o rio  da esquerda para direita
Claudio e Damiani atravessaram o rio  da direita para esquerda
Bernardo atravessou o rio  da esquerda para direita
Bernardo e mantimento atravessaram o rio  da direita para esquerda
Claudio atravessou o rio  da esquerda para direita
Avanilde atravessou o rio  da direita para esquerda
Bernardo e mantimento atravessaram o rio  da esquerda para direita
Claudio atravessou o rio  da direita para esquerda
Claudio e Damiani atravessaram o rio  da esquerda para direita
Bernardo e mantimento atravessaram o rio  da direita para esquerda
Bernardo atravessou o rio  da esquerda para direita
Claudio e Damiani atravessaram o rio  da direita para esquerda
Damiani e Mantimento atravessaram o rio  da esquerda para direita
Bernardo e mantimento atravessaram o rio  da direita para esquerda
Claudio e Mantimento atravessaram o rio  da esquerda para direita
Claudio e Damiani atravessaram o rio  da direita para esquerda
Bernardo atravessou o rio  da esquerda para direita
Bernardo e mantimento atravessaram o rio  da direita para esquerda
Termino da travessia!!!
*/
