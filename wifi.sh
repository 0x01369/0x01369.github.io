#!/bin/bash
 
IFACE=wlan0
 
sudo iw dev $IFACE scan | awk '
    BEGIN{print "\r\nMAC\t\t\tSignal\tESSID\t\t\t\tChannel\tWPS\t\tManufacturer\tModel\tModel Number\tDevice name"} 
    /BSS [a-z0-9:]{10}/{print ""; printf substr($2,1,17)} 
    /signal: /{printf "\t"$2"\t"} 
    /SSID: /{system("echo \""$2"\"............................. | cut -c -25 | head -c -1")} 
    /DS Parameter set/{printf"\t"$5} 
    /Protected/{printf "\t"$6$7} 
    /Manufacturer/{printf "\t"$3} 
    /Model:/{printf "\t\t"$3} 
    /Model Number:/{printf "\t"$4} 
    /Device name:/{printf "\t\t"$4$5}';
echo
