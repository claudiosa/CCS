#/bin/bash
#
#
# Script que altera a extensão de vários arquivo de uma vez.
#
#
#
#   Eduardo Carvalho, Novembro de 2011
 
 EXTENSAO_ENTRADA=".JPG.jpg"      # Atual extensão dos arquivos
 EXTENSAO_SAIDA=".jpg"      # Nova extensão que terão os arquivos
 NOME=""            # Nome do arquivo, sem extensão
 NOVO_NOME=""         # Nome do arquivo após ser renomeado
  
  if [ $# -ne 2 ]; then
     echo "$(basename "$0"): erro de operandos"   
        #TODO Try `basename --help' for more information.
           exit 1
           fi
            
            #--- RENOMEIA ---#
            for ARQUIVO in *."$EXTENSAO_ENTRADA"
            do
               NOVO_NOME=$(basename "$ARQUIVO" "$EXTENSAO_ENTRADA")"$EXTENSAO_SAIDA"
                  mv "$ARQUIVO" "$NOVO_NOME" && echo " $ARQUIVO -> $NOVO_NOME"
                  done