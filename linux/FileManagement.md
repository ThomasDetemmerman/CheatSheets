Show all connected devices

```
fdisk -l
```

Add partition

```
fdisk path
> n (for "new")
> d (for default)
> w (for write
```

format device as ext4

```
mkfs -t ext4 /dev/sda1
```

mount temporarily

```
mkdir /volume
mount  /dev/sda1 /volume
chmod 777 -R /volume
```

list all free space (test)
```
df -h
```

mount infinitely
```
vim /etc/fstab
#als het apparaat vaak verwisseld wordt van poort is het beter om op basis van GUID te mounten. 
#dit is hier niet het geval dus padnaam is voldoende
/dev/sda1 /media/tm ext4 defaults 0 2
#source dest disk-format permissions
```
