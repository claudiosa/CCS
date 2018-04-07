#include "pilha_realloc.h"

// vir como paramento MAX
tipo_pilha * inicializa_pilha (void)
{   
	// aqui criada dinamicamente
    // APENAS o ponteiro para ESTRUTURA
    tipo_pilha * P = (tipo_pilha *) malloc( sizeof(tipo_pilha *) );
    if (P == NULL) 
    {
        printf("\n Erro! PILHA NAO CRIADA ....\n");
        getchar();
        exit(0);
    }
    // VIA P vai instanciando valores a PILHA
    P -> topo = -1 ; // para comecar a pilha com 0
    P -> tam_MAX =  1; // poderia ser maior ... 
    // TAMANHO MINIMO .... alocar 1 inicialmnete
    // UMA PILHA COM 1 ESPACO APENAS....
    P -> entradas = (char *) malloc((P -> tam_MAX)*sizeof(char) );
	if (P -> entradas == NULL)                     
    {
        printf("\n Erro! Memoria NAO alocada.\n");
        exit(0);
    }
  return (P);
} // comece em 0 se for o caso





// aumentar dinamicamente a pilha sob demanda
void aumenta_pilha(tipo_pilha * P)
{
 P -> tam_MAX = (P -> tam_MAX) * 2; // uma heuristica aqui
 //dobrando o espaço existente....
 P -> entradas = (char *) realloc(P -> entradas, (P -> tam_MAX) * sizeof(char) );
  printf(" ** "); // apenas para ver  esta chamada
} 


// Adicionar x na pilha
void push(char x, tipo_pilha * P)
{
  if (pilha_cheia (P)) /* voltando 1 ou true se estiver estah cheia */
     aumenta_pilha( P );
  // AQUI A DIFERENCA do push anterior....    
   
  // apos o incremento insere ... 
   ++ (P -> topo); // cuidar ... se ja se esta incrementando
  // entao nao vai usar a posicao 0
   *( P -> entradas + (P -> topo) ) = x;
    
   printf("\t ||PUSH:: %c, TOPO:: %d", 
   *( P -> entradas + (P -> topo) ) , P->topo);
    
  return;
}   /* fim da funcao push */

// Remover do topo ...
void pop (char * x, tipo_pilha * P)
{
   if ( pilha_vazia ( P ))
   /* voltando 1 ou true se estiver estah vazia */
   { printf("\n A PILHA ESTAH VAZIA ");
     getchar();
     return;
	}
	 // CUIDAR .... x novamente retorno por referencia PONTEIRO
   // se nao for por referencia ... usar *(....)
	 x  = ( P ->  entradas + (P -> topo) );
	  printf("\t ||POP:: %c, TOPO:: %d", 
	  *( P -> entradas + (P -> topo) ) , P->topo);
    // ajusta topo
	 -- (P -> topo);
	 return;
 }   /* fim da funcao pop */


int pilha_cheia  (tipo_pilha * P)
{ /* estarah cheia se o topo for maior que o maximo - 1 permitido...
     entao retorna TRUE ou 1
  */
 return( P -> topo > (P -> tam_MAX) );
 // ou  P -> topo == (P -> (tam_MAX-1)
 /* FALSE ==> 0
    TRUE ===> 1
    LEMBRAR SEMPRE
 */
}
int pilha_vazia  (tipo_pilha * P)
{ /* estarah vazia se o topo for menor que 0...
     entao retorna TRUE ou 1   */
 return( P -> topo < 0 ); // <= 0 se for o caso
 // ou ( P -> topo == -1 )
 /* FALSE ==> 0
    TRUE ===> 1
    LEMBRAR SEMPRE
 */
}


void destroi_pilha ( tipo_pilha * P )
 {
	 if(P)
	 { if (P -> entradas)
		 free(P -> entradas);
	   
      free(P); //AQUI PERDE A REFERENCIA DELA
 	    printf("\n Pilha Desalocada com SUCESSO\n"); 

	 }
	 else
	 printf("\n Pilha INEXISTENTE\n"); 	 
    
 } 
/**************************************************/
