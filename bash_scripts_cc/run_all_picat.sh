#!/bin/bash
for arquivo in *.pi
  do
	    echo -e "================================================================================"
	    echo -e "compilando  e executando $arquivo"
	    if ( timeout 2s picat $arquivo )
	    then 
	    echo -e "SUCESSO ... em: $arquivo"
	    else
	    echo -e "TIMEOUT ... em: $arquivo"
	    fi
	    echo -e "================================================================================"
	    echo -e "FIM DO ARQUIVO: $arquivo"
  done
echo -e "Finalizando TODAS execuções"
