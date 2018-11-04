# Install VirtualBox Guest Additions in Debian.

```sh
echo deb http://ftp.debian.org/debian stretch-backports main contrib > /etc/apt/sources.list.d/stretch-backports.list
apt update
apt install virtualbox-guest-dkms virtualbox-guest-x11 linux-headers-$(uname -r)
```
