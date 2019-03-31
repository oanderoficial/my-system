#!/usr/bin/env bash

#Acesso ROOT. 

[ $UID -ne '0' ] && { echo "Necessário ter Acesso ROOT."; exit 1 ;}

okegreen='\033[92m'

echo -e $okegreen "
 ____ ____ ____ ____ ____ ____ ____ ____ ____
||M |||y |||- |||S |||y |||s |||t |||e |||m ||
||__|||__|||__|||__|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
"
echo "Autor: Anderson.b.Silva"
echo ""

select i in Processador Memória Unidades/montadas Drivers/vídeo Placa/Som Resolução/Telas Hostname Data/Instalação Rede Espaço/Disco Sistema Logs sair
do

   case "$i" in

      Processador)
         echo "*** Processador ***"
         head -n 29 /proc/cpuinfo
         ;;

      Memória)
        echo "Memória RAM e SWAP (em MB)"
        free -m
         ;;

      Unidades/montadas)
         echo "Unidades montadas"
         df -hT
         ;;

      Drivers/vídeo)
        echo "Driver utilizado pelo X para sua placa de vídeo"
        grep -B1 "/drivers" /var/log/Xorg.0.log | head -n 2
         ;;

      Placa/Som)
        echo "Placa de som "
        aplay -l
         ;;

      Resolução/Telas)
        echo "Resolução de telas suportadas"
        xrandr
         ;;

      Hostname)
        echo "Nome do computador (Hostname)"
        hostname
         ;;

      Data/Instalação)
        echo "Data da instalação"
        ls -lct /etc | tail -1 | awk '{print $6, $7, $8}'
         ;;

      Mídias)
        echo "Data da instalação"
        ls -lct /etc | tail -1 | awk '{print $6, $7, $8}'
         ;;

      Rede)
        echo "Rede"
        echo -e "[+] Verificando conexao com a Internet..."
        sleep 0.15
        echo -e " um momento!\n"
        ping -c 1 google.com &> /dev/null
          if [ $? -gt 0 ]; then
          ping -c 1 uol.com.br &> /dev/null
        	if [ $? -gt 0 ]; then
          echo "Verifique sua conexao..."
          echo ""
           exit 1
          	fi
             fi
          echo -e "[+] Internet OK!\n"
          sleep 0.15

           ;;

       Espaço/Disco)
       echo "Verificação de espaço em disco"
       df -h
          ;;

      Sistema)
       echo "Seu Sistema"
       cat /etc/os-release
          ;;

       Logs)
       echo "Verificação de Logs"
       tail -400 /var/log/messages
          ;;

       sair)
         echo "See you later!"
         break
         ;;

      *)
         echo "opcao invalida, tente novamente"
         ;;


   esac

done

exit 0
