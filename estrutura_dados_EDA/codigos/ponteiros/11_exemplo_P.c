#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define Kte 100
// DOS ALUNOS
int espacos_01(char ** m, int n){
 int i,j, cont=0;
	for (i=0;i<n;i++){
		for(j=0; j < Kte ; j++){
			if(m[i][j] == ' ') 
			cont++;
		}
	}
	return cont;
}

int espacos_02(char *pt_STR){
 int j, cont=0;
 // 13 = '\n'
	for(j=0;(j < Kte && (*pt_STR != '\n') );  j++){
			if(*pt_STR == ' ') 
			cont++;
			
			pt_STR++;
		}
	return cont;
}
// ===========================================================
int main(void){

	int  n;
	scanf("%d", &n);

    char * V_P[n]; // n ponteiros em um vetor ou vetor de ponteiros
    char frases[n][Kte]; // a matriz a ser lida na entrada
    
 // EH necessário/obrigatorio para alguns sistemas
    for(int i=0;i < n; i++)
		for(int j=0;j < Kte; j++)
			frases[i][j]='\0';
    
    // allocate space for n pointers to strings
	char ** m = (char **) malloc(n * sizeof(char *));

	for(int i=0;i<n;i++){
		m[i] = malloc(Kte * sizeof (char));
	}
   
    system("clear");
	for(int i=0;i<n;i++){
    	//scanf("\n%[^\n]", m[i]); OU
		scanf("\n%[^\n]", frases[i]); 
		//scanf("%[^\n]s", frases[i]); // funciona ... mas nao neste caso
		//fgets (frases[i], Kte, stdin); ver melhor
		strcpy(m[i], frases[i]); // UMA LEITURA POR VEZ LOGO
		printf("\n m[%d]: %s", i, m[i]);
		printf("\t FRASES: %s",  frases[i]);
	}
	getchar(); // 
   // TODOS ESPACOS EM BRANCO
	printf("\n\n SOL_alunal 1: %d\n", espacos_01(m,n) );

  // INICIALIZA PONTEIROS ... cada ponteiro ha uma frase
     for(int i=0;i<n;i++){
        V_P[i] = frases[i]; // pode ser colocada na leitura
	}
	
  // CONTAR VIA PONTEIROS 1 POR VEZ por LINHA
    int total = 0;
	for(int i= 0; i < n ; i++){
        total = total + espacos_02( V_P[i] );
        printf("\n Frase %d: %d", i, espacos_02( V_P[i] ));
	}

  printf("\n SOL 2: %d\n", total);
  // fflush(stdin);
  // system("more"); // nao funciona com < pois pegar o buffer da entrada
  // getc(stdin); // nao pegar \n da entrada
printf("\n ================ STACK =========================\n");  
  for(int i= 0; i < n ; i++){
      printf("\n End de V_P[%d]: %p APONTA -> %p (%ld)", i, &V_P[i] , V_P[i], V_P[i]  );
	}
printf("\n ============== HEAP ===========================\n");
	for(int i= 0; i < n ; i++){
      printf("\n End de m[%d]: %p APONTA -> %p (%d)", i, &m[i] , m[i], m[i]  );
	}
printf("\n =========================================\n");
	return 0;
}
// ===========================================================
