## Setup
https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-an-openvpn-server-on-centos-7

## Creating cert for new client
```bash
cd /etc/openvpn/easy-rsa
source ./vars
./build-key client_name

#make versionless
cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf

```

### example config file
```
client
proto udp
remote [VPN SERVER IP] [PORT] udp
dev tun
topology subnet
pull
user nobody
group nogroup

<ca>
-----BEGIN CERTIFICATE-----
[omitted] #this is for every client the same!
-----END CERTIFICATE-----
</ca>
<cert>
[omitted - the entire file]
</cert>
<key>
[omitted - the entire file]
</key>

```

## Service starten
```bash
systemctl restart openvpn@server.service #server = naam conf file
```
## Boot VPN client
```bash
openvpn --config /var/openvpn/[vpn config name].ovpn --daemon

//running the above as a service
mv [vpn config name].ovpn [vpn config name].conf
systemctl restart openvpn@server.service
```
