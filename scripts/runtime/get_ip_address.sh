#!/bin/bash

IPADDRESS=`/bin/hostname -I | /usr/bin/cut -d' ' -f1`

echo "IPADDRESS: $IPADDRESS" > /tmp/ipaddress.txt
