#include "fila_00.h"

// CONSTRUA AS FUNCOES AQUI ...
fila * cria_fila ( int C )
{
	fila * FILA = malloc(sizeof (struct STRUCT_FILA));

	//(typedef fila) ); devia ter funcionado
	FILA -> capacidade = C ; // veio do parametro
	FILA -> front = -1 ;
	FILA -> rear = -1 ;
	// CUIDAR NA ENTRADA O TIPO DA FILA
	// troque o char por inteiro
	FILA -> entrada = malloc(FILA -> capacidade * sizeof(char) );
  // MUDE AQUI PARA ENTRADA DE inteiro
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
	printf("\n VARIAVEL capacidade %d\n", FILA -> capacidade );
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
 }

int tamanho_fila ( fila * F ) // quantos tem no momento
 { // Faca o desenho e calculo aqui ...
   // e encontre outras expressoes para esta formula
  if( fila_vazia ( F ) )
  return 0;
  if( fila_cheia ( F ) )
  return F -> capacidade;
  else
  {	 // PRECISA SER MELHORADO
    //(F-> rear - F-> front + 1) : Veja a figura
   int tam = (F -> capacidade + (F-> rear - F-> front + 1)) % F -> capacidade ;
   return ( tam ) ;
  }
 }

// INSERIR NA FILA enqueue ou Push
// CUIDAR com o tipo char x
void chegada ( char x, fila * F )
{
	if ( fila_cheia ( F ))
	/* voltando 1 ou true se estiver estah cheia */
	{
	  printf("\n A FILA ESTAH CHEIA ");
	  getchar();
      //exit();
	}
  /* NOVO FINAL DA FILA: incrementa fila (+1) e modulo C */
  /* Incrementa ao final da fila ... sentido:
      0:1:2... :N-2:N-1:0:1:2.... */
 else
	{
	 F -> rear =  ((F -> rear) + 1) % F -> capacidade  ;
	 F -> entrada [ F -> rear ] = x;
	 if( F-> front == -1) // so na 1a. VEZ
	 	F-> front = F -> rear ; // FILA ESTAVA VAZIA

     // comente se for caso
	 printf("\nFRONT: %c | POS: %d || REAR: %c | POS: %d",
	 	F->entrada[F->front], F->front,
	 	F->entrada[F->rear], F->rear);

   }
	 return;
  } /* fim da funcao de chegada */


// retira o primeiro da fila -- POP e ou DEQUEUE
// CUIDAR com o tipo char x
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
	// comente se for caso
	 printf("\nFRONT: %c : %d || REAR: %c : %d",
	 	F->entrada[F->front], F->front,
	 	F->entrada[F->rear], F->rear);
        // fila SO tinha UM elemento
    if((F -> front) == (F -> rear))
    	 (F -> front) = (F -> rear) = -1;
      else
      {
	   /* Pega o proximo da fila ... sentido de 0:1:2... :N-2:N-1:0:1:2.... */
	    F -> front =  ((F -> front) + 1) % (F -> capacidade)  ;
	    }
      return retorno;
    }
  }  /* fim da funcao chegada */

void destroi_fila( fila *F)
{
 if(F) {
   if( F -> entrada )
   	{
			free( F -> entrada );
      free( F ); // no inteiro
    }
    else
    {
     printf("\n FILA NAO LIBERADA\n" );
     }
    printf("\n FILA LIBERADA OK\n" );
	}
  return;
	}

void mostra_fila( fila *F )
{
    int i;
    if( fila_vazia(F) )
        printf("\n Fila Vazia\n");
    else
    {
	       puts("\n FILA SE ENCONTRA ASSIM .....");
	       printf("\n Front ou cabeca : %d ", F -> front);
	       printf("\t Rear ou ultimo :  %d ", F-> rear);
	       printf("\n CONTEUDO da FILA : ");
	       for(i = F ->front ; i != F -> rear ; i = (i+1) % F->capacidade )
	      {
	      	printf("%c ", F->entrada[i]);
	      }
     }
}
