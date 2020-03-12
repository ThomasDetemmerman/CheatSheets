# Configure DNS on BBox 2

```
telnet 192.168.1.1
#rg_conf_print /dev/br0/dhcps/dns/
rg_conf_set /dev/br0/dhcps/dns/0/ adresse_ip_primaire
rg_conf_set /dev/br0/dhcps/dns/1/ adresse_ip_secundaire
save
reboot
```
