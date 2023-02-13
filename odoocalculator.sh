#!/bin/bash
#-----------------------------------
# Calcolare risorse per odoo
#-----------------------------------
# Recuperare risorse pc

THREAD=$(lscpu | grep 'Thread' | awk '/a/ {print $4 }')
CPU=$(nproc)

CPU_UTILIZZABILI=$(($CPU-1))

MEMORIA_TOTALE_KB=$(grep MemTotal /proc/meminfo | awk '/a/ {print $2}')
MEMORIA_UTILIZZABILE_KB=$(($MEMORIA_TOTALE_KB*70*1024/100))
MAX_WORKERS=$(($THREAD*$CPU_UTILIZZABILI+1))
OE_WORKERS=$(($MAX_WORKERS-1))
USER=$(($WORKERS*6))
REQUEST=$(($USER*10))

MAX_MEMORY=$(($MEMORIA_UTILIZZABILE_KB*3/$MAX_WORKERS))
MIN_MEMORY=$(($MAX_MEMORY/25*10))


echo "THREAD            =           $THREAD"
echo "CPU               =           $CPU"
echo "CPU utilizzabili  =           $CPU_UTILIZZABILI"
echo "MEM TOTALE KB     =           $MEMORIA_TOTALE_KB"
echo "MEM UTIL   KB     =           $MEMORIA_UTILIZZABILE_KB"
echo "MAX_WORKER        =           $MAX_WORKERS"
echo "WORKERS           =           $WORKERS"
echo "MAX USER/request  =           $USER"
echo "MIN USER MEM      =           $MIN_MEMORY"
echo "MAX USER MEM      =           $MAX_MEMORY"
echo "MAX TOT USED MEM  =           $MAX_TOTAL_USED_MEMORY"
