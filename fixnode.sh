#!/bin/bash


echo 'monroe  ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/02-dev

echo '${ipt4} -A INPUT -p tcp -i eth0 -s 130.243.26.0/23 --dport 22 -j ACCEPT' > /etc/circle.d/100-dev.rules
echo '${ipt4} -A INPUT -p tcp -i eth0 -s 192.168.0.0/16 --dport 22 -j ACCEPT' >> /etc/circle.d/100-dev.rules


sed -ie '/ListenAddress.*/d' /etc/ssh/sshd_config
sed -ie '5iListenAddress 0.0.0.0' /etc/ssh/sshd_config


sed -ie 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
# + possibly change the root shell to /bin/bash
service sshd restart

rm -f /etc/cron.d/{ansible-wrapper,biteback,monroe-experiments}
grub-editenv /.bootos set MAXBOOTCOUNT=99999

chmod u+w /home/monroe/.ssh/authorized_keys
cat<<_EOF >>/home/monroe/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDj2tz15i8Nvi/BGFAQy5Slj9XQhdb7vQiWmXQjLjDd5Qbwm+qKaAFK8mJpGsnkDSc/a9J2tMAhzygcQBJ2gL5P+/lYRnTiiyAgZCA0EbdAiesdnCnnUEbpn1QEOmwAWW69WYQK+MJzTJb6pecZhDOFuU+26+0K1xqW3hcpis4CtLt+M3+WPWeD/5MFc93/lqbj0WwahfOGcLVG5CjZ+ZgtdpzVRELwD4rbUU1b7r4Dd2vHW2ZMdG47o12e+JCRJQ8Tw9ANfhMpkyxi6d07ktxfkBglHWmAT6wUwCxKuxK1d75TE2gNEfD2JWLYGNuvHUMC4vPfsDgrBraQcOfhangl mrajiullah@mrajiullah-HP-EliteBook-820-G2
_EOF

su - monroe -c "ssh-keygen -C monroe@node$(cat /etc/nodeid)"


cat ~monroe/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

passwd -l root
sed -ie 's|/root:/usr/sbin/nologin|/root:/bin/bash|' /etc/passwd

echo 1 > /monroe/development/enabled

echo '192.168.60.10 tptest-int' >> /etc/hosts
echo '127.0.0.1 mobterm-int' >> /etc/hosts

#reboot
