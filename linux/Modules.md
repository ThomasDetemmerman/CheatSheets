# Modules


A process that just don't want to be dissabled? For instance bluetooth.d

```
lsmod
```
In order to block bluetooth.d, all modules related to bluetooth.d should be blacklisted

```
vim /etc/modprobe.d/blacklist.conf
```
No problem if it doesn't exist yet, it will be picked up.

```
blacklist bluetooth.d
blacklist other_related_modules
```
Persist changes
```
update-initramfs -u
reboot
```

Still doesn't work?
```
vim /etc/modprobe.d/blacklist.conf
install bluetooth.d /bin/true
```
Note: There is no need to define the other dependent modules 

## Source
https://linuxconfig.org/how-to-blacklist-a-module-on-ubuntu-debian-linux 
