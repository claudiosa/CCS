#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h> // bool no C

 struct STRUCT_FILA
  {
    int  front ;  		/*  or first */
    int  rear ;	  		/*  or last */
    int  capacidade ; 		 	
	//char entradas[ MAX_FILA ];
	char * entrada ;	
};
// e ainda
typedef  struct STRUCT_FILA  fila ;
// usados antes da definicao
	bool  fila_cheia  ( fila * F);
	bool  fila_vazia  ( fila * F);
	int tamanho_fila ( fila * F );

fila * cria_fila (  int C )
{ 	
	fila * FILA = malloc(sizeof (struct STRUCT_FILA));
	//(typedef fila) ); devia ter funcionado
	FILA -> capacidade = C ; // veio do parametro
	FILA -> front = -1 ;
	FILA -> rear = -1 ;
	// cuidar na entrada o tipo da fila
	FILA -> entrada = malloc(FILA -> capacidade * sizeof(char) );
	if(FILA -> entrada == NULL)
	{
	  printf("\n Problema ao criar a FILA");
	  getchar();
	  exit(0);	
	}
	/*
	PARA FINS DE ESTUDO 
	printf("\n FILA -> capacidade : %ld" , sizeof(FILA -> capacidade ));
	printf("\n FILA -> front : %ld" , sizeof(FILA -> front ));
	printf("\n FILA -> rear : %ld" , sizeof(FILA -> rear ));
	printf("\n VARIAVEL entrada %d\n", FILA -> capacidade );
	printf("\n CONTEUDO entrada %ld\n", sizeof(FILA -> entrada ));

	printf("\n TOTAL : %ld\n" , sizeof(*FILA));
	*/
	return(FILA);
}


bool fila_vazia  ( fila * F )
{ /* estarah vazia se o  for menor que 0...
	  entao retorna TRUE ou 1 */
	if(F -> front <  0 ) // ou F -> front == -1
       return true; // NENHUM PARA REMOVER
    else
    return false; 	
}


bool fila_cheia  ( fila * F )
{ /* estarah cheia se o capacidade for >= ao maximo permitido...
	 ou se o ULTIMO + 1 for igual ao PRIMEIRO */
	if((F -> rear + 1) % (F -> capacidade) == (F -> front) )
       return true; // FILA CHEIA
    else
       return false; // TEM LUGAR	
 //(( F -> count) >= MAX_FILA );
 }


int tamanho_fila ( fila * F )
 {  // Faca o calculo aqui
	return ( 
	  (F -> capacidade - F-> front + F-> rear)
	    % F -> capacidade 
	  ) ;
 }


// INSERIR NA FILA enqueue
void chegada ( char x, fila * F )
{
	if ( fila_cheia ( F ))
	/* voltando 1 ou true se estiver estah cheia */
	{ 
	  printf("\n A FILA ESTAH CHEIA ");
	  getchar();
      //exit();	  
	}
  /* incrementa fila adiciona mais um no final... */
	else
	{	
	 F -> rear =  ((F -> rear) + 1) % F -> capacidade  ;
	 F -> entrada [ F -> rear ] = x;
	 if( F-> front == -1) // so na 1a. VEZ
	 	F-> front = F -> rear ; // FILA ESTAVA VAZIA

	 printf("\nFRONT: %c : %d || REAR: %c : %d", 
	 	F->entrada[F->front], F->front,
	 	F->entrada[F->rear], F->rear);
     
   }
	 return;
  } /* fim da funcao de chegada */


// retira o primeiro da fila
char  partida ( fila * F )
{
	char retorno;
	if ( fila_vazia ( F ) ) /*  1 ou true se estiver estah vazia */
	{ printf("\n A FILA ESTAH VAZIA ");
	  getchar();
	  return '_';  // vazio
	}
	else
	{ 
	 retorno = F -> entrada [ F -> front ];
    // imprimir aqui para pegar todo historico
	 printf("\nFRONT: %c : %d || REAR: %c : %d", 
	 	F->entrada[F->front], F->front,
	 	F->entrada[F->rear], F->rear);
    
        if((F -> front) == (F -> rear)) // fila so tinha UM elemento
    	 (F -> front) = (F -> rear) = -1;
        else
        {
	   /* atualiza novo noh-cabeca ou o proximo da fila */
	    F -> front =  ((F -> front) + 1) % F -> capacidade  ; 
	 //F -> front =  ((F -> front) + 1) % MAX_FILA ;
	    }
      return retorno; 	  
    }   	
  } 
 /* fim da funcao chegada */

void exclui_fila( fila *F)
  {
  	if(F) {
       if( F -> entrada )
       	free( F -> entrada );
       free( F );
       }
     else
        {
     printf("\n PILHA NAO LIBERADA" );
     }
    printf("\n PILHA  LIBERADA OK" );
  }
