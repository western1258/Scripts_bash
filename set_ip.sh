#! /bin/bash
# el archivo de configuracion de ip debe venir con el siguiente orden interfaz, direccion ip/prefijo, gateway

while read -r linea;
do
	iface=$(echo "$linea" | cut -d ',' -f 1)
	ip=$(echo "$linea" | cut -d ',' -f 2)
	gate=$(echo "$linea" | cut -d ',' -f 3)

	ip addr add "$ip" dev "$iface"
	ip link set "$iface" up
	ip route add default via "$gate" dev "$iface"

done < "$1"
