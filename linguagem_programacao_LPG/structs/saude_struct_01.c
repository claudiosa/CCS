/* 
OBJETIVO DO EXEMPLO:

1. introducao do typedef
2. uso de ponteiros acessando estruturas
3. Complete o exemplo abaixo DIAGNOSTICANDO segundo o IMC
4. Refaça-o usando um VETOR para todos alunos da sala
5. Estenda o exercicio para uso da funcao de BATIMENTO MAXIMO


   Tabela de resultados

IMC	        Categoria
Abaixo de 18,5	Subnutrido
18,5 - 24,9	Peso saudável
25,0 - 29,9	Sobrepeso
30,0 - 34,9	Obesidade Grau I
35,0 - 39,9	Obesidade Grau II (severa)
40,0 e acima	Obesidade Grau III (mórbida)
*/

#include <stdio.h>
#include <stdlib.h>

/* SAUDE: structure definition */
struct Perfil_SAUDE {
	float height; /* height in mts.cm */
	float weight; /* weight in quilos */
	float IMC; /* IMC */
	int idade;
	int BATIMENTO_CARDIACO_MAX;
};





typedef struct Perfil_SAUDE MEU_TIPO; /* new type name for stuct Perfil_SAUDE */
// MEU_TIPO analogo a int, float, etc.



/* function prototypes */
void calcula_IMC(MEU_TIPO * p);
void calcula_Max_Batimento(MEU_TIPO * p);
void imprime_SAIDA(MEU_TIPO p);





/*function main begins program execution*/
int main ( void )
{
	//struct Perfil_SAUDE pessoa; /* define one struct Perfil_SAUDE variable */
	// OU
        
        MEU_TIPO pessoa;
        
        MEU_TIPO vetor[30];

int i; // acesso via arquivo ./a.out < amostras_saude.txt 
for(i = 1; i<3; i++)
{
	printf("DIGITE SEU PESO in quilos Kg.gr: ");
	scanf("%f", &pessoa.weight);

	printf("DIGITE SUA ALTURA in mts.cm: ");
	scanf("%f", &pessoa.height);

	calcula_IMC(&pessoa);

	/* Output data to the user */
	imprime_SAIDA(pessoa);
}
/* 
	PROJETE AS RECOMENDACOES  com switch
   Tabela de resultados

IMC	Categoria
Abaixo de 18,5	Subnutrido
18,5 - 24,9	Peso saudável
25,0 - 29,9	Sobrepeso
30,0 - 34,9	Obesidade Grau I
35,0 - 39,9	Obesidade Grau II
40,0 e acima	Obesidade Grau III
*/

	return 0; /* indicates successful termination */
} /* end main */


/* calculate maximum heart rate */
void calcula_Max_Batimento(MEU_TIPO * p)
{
	p -> BATIMENTO_CARDIACO_MAX = 220 - (p -> idade);
} /* end calcula_Max_Batimento */

/* calculate IMC */
void calcula_IMC(MEU_TIPO * p)
{ /*
  IMC = peso/altura^2   
*/
	p -> IMC = (p -> weight)/(p -> height * p -> height);
} /* end calcula_IMC */


/* output data */
void imprime_SAIDA(MEU_TIPO p)
{
	printf("\nPESO (quilos): %2.2f\n", p.weight);
	printf("ALTURA (mts.cm): %2.2f\n", p.height);
	printf("IMC VALUES: %2.2f\n", p.IMC);
} /* end imprime_SAIDA */

/***************************************************/
