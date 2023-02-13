#!/bin/bash
#-----------------------------------
# Calcolare risorse per odoo
#-----------------------------------
# Recuperare risorse pc

THREAD=$(lscpu | grep 'Thread' | awk '/a/ {print $4 }')
CPU=$(nproc)
CPU_UTILIZZABILI=$("$CPU"-1)
MEMORIA_TOTALE_KB=$(grep MemTotal /proc/meminfo | awk '/a/ {print $2}')
MEMORIA_UTILIZZABILE_KB=$("$MEMORIA_TOTALE_KB"*0,70)
MAX_WORKERS=$THREAD*$CPU_UTILIZZABILI+1
WORKERS=$MAX_WORKERS-1
USER=$($WORKERS*6)
MIN_MEMORY=($MEMORIA_UTILIZZABILE_KB*1024/$MAX_UTENTI)/0,8
MAX_MEMORY=($MEMORIA_UTILIZZABILE_KB*1024/$MAX_MEMORY)/0,2

echo "THREAD            =           $THREAD"/n
echo "CPU               =           $CPU"/n
echo "CPU utilizzabili  =           $CPU_UTILIZZABILI"/n
echo "MEM TOTALE KB     =           $MEMORIA_TOTALE_KB"/n
echo "MEM UTIL   KB     =           $MEMORIA_UTILIZZABILE_KB"/n
echo "MAX_WORKER        =           $MAX_WORKERS"/n
echo "WORKERS           =           $WORKERS"/n
echo "MAX USER/request  =           $USER"/n
echo "MiX USER MEM      =           $MIN_MEMORY"/n
echo "MAX USER MEM      =           $MAX_MEMORY"/n
