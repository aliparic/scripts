#!/bin/bash
for i in {1..5}
do
   sh ./script_ss_rmbt.sh
   docker rm -f nettest
   docker rm -f ali_ping
   rm /monroe/results/*PING*
done
