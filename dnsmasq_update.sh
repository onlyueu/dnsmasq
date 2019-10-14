rm /etc/dnsmasq.d/domains.conf
rm /etc/dnsmasq.d/adblock-for-dnsmasq.conf
wget -c https://raw.githubusercontent.com/notracking/hosts-blocklists/master/domains.txt
sed -e "s/address\=\/gvt1\.com\//\#address\=\/gvt1\.com\//" -e "s/address\=\/gvt2\.com\//\#address\=\/gvt2\.com\//" < domains.txt > /etc/dnsmasq.d/domains.conf
wget -c https://raw.githubusercontent.com/gentlyx/anti-AD/master/adblock-for-dnsmasq.conf
sed -e "s/address\=\/gvt1\.com\//\#address\=\/gvt1\.com\//" -e "s/address\=\/gvt2\.com\//\#address\=\/gvt2\.com\//" -e "s/address\=\/tag\.\.crsspxl\.com\//\#address\=\/tag\.\.crsspxl\.com\//" < adblock-for-dnsmasq.conf  > /etc/dnsmasq.d/adblock-for-dnsmasq.conf
rm -R domains.txt
rm -R adblock-for-dnsmasq.conf
systemctl restart dnsmasq
