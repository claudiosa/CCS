#include<stdio.h>
#include<stdlib.h>
#include <ctype.h>
// original http://www.codingalpha.com/depth-first-search-algorithm-c-program/ 
// MODIFICADO by CCS
#define MAX 100
 
#define aberto 1
#define visitado 2 
 
void lendo_grafo(void);
void graph_traversal(void);
void DFS(int vertex);


void push(int vertex);
int pop(void);
int isEmpty(void);
 
// GLOBAIS ....  uma pena ... fica facil de ler neste momento
int stack[MAX];
int top = -1;
int vertices; // TOTAL DE VERTICES
int adjacent_matrix[MAX][MAX];
int vertex_status[MAX]; // abertos ou fechados
 
void imp_NUM_LETRAS(int ); 
 
int main(void)
{
      lendo_grafo();
      graph_traversal();
      return 0;
}
 
void graph_traversal(void)
{
	  int vertex; 
	  for(vertex = 0; vertex < vertices; vertex++)
	  {
		vertex_status[vertex] = aberto;
	  } 
	  printf("Entre com um NO de PARTIDA para o DFS:\t");
	  scanf("%d", &vertex);
	  printf("\n COMECANDO com o NOH: %d ou ", vertex);
	  imp_NUM_LETRAS(vertex);
	  printf("\n ============================\n");
	  DFS(vertex);
	  printf("\n fim do DFS \n");
}
 
void DFS(int vertex)
{
      int count;
      push(vertex);
      // empilha a RAIZ
      while(!isEmpty())
      {
		vertex = pop();
		// toma o topo da pilha
		if(vertex_status[vertex] == aberto)
		{ // verifica se eh no aberto
			  //printf("%3d", vertex);
			  imp_NUM_LETRAS(vertex);
			  vertex_status[vertex] = visitado;
			  // muda o status
		}
//     CUIDADO AQUI ....
        for(count = vertices - 1; count >= 0; count--)
//		for(count = 0; count < vertices ; count++)
		{
		  if((adjacent_matrix[vertex][count] == 1) && (vertex_status[count] == aberto))
		   {
			//coloca na pilha os IMEDIATOS, NAO VISITADOS ou ABERTOS
			// VIZINHOS DE VERTEX
			//a PARTIR DE VERTEX ... ou seja... os imediatos ao topo da pilha
			push(count);
		   }
		}// FIM DO FOR
      }// FIM DO WHILE 
}

// ha versoes recursivas do DFS ... mas nao eh o caso 
 
 
 void imp_NUM_LETRAS(int N)
 {
	 if(N > 26 && N < 0) // até 10 vertices...
	 {
		 printf("\n problem ... imp_NUM_LETRAS");
		 return;
	  }

	int a[26]={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}; 
	printf(" %c", toupper(a[ N ])); // ver tabela ASCII

    return;
 }  
	  	 
	 
 
 
void push(int vertex)
{
      if(top == (MAX - 1))
      {
            printf("Stack Overflow\n");
            return;
      }
      top = top + 1;
      stack[top] = vertex;
}
 
int pop(void)
{
      int vertex;
      if(top == -1)
      {
            printf("Stack Underflow\n");
            exit(1);
      }
      else
      {
            vertex = stack[top];
            top = top - 1;
            return vertex;
      }
}
 
int isEmpty(void)
{
      if(top == -1)
      {
            return 1;
      }
      else 
      {
            return 0;
      }
}
 
void lendo_grafo(void)
{
      int lin, col, maximum_edges;
      printf("Entre total de vertices:\t");
      scanf("%d ", &vertices);
      printf("\nVertices: ", vertices);
     // maximum_edges = vertices * (vertices - 1);
      for(lin = 0; lin < vertices ; lin++)
      {
		for(col = 0; col < vertices ; col++)
		{
            scanf("%d ", &adjacent_matrix[lin][col]);
         }
      }
      printf(" MATRIZ LIDA \n" );
      for(lin = 0; lin < vertices ; lin++)
      {
		for(col = 0; col < vertices ; col++)
		{
            printf(" %d", adjacent_matrix[lin][col]);
         }
        printf("\n" ); 
      }
     
      
}
