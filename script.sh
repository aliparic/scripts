#!/bin/bash
cc="reno cubic bbr"
for c in $cc
do
echo $c > /proc/sys/net/ipv4/tcp_congestion_control
for i in {1..10}
do
   sh ./script_ss_rmbt.sh
   docker rm -f nettest
   docker rm -f ali_ping
   rm /monroe/results/*PING*
done
done
