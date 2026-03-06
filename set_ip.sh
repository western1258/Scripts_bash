#! /bin/bash
# el archivo de configuracion de ip debe venir con el siguiente orden interfaz, direccion ip,mascara, gateway

while read -r linea;
do
	iface=$(echo "$linea" | cut -d ',' -f 1)
	ip=$(echo "$linea" | cut -d ',' -f 2)
	masc=$(echo "$linea" | cut -d ',' -f 3)
	gate=$(echo "$linea" | cut -d ',' -f 4)

	ip addr add "$ip" "$masc" dev "$iface"
	ip link set "$iface" up
	ip route add default via "$gate" dev "$iface"

done < "$1"
