#!/bin/bash
#-----------------------------------
# Calcolare risorse per odoo
#-----------------------------------
# Recuperare risorse pc

THREAD=$(lscpu | grep 'Thread' | awk '/a/ {print $4 }')
CPU=$(nproc)
CPU_UTILIZZABILI=$(CPU-1)
MEMORIA_TOTALE_KB=$(grep MemTotal /proc/meminfo | awk '/a/ {print $2}')

MEMORIA_UTILIZZABILE_KB=$MEMORIA_TOTALE_KB*0,80






