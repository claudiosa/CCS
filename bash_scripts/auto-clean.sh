#!/bin/bash
# Script de limpeza e otimização Debian 12 (Btrfs)
# Autor: Claudio/ChatGPT

# Verificação de root
if ! [ "$(id -u)" = 0 ]; then
   echo "Este script precisa ser executado como root"
   exit 1
fi

echo "=== Limpando pacotes e caches do sistema ==="
#apt update
#apt autoremove -y
#apt autoclean -y
#apt clean

echo "=== Limpando caches de usuários ==="
rm -rf /home/*/.cache/*
rm -rf /root/.cache/*

echo "=== Limpando arquivos temporários ==="
rm -rf /tmp/*
rm -rf /var/tmp/*

echo "=== Limpando logs antigos ==="
journalctl --vacuum-time=7d
rm -rf /var/log/*.gz /var/log/*.[0-9] /var/log/*.old

echo "=== Sincronizando memória e liberando caches ==="
sync; echo 3 > /proc/sys/vm/drop_caches

#echo "=== Otimizando partições Btrfs ==="
#for mnt in / /home; do
#    if mount | grep -q "on $mnt type btrfs"; then
#        echo "Otimização em $mnt ..."
#        btrfs filesystem defragment -r -v "$mnt"
#        btrfs balance start -dusage=75 -musage=75 "$mnt"
#    fi
#done

echo "=== Concluído! Sistema limpo e otimizado. ==="
