#!/bin/bash

prefix2ip()
{
    local ui32=$1; shift
    local ip n
    for n in 1 2 3 4; do
        ip=$((ui32 & 0xff))${ip:+.}$ip
        ui32=$((ui32 >> 8))
    done
    echo $ip
}

netmask()
{
    local mask=$((0xffffffff << (32 - $1))); shift
    prefix2ip $mask
}

ip=$(awk -F/ '{print $1}' <<< $1); prefix=$(awk -F/ '{print $2}' <<< $1)
mask=$(netmask $prefix)

IFS=. read -r i1 i2 i3 i4 <<< "$ip"
IFS=. read -r m1 m2 m3 m4 <<< "$mask"

echo "Total number of IP Addresses: $((2 ** $prefix))"
echo "First IP:   $((i1 & m1)).$((i2 & m2)).$((i3 & m3)).$((i4 & m4))"
echo "Last IP: $((i1 & m1 | 255-m1)).$((i2 & m2 | 255-m2)).$((i3 & m3 | 255-m3)).$((i4 & m4 | 255-m4))"
echo "Host Mininum IP:  $((i1 & m1)).$((i2 & m2)).$((i3 & m3)).$(((i4 & m4)+1))"
echo "Host Maximum IP:   $((i1 & m1 | 255-m1)).$((i2 & m2 | 255-m2)).$((i3 & m3 | 255-m3)).$(((i4 & m4 | 255-m4)-1))"
