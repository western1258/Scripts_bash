#!/usr/bin/bash
#descubrir que shell utiliza un usuario

echo $(cat /etc/passwd |grep "$1" | cut -d ":" -f 7 )
