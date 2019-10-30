sed -i -e "s/\#DNSStubListener\=yes/DNSStubListener\=no/" /etc/systemd/resolved.conf
systemctl disable systemd-resolved
systemctl stop systemd-resolved

apt install dnsmasq -y

sed -i -e "s/\#resolv\-file\=/resolv\-file\=\/etc\/resolv\.dnsmasq\.conf/" -e "s/\#strict\-order/strict\-order/" /etc/dnsmasq.conf
echo "log-queries" >> /etc/dnsmasq.conf
echo "log-facility=/var/log/dnsmasq.log" >> /etc/dnsmasq.conf
echo "nameserver 1.1.1.1" > /etc/resolv.dnsmasq.conf 
echo "nameserver 8.8.8.8" >> /etc/resolv.dnsmasq.conf 
echo "nameserver 2606:4700:4700::1111" >> /etc/resolv.dnsmasq.conf 
echo "prepend domain-name-servers 8.8.8.8;" >> /etc/dhcp/dhclient.conf
echo "prepend domain-name-servers 1.1.1.1;" >> /etc/dhcp/dhclient.conf
echo "prepend domain-name-servers 127.0.0.1;" >> /etc/dhcp/dhclient.conf

wget -c https://raw.githubusercontent.com/onlyueu/dnsmasq/master/mobi.conf
mv mobi.conf /etc/dnsmasq.d/

systemctl start dnsmasq
systemctl enable dnsmasq
