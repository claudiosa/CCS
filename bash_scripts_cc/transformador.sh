#!/bin/bash
#
# Desenvolvimento: Diogo Menezes <diogolmenezes@globo.com>
# Data: 17/02/2006
#
# Utilizacao: 
# chmod +x transformador.sh
# ./transformador [nome_do_arquivo ou nome_do_diretrio]  [maiuscula ou minuscula]
# 
# Ex: ./transformador /home/usuario  minuscula 
#

clear

echo "##############################################"
echo "##                Transformador             ##"
echo "##############################################"

# Verifica o tipo de conversao.
if [ $2 == 'maiuscula' ];then
   converte='tr [:lower:] [:upper:]'
elif [ $2 == 'minuscula' ];then
   converte='tr [:upper:] [:lower:]'
else
    echo -e "Parametro invalido!\a"
    exit
fi

# Verifica se o parametro e um diretorio
if [ -d$1 ];then
    #Renomeia todo o conteudo do diretorio para maiuscula ou minuscula
    cd $1
    for i in *
    do
        tipo=`echo "$i" | $converte`    
        mv $i $tipo 
    done
    
    if [ $? == '0' ];then
        echo -e "Conversao feita com sucesso!\a"
    fi	
else
    #Renomeia o arquivo para maiuscula ou minuscula
    tipo=`echo "$i" | $converte` 
    mv $i $tipo
       
    if [ $? == '0' ];then
        echo -e "Conversao feita com sucesso!\a"
    fi	
fi	   
