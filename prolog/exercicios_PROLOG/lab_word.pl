
%%% :-use_module(library(bounds)).
y:- all_different( 6, 8).
%%% Aqui nossas palavras - dicionario -- Vem do problema
word(abalone , a,b,a,l,o,n,e)  .
word(abandon , a,b,a,n,d,o,n)  .
word(enhance , e,n,h,a,n,c,e)  .
word(anagram , a,n,a,g,r,a,m)  .
word(connect , c,o,n,n,e,c,t)  .
word(elegant , e,l,e,g,a,n,t)  .


use_module(library(bounds)).
/*** ainda INEFICIENTE .... */

cross((PH1, PH2, PH3, PV1, PV2, PV3  )) :-

/* Declarando dominbios e variaveis */
     word(PH1, _, H12 , _ , H14,  _ , H16, _),
     word(PH2, _, H22 , _ , H24,  _ , H26, _),
     word(PH3, _, H32 , _ , H34,  _ , H36, _),
     
     word(PV1, _, V12 , _ , V14,  _ , V16, _),
     word(PV2, _, V22 , _ , V24,  _ , V26, _),
     word(PV3, _, V32 , _ , V34,  _ , V36, _),

/* Restricoes e contorno do problema */     
     H12 == V12, H14 == V22, H16 == V32,
     H22 == V14, H24 == V24, H26 == V34,     
     H32 == V16, H34 == V26, H36 == V36.
           
x :- cross((PH1, PH2, PH3, PV1, PV2, PV3  )) ,
     nl, write(' HORIZONTAIS: '), write(PH1),  write(' '),  
     write(PH2),  write(' '),   write(PH3),                     
     nl,  write(' VERTICAIS: '), write(PV1),  write(' '),  
     write(PV2),  write(' '),   write(PV3).       
 
x .

x :- true  .

 
                   
