#! /bin/bash
# script para manejo de usuarios

if [ "$EUID" -ne 0 ]; then
	echo "Ejecuta el script con sudo"
	exit
fi
ayuda(){
	echo "El script se usa de la siguiente manera: "
	echo "1) Crear_usuario --> crea un nuevo usuario"
	echo "2) Agregar_a_grupo --> agregar un usuario a un grupo"
	echo "3) Borrar_usuario --> borrar un usuario del sistema"
	echo "4) Salir del script"
	

}


OPTIONS="Crear_usuario Agregar_a_grupo Borrar_usuario salir"

select opt in $OPTIONS; do
	case "$opt" in
		
	salir)
		echo done
		exit
		;;
	
	Crear_usuario)
		read -p "Usuario: " usuario
		if id "$usuario" &>/dev/null; then
			echo "El usuario ya existe"
		else	
		read -p "Nombre completo: " nombre
		read -p "Numero de cuarto: " cuarto
		read -p "Telefono trabajo: " teltrab
		read -p "Telefono casa: " telcasa
		read -p "Otro dato: " otro
		read -p "Shell de preferencia: " shell
		

			sudo useradd -m -s "$shell" -c "$nombre,$cuarto,$teltrab,$telcasa,$otro" "$usuario"
			echo "Usuario creado con shel $shell"
			sudo passwd "$usuario"
		fi
		;;

	
	Agregar_a_grupo)
		read -p "Usuario: " usuario
		read -p "Grupo: " grupo

		if getent group "$grupo" > /dev/null; then
			sudo usermod -aG "$grupo" "$usuario"
			echo "Usuario $usuario agregado al grupo $grupo "
		else
			echo "El grupo no existe"
		fi
		;;
	
	Borrar_usuario)
		read -p "Usuario: " usuario

 		if id "$usuario" &>/dev/null; then
			sudo userdel -r "$usuario"
			echo "Usuario $usuario fue borrado"
		else
			echo "El usuario no existe"
		fi
		;;

	*)
		clear
		ayuda
		;;
	esac
done

