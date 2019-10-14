sed -i -e "s/\#DNSStubListener\=yes/DNSStubListener\=no/" /etc/systemd/resolved.conf
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved

apt install dnsmasq

sed -i -e "s/\#resolv\-file\=/resolv\-file\=\/etc\/resolv\.dnsmasq\.conf/" -e "s/\#strict\-order/strict\-order/" /etc/dnsmasq.conf
echo "log-queries" >> /etc/dnsmasq.conf
echo "log-facility=/var/log/dnsmasq.log" >> /etc/dnsmasq.conf
echo "nameserver 1.1.1.1" > /etc/resolv.dnsmasq.conf 
echo "nameserver 8.8.8.8" >> /etc/resolv.dnsmasq.conf 
echo "nameserver 2606:4700:4700::1111" >> /etc/resolv.dnsmasq.conf 
sed -i '1inameserver 127.0.0.1' /etc/resolv.conf

systemctl start dnsmasq
systemctl enable dnsmasq
