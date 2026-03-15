#!/usr/bin/bash

source "$(dirname $0)/utils.sh"

ayuda(){
	echo "$(basename $0) dir"
	echo "El script mueve todos los dpdf de un directorio base a un directorio destino conservando subdirectorios"
	echo "Parametros: "
	echo "dirb = Directorio donde se buscaran los pdf"
	echo "dirs = Directorio donde se guardaran los pdf"
}

dirb="$1"
dirs="$(realpath "$2")" || reportar_error "Directorio destino invalido" ayuda

test "$dirb" && test "$dirs" || reportar_error "Debes pasar dos directorios" ayuda

es_pdf(){
    local archivo="$1"
    echo "$archivo" | grep -E "\.pdf$" &> /dev/null
    return $?
}


recolectar(){
	local dir="$1"
	for archivo in "$dir"/*; do
	if test -f "$archivo" && es_pdf "$archivo"; then	
		rel="${archivo#$dirb/}"
		destino="$dirs/$rel"

		mkdir -p "$(dirname "$destino")"
		cp "$archivo" "$destino"
	fi
	done
}

recolectar_en_arbol(){
	local dir_actual="$1"
	recolectar "$dir_actual" "$dirs" 
	for directorio in "$dir_actual"/*; do
		test -d "$directorio" && recolectar_en_arbol "$directorio" "$dirs"
	done
}


recolectar_en_arbol "$dirb" "$dirs"

