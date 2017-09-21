#ifndef FILA_PRIO_PRIV_H
#define FILA_PRIO_PRIV_H

#include "tdaFilaPrio.h"

typedef struct noFila { 
    void *dados;
    struct noFila *atras;
    struct noFila *defronte;
} NoFila;

typedef struct fila { 
    NoFila *frente;
    NoFila *cauda;
    int tamInfo;
} Fila;

#endif
