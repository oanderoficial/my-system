#!/usr/bin/env bash

#Acesso ROOT. 

[ $UID -ne '0' ] && { echo "Necessário ter Acesso ROOT."; exit 1 ;}

okegreen='033[92m'


funcion_processador (){

       echo "*** Processador ***"
       head -n 29 /proc/cpuinfo

}

funcion_memoria(){

       echo "Memória RAM e SWAP (em MB)"
       free -m
}

funcion_unidades(){
       echo "Unidades montadas"
       df -hT
}

funcion_drives(){
       echo "Driver utilizado pelo X para sua placa de vídeo"
       grep -B1 "/drivers" /var/log/Xorg.0.log | head -n 2
}

funcion_placa(){
       echo "Placa de som "
       aplay -l
}

funcion_resolution(){
       echo "Resolução de telas suportadas"
       xrandr
}

funcion_hostname(){
       echo "Nome do computador (Hostname)"
       hostname
}

funcion_data(){
       echo "Data da instalação"
       ls -lct /etc | tail -1 | awk '{print $6, $7, $8}'
}

funcion_rede(){

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
}

funcion_space(){
       echo "Verificação de espaço em disco"
       df -h
}

funcion_system(){
       echo "Seu Sistema"
       cat /etc/os-release
}

funcion_logs(){
      echo "Verificação de Logs"
      tail -400 /var/log/messages
}
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
        funcion_processador
        ;;

      Memória)
        funcion_memoria
        ;;

      Unidades/montadas)
        funcion_unidades
        ;;

      Drivers/vídeo)
        funcion_drives
        ;;

      Placa/Som)
        funcion_placa
        ;;

      Resolução/Telas)
        funcion_resolution
        ;;

      Hostname)
        funcion_hostname
        ;;

      Data/Instalação)
        funcion_data
        ;;

      Rede)
       funcion_rede
       ;;

       Espaço/Disco)
       funcion_space
       ;;

      Sistema)
       funcion_system
       ;;

       Logs)
       funcion_logs
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
