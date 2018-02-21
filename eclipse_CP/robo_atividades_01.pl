
/* 
  Um robo precisa realizar/agendar atividades: a, b, c, d , e.
  Cada atividade, {a,b,c...} ... nos tempos 1 a 4
  Precedencia de tempo, escalonados de 1 a 4. 
   .........
*/   

:- lib(ic).

t(1).
t(2). 
t(3).
t(4). 

x1 :- escalonador( Xx ), 
     nl, 
     write(Xx).

escalonador( [(a,A),(b,B),(c,C),(d,D),(e,E)] ) :-
  /*
  A: tempo da atividade a iniciar....
  B: tempo da atividade b iniciar....
  ...............................................  
  */
  
   t(A),  /* Dominio das variaveis */
   t(B), 
   t(C), 
   t(D), 
   t(E),
/* Conjunto de Restricoes:: como ocorreu
naturalmente no problema, e se modelou assim: */
   B \== 3,
   C \== 2,
   A \== B,
   B \== C,
   
   A == D,  /* duas variaveis iguais */
   C < D,
   E < A,
   E < B,
   E < C,
   E < D,
   B \== D.
     

x2 :- ver_02( Xx ),  nl,  write(Xx).

ver_02( [(a,A),(b,B),(c,C),(d,D),(e,E)] ) :-

   t(A),  /* Dominio das varieveis */
   t(B), 
   t(C), 
   t(D), 
   t(E),
   /* Conjunto de Restricoes:: como ocorreu
   naturalmente no problema, e se modelou assim: */
   C < D,
   E < A,
   E < B,
   E < C,
   E < D,
   B \== 3,
   C \== 2,
   A \== B,
   B \== C,
   A == D,  /* duas variaveis iguais */
   B \== D.
    
y :- versao_clp( Xx ), nl, write(Xx).
versao_clp( [(a,A),(b,B),(c,C),(d,D),(e,E)] ) :-

   Variaveis = [A,B,C,D,E] ,  /* lista em Prolog  */
/* Dominio das Variaveis A, B e C */
   Variaveis :: [1 .. 4],
  
   /* Conjunto de Restricoes:: como ocorreu
   naturalmente no problema, e se modelou assim: */
   A #= D,  /* duas variaveis iguais */
   C #< D,
   E #< A,
   E #< B,
   E #< C,
   E #< D,
   B #\= 3,
   C #\= 2,
   A #\= B,
   B #\= C,
   B #\= D,
   labeling(Variaveis).


/*********************************************/          
all:- x1, x2, y.
/*
[(a, 4), (b, 2), (c, 3), (d, 4), (e, 1)]
[(a, 4), (b, 2), (c, 3), (d, 4), (e, 1)]
[(a, 4), (b, 2), (c, 3), (d, 4), (e, 1)]
*/
/*********************************************/          
    
