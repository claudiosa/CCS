#include "pseudo_linguagem.h"   // inclui isto ...

ALGORITMO

inicio  // corpo do ALGO 
   float nota1, nota2, media               ;
   escreva("\n DIGITE AS DUAS NOTAS: ")    ;
   leia("%f %f",&nota1 , &nota2)           ;
   media = (nota1 + nota2) / 2             ;
   escreva("\n A Media entre %.3f e %.3f = %.3f \n",
          nota1, nota2, media)             ;
   
   quase_acabando  ;   // prepare-se e
fim  // FIM
