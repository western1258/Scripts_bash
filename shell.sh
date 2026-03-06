#!/usr/bin/bash

echo $(cat /etc/passwd |grep "$1" | cut -d ":" -f 7 )
