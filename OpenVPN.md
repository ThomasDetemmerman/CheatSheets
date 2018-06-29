## Setup
https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-an-openvpn-server-on-centos-7

## Creating cert for new client
```bash
cd /etc/openvpn/easy-rsa

./build-key client_name

#make versionless
cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf

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
