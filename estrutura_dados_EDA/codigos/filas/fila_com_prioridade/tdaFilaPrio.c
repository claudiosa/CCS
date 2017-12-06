#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tdaFilaPrioPriv.h"
/*#include "tda_ve~1.h"*/

#ifdef debugging
int aux;
#endif

int cria(Fila **pp, int tamInfo)
{
    Fila *desc = (Fila*) malloc(sizeof(Fila));

    if(desc == NULL)
        return FRACASSO;

    desc->frente = NULL;
    desc->cauda = NULL;
    desc->tamInfo = tamInfo;

    return SUCESSO;
}

int testaVazia(Fila *p)
{ 
    if(p->frente == NULL && p->cauda == NULL) {
        return SIM;
    }

    return NAO;
}

int insere(Fila *p, void *novo, int (* cmp)(void *x, void *y))
{ 
    int result;
    NoFila *temp, *temp2;

    if((temp = (NoFila*) malloc(sizeof(NoFila))) == NULL) {
        return FRACASSO;
    }

    if((temp->dados = (void *)malloc(p->tamInfo)) == NULL) { 
        free(temp);
        return FRACASSO;
    }
    memcpy(temp->dados,novo, p->tamInfo);
    if(p->frente == NULL) { /*vazia*/
        temp->atras = NULL;
        temp->defronte = NULL;
        p->frente = temp;
        p->cauda = temp;
    }
    else {  
        temp2 = p->frente; /*maior prioridade na frente */
        while(temp2->atras != NULL && (*cmp)(novo,temp2->dados) != MAIOR ) { /*A>B -> 1*/
            temp2= temp2->atras;
        }
        result = (*cmp)(novo,temp2->dados);
        if(result == MAIOR) { 	
            temp->atras = temp2;
            temp->defronte = temp2->defronte;
            temp2->defronte = temp;
            if(p->frente == temp2) {
                p->frente = temp;
            }
            else {
                temp->defronte->atras = temp;
            }
        }
        else { /*o novo item tem a menor prioridade */
            if(result == MENOR) {	
                temp2->atras = temp;
                temp->atras = NULL;
                temp->defronte = temp2;
                p->cauda = temp;
            }
            else {
                return FRACASSO; /*item já inserido anteriormente*/
            }
        }
    }
#ifdef debugging
    aux = (int)p->frente->dados->RG;
    printf(">>>>>>>>> RG no topo = %i \n", aux);
    system("pause");
#endif

    return SUCESSO;
    /*  getche();*/
}

int buscaNaFrente(Fila *p, void *pReg)
{ 
    if (p->frente == NULL) {
        return FRACASSO;
    }
    memcpy(pReg, p->frente->dados, p->tamInfo);
    return SUCESSO;
}

int buscaNaCauda(Fila *p, void *pReg)
{ 
    if (p->frente == NULL) {
        return FRACASSO;
    }

    memcpy(pReg, p->cauda->dados, p->tamInfo);

    return SUCESSO;
}

int retira(Fila *p, void *pReg)
{
    if (p->frente == NULL) {
        return FRACASSO;
    }

    memcpy(pReg, p->frente->dados, p->tamInfo);
    if(p->frente == p->cauda) { // um único elemento inserido
        free(p->frente->dados);
        free(p->frente);
        p->frente = NULL;
        p->cauda = NULL;
    }
    else {  	
        p->frente = p->frente->atras;
        free(p->frente->defronte->dados);
        free(p->frente->defronte);
        p->frente->defronte = NULL;
    }

    return SUCESSO;
}

int purga(Fila *p)
{   
    int ret = -1;
    
    if (p->frente == NULL)
        ret = FRACASSO;
    else {   
        while(p->frente->atras != NULL) {   
            p->frente = p->frente->atras;
            free(p->frente->defronte->dados);
            free(p->frente->defronte);
        }
        free(p->frente->dados);
        free(p->frente);
        p->frente = NULL;
        p->cauda = NULL;
        ret = SUCESSO;
    }

    return ret;
}

void destroi(Fila **pp)
{ 
    purga(*pp);
    free(*pp);
    *pp = NULL;
}

void vaivem(Fila *p, void (* func)(void* x))
{ 
    NoFila *aux = NULL;

    if (testaVazia(p) == NAO) {
        aux = p->frente;
        while(aux) {  
            func(aux->dados);
            aux = aux->atras;
        }
        aux = p->cauda;
        while(aux) { 
            func(aux->dados);
            aux = aux->defronte;
        }
    }
}
