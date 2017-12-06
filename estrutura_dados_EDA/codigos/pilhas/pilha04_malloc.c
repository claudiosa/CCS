#include <stdio.h>
#include <stdlib.h>

// ALOCACAO SEMI-ESTATICA
// EM ESTUDO
typedef struct 
	{
	  int topo ;
	  int tam_MAX;
	  char * pt_entradas;
	}  tipo_pilha ;

/*
OU Diretamente
struct 
  {
    int topo ;
    int tam_MAX;
    char * pt_entradas;
  }  tipo_pilha ;

*/  

// ESTAS E OUTRAS FUNCOES PODEM IR PARA UM PILHA.H
int pilha_cheia  (tipo_pilha * P);
int pilha_vazia  (tipo_pilha * P);

// Adicionar x na pilha
void push(char x, tipo_pilha * P)
{
   if ( pilha_cheia ( P ))
   /* voltando 1 ou true se estiver estah cheia */
   { printf("\n A PILHA ESTAH CHEIA ");
     getchar();
     return;
    } /* ou seja ... entrada[1] vai ter o 1o. elemento
         empilhado... estamos perdendo entrada[0]... */
    ++ (P -> topo); // cuidar ... se ja se esta incrementando
    // entao nao vai usar a posicao 0
    *( P -> pt_entradas + (P -> topo) ) = x;
    
    printf("\t ||PUSH:: %c, TOPO:: %d", 
     *( P -> pt_entradas + (P -> topo) ) , P->topo);
    
    return;
  } /* fim da funcao push */

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
	 x  = ( P -> pt_entradas + (P -> topo) );
	  printf("\t ||POP:: %c, TOPO:: %d", 
	  *( P -> pt_entradas + (P -> topo) ) , P->topo);
    // ajusta topo
	 -- (P -> topo);
	 return;
 }   /* fim da funcao pop */


int pilha_cheia  (tipo_pilha * P)
{ /* estarah cheia se o topo for maior que o maximo - 1 permitido...
     entao retorna TRUE ou 1
  */
 return( P -> topo >= (P -> tam_MAX) );
 /* FALSE ==> 0
    TRUE ===> 1
 */
}
int pilha_vazia  (tipo_pilha * P)
{ /* estarah vazia se o topo for menor que 0...
     entao retorna TRUE ou 1   */
 return( P -> topo < 0 ); // <= 0 se for o caso
 // ou ( P -> topo == -1 )
 /* FALSE ==> 0
    TRUE ===> 1
 */
}
// vir como paramento MAX
void inicializa_pilha ( tipo_pilha * P)
{   P -> topo = -1 ; // para comecar a pilha com 0
	//X -> tam_MAX =  JA INICIALIZADO na leitura
	// mas fica como opcao aqui ...
	P -> pt_entradas = (char *) malloc( (P -> tam_MAX) * sizeof(char) );
	if (P -> pt_entradas == NULL)                     
    {
        printf("\n Erro! Memoria NAO alocada.\n");
        exit(0);
    }
 
} // comece em 0 se for o caso


void destroi_pilha ( tipo_pilha * P )
 {
	 if(P)
	 { if (P -> pt_entradas)
		 free(P -> pt_entradas);
	  //free(P); AQUI PERDE A REFERENCIA DELA
	 printf("\n Pilha Desalocada com SUCESSO\n"); 
	 }
	 else
	 printf("\n Pilha INEXISTENTE\n"); 	 
    
 } 
/**************************************************/
