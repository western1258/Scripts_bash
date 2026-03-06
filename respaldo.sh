#!/bin/bash

ORIGEN=$1
DESTINO=$2

FECHA=$(date +%Y%m%d)
NOMBRE=$(basename "$ORIGEN")
RESPALDO="$DESTINO/$NOMBRE$FECHA"


cat "$ORIGEN" >> "$RESPALDO"

echo "Nuevo archivo $RESPALDO"
