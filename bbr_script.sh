modprobe -a tcp_bbr
echo bbr > /proc/sys/net/ipv4/tcp_congestion_control
cat /proc/sys/net/ipv4/tcp_congestion_control
