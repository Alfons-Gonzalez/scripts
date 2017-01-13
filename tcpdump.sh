#!/bin/sh
# exemples d'us de tcpdump
#
# basic (S Print absolute sequence numbers)
tcpdump -nS
# mes explicit (vv: very verbose)
tcpdump -nnvvS
# per veure traffic d'un host determinat
tcpdump host 1.2.3.4
# per src IP
tcpdump src 2.3.4.5
# per dst IP
tcpdump dst 3.4.5.6
# per subxarxa
tcpdump net 1.2.3.0/24
# per protocol
tcpdump icmp
# per port
tcpdump port 80
# combinem per src IP i dst port
tcpdump dst port 8095 and src host 193.146.190.19
# capturar cap a un fitxer
tcpdump port 80 -w fixter_captura
# llegir del fitxer
tcpdump -r  fixter_captura
# capturar traffic de una subxarxa cap a una altra
tcpdump -nv src net 192.168.0.0/16 and dst net 10.0.0.0/8
# agrupant, per capturar amb src IP i dos possibles dst ports
tcpdump 'src 10.0.2.4 and (dst port 3389 or 22)'
