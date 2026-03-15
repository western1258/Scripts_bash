#!/usr/bin/bash

source "$(dirname $0)/utils.sh"

ayuda(){
	echo "$(basename $0) dir"
	echo "El script comprime los archivos del directorio dado de manera recursiva"
	echo "Despues de la instruccion zip, agregar la ruta donde se desea almacenar el zip"
	echo "Parametros: "
	echo "	dir: es el directorio de entrada base"
}

dir="$1"

test "$dir" || reportar_error "Debes pasar un directorio" ayuda

comprimir(){
	local dir="$1"
	for archivo in "$dir"/*;do 
		test -f "$archivo" && zip ./comprimido.zip "$archivo"
	done
}

comprimir_en_arbol(){
	local dir_actual="$1"
	comprimir "$dir_actual"
	for directorio in "$dir_actual"/*;do
		test -d "$directorio" && comprimir_en_arbol "$directorio"
	done
}

comprimir_en_arbol "$dir"
