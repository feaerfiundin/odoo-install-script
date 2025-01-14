#!/bin/bash
#-----------------------------------
# Calcolare risorse per odoo
#-----------------------------------
# Recuperare risorse pc

#INSTALL_PG_SERVER="True"

echo -e "---- Calcolo delle risorse necessarie per Odoo ----"

# Ricava numero Thread per cpu
THREAD=$(lscpu | grep 'Thread' | awk '/a/ {print $4 }')

# Numero Cpu delprocessore
CPU=$(nproc)

# Ricava Memoria Totale del sistema
MEMORIA_TOTALE_KB=$(grep MemTotal /proc/meminfo | awk '/a/ {print $2}')
MEMORIA_TOTALE=$(($MEMORIA_TOTALE_KB * 1024))

# Riserva parte delle risorse per il sistema e se presente per PostregreSQL
if [ $INSTALL_PG_SERVER == "True" ]; then
    CPU_UTILIZZABILI=$(($CPU / 2))
    MEMORIA_UTILIZZABILE_KB=$(($MEMORIA_TOTALE * 90 / 200))
else
    CPU_UTILIZZABILI=$(($CPU - 1))
    MEMORIA_UTILIZZABILE_KB=$(($MEMORIA_TOTALE * 90 / 100))
fi

# Calcola numero massimo Workers Utilizzabili
MAX_WORKERS=$(($THREAD * $CPU_UTILIZZABILI + 1))

# Calcols numero massimo Workers tolto n utenti CRON
if [ $THREAD =1 ];then
    OE_WORKERS=$(($MAX_WORKERS - 2))
else
    OE_WORKERS=$(($MAX_WORKERS -1))
fi
# Calcola Numero Massimo utenti contemporanei
USER=$(($OE_WORKERS * 6))
OE_DB_MAXCONN=$(($USER *10))

# Calcola Numero Richieste prima di riciclare Worker
OE_REQUEST=$(($USER * 5))

# Calcola Limite massimo memoria virtuale per worker prima di effettuare
# kill automatico immediato in byte
OE_HARD_MEMORY=$(($MEMORIA_UTILIZZABILE_KB * 25 / 10 / $MAX_WORKERS))

# Calcola limite massimo memoria virtuale per worker prima di effettuare
# kill automatico alla fine del processo in byte
OE_SOFT_MEMORY=$(($OE_HARD_MEMORY / 25 * 15))
MAX_A_MEM=$(($MAX_WORKERS*325))

echo -e "---- Dati Configurazione Odoo ----"
echo -e "Workers :                                 $OE_WORKERS"
echo -e "Richieste max al DB   :                   $OE_REQUEST"
echo -e "Limite memoria kill immediato :           $OE_HARD_MEMORY"
echo -e "limite memoria kill fine processo :       $OE_SOFT_MEMORY"
echo -e "Totale memoria allocabile in MB   :       $MAX_A_MEM"

export OE_WORKERS
export OE_REQUEST
export OE_DB_MAXCONN
export OE_HARD_MEMORY
export OE_SOFT_MEMORY
