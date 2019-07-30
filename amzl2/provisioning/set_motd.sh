#!/bin/bash

echo "Setup /etc/motd"
echo "hostname: ${HOSTNAME}"

FILE=/etc/motd
if [ -f "$FILE.orig" ]; then
    echo "File $FILE.orig already exists."
else
    echo "Moving $FILE to $FILE.orig"
    mv $FILE $FILE.orig
fi

echo "Writing original content to $FILE"
cat $FILE.orig > $FILE
echo "Appending text 'hostname: $HOSTNAME' and IP addresses to the end of $FILE"

ip4_priv=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
ip6_priv=$(/sbin/ip -o -6 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
ip4_host=$(/sbin/ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1)
ip6_host=$(/sbin/ip -o -6 addr list eth1 | awk '{print $4}' | cut -d/ -f1)
ip4_pub=$(/sbin/ip -o -4 addr list eth2 | awk '{print $4}' | cut -d/ -f1)
ip6_pub=$(/sbin/ip -o -6 addr list eth2 | awk '{print $4}' | cut -d/ -f1)

(
cat << EOF

hostname: $HOSTNAME

---------------------------------------------------------------------
| --------- | IP v4          | IP v6                                |
| PRIVATE   | $ip4_priv | $ip6_priv |
| HOST ONLY | $ip4_host | $ip6_host |
| PUBLIC    | $ip4_pub | $ip6_pub |
---------------------------------------------------------------------

EOF
) >> $FILE
