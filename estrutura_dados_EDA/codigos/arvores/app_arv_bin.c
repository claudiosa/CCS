 // Definicao de arv_bin011.h
#include "arv_bin.h"
#define K 7

int main(void)
   {
      
      int ch;
      /* criar um ponteiro de arvore .... */
      BIN_TREE *pt_TREE, *AUX;
      pt_TREE = NULL; // aqui sim,  interessante ... VAZIA

      lendo_dados( & pt_TREE ); // HEADER da arvore ... POR REF
      printf("\n ARVORE CORRENTE: \n");  
      printPreorder( pt_TREE );
      
    
    do{

    printf("\n  --- OPERAÇÕES em ABBs  ---");
    printf("\n1 - Insere um elemento na arvore\n");
    printf("2 - Exclui um elemento na arvore\n");
    printf("3 - Inorder Traversal -- Varredura\n");
    printf("4 - Preorder Traversal\n");
    printf("5 - Busca por Chave\n");
    printf("6 - NUMERO DE NOSH:\n");
    printf("7 - ALTURA da ARVORE:\n");
    printf("8 - Postorder Traversal -- Varredura\n");
    printf("11 - COOL TREE\n");
    printf("9 - Exit\n");
    
    // opocoes
        printf("\nEnter your choice : ");
        limpeza_teclado();
  /*************************************************/
	    scanf("%d", &ch);
	    printf("\n  Opcao lida %d : ", ch);
        switch (ch)
        {
        case 1:
             { DATA_TREE INFO;
			   printf("\n Insercao: digite a chave e uma cidade: ");	 
			   scanf("%d", & INFO.UMA_CHAVE);   	  
			   scanf("%s" , INFO.UM_NOME);
			   // OUTRO INSERT ... ITERATIVO este
	           pt_TREE = InsertTree_BIN( pt_TREE, INFO );
               break;
	  	    }
        case 2:    
             { int INFO;
			   printf("\n Exclusao: digite a chave: ");	 
			   scanf("%d", & INFO );   	  
			   pt_TREE = remove_NOH_ABB( pt_TREE , INFO );
               break;
	  	     }
	  	    
        case 3:    
            printInorder( pt_TREE );
            limpeza_teclado();
            getchar();
            break;
  
        case 4:    
            printPreorder( pt_TREE );
            limpeza_teclado();
            getchar();
            break;
  
        case 8:    
            printPosorder( pt_TREE );
            limpeza_teclado();
            getchar();
            break;
        
        case 11:    
			print2DUtil( pt_TREE , 0);
			limpeza_teclado();
            getchar();
            break;
        
        case 5:    
            {int ALVO;
			printf("\n Digite uma chave : ");
			scanf("%d", & ALVO) ;
			//printf("\n Chave : %d", ALVO);
			AUX = pt_TREE ;
			//AUX = search_basic ( AUX, ALVO ) ; // OK
			AUX = TreeSearch_ITERATIVO ( AUX, ALVO ); 
            //AUX = iterative_search_basic  ( AUX , ALVO); /
            if( AUX != NULL )
            print_NODE (AUX ) ; // noh existe
            else
            {
			printf("\n A chave : %d nao esta na arvore !!!!", ALVO);	
			}
            break;
	     	}
	     	
        case 6:    
            printf("\n NUMERO DE NOSH: %d", num_nos_ABB( pt_TREE) ); 
            break;
            
        case 7:    
            printf("\n ALTURA da ARVORE: %d", altura_ABB( pt_TREE) ); 
            break;
            
        case 9:
          {    
		 // system("clear");     
		// FINALIZANDO -- AGORA OK
		if ( deltree_TRUE ( &pt_TREE ) == (0 || 1) )
		   printf("\n FIM: ARVORE LIBERADA OK \n");  
		   else 
		   printf("\n FIM:  ARVORE NAO LIBERADA -- call Houston ");  
			//  deltree( pt_TREE );
            printf("\n NUMERO DE NOSH: %d\n", num_nos_ABB( pt_TREE) ); 
		    //exit(0);      
		    break;
          }
          
        default :     
             printf("Wrong choice, Please enter correct choice:  %d", ch);
            break;    
        }
      system("clear");    
    } while( ch != 9);
    
  
return 1;
  
 }

