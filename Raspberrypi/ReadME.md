# First boot
How to connect to your RaspberryPi without screen nor serial cable?

1. Flash .iso using for ex. Etcher
2. Change the files on the SD-card
3. Enable SSH: create a file called `ssh`
4. Connect to your network:
  1. create a file called `wpa_supplicant.conf`
  2. add the following content: (don't forget to change name en password"
  
```
country=BE
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
network={
  ssid="NAME_OF_NETWORK"
  psk="YOUR_PASSWORD"
  key_mgmt=WPA-PSK
}
```
 
5. Find the IP adress: `sudo nmap -O 192.168.1.0/24`  
   Look for the IP related to the OS called Raspberry Pi Foundation
