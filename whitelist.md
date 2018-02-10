# Prevent mails from being marked as spam

# SPF
- Type: `TXT record`
- Host: `@`
- Value: `v=spf1 ip4:[ip of mailserver] include:[domain name] ~all`

## test your configuration
- https://mxtoolbox.com/spf.aspx


# DMARC
- Type: `TXT record`
- Host: `_dmarc`
- Value: `v=DMARC1; p=none; rua=mailto:[internal mail]; ruf=mailto:[internal mail]; rf=afrf; pct=100`

## test your configuration
 - https://mxtoolbox.com/dmarc.aspx

# DKIM

```
yum install opendkim
```

```
.
├── opendkim.conf
└── opendkim
      ├── keys
      │   └──[domain.com]
      │       ├── default.private
      │       └── default.txt
      ├── KeyTable
      ├── SigningTable
      └── TrustedHosts
```
## KeyTable
```
default._domainkey.[domain.com] [domain.com]:default:/etc/opendkim/keys/[domain.com]/default.private
```

## SigningTable
```
*@[domain.com] default._domainkey.[domain.com]
```
## TrustedHosts
```
[domain.com]
[FQDN] #hostname.domain.com
127.0.0.1
::1

```

## keys/[domain.com]
```
sudo opendkim-genkey -s default -d [domain.com]
```

** Make sure the keys have the right owenerhsip `opendkim:opendkim` **

### Update the dns record. Copy the public key form default.txt
- Type: `TXT record`
- Host: `default._domainkey`
- Value: `v=DKIM1; k=rsa;  	  p=[public key]`

## opendkim.conf
```
AutoRestart             Yes
AutoRestartRate         10/1h
LogWhy                  Yes
Syslog                  Yes
SyslogSuccess           Yes
Mode                    sv
Canonicalization        relaxed/relaxed # NOT relaxed/simple!!
ExternalIgnoreList      refile:/etc/opendkim/TrustedHosts
InternalHosts           refile:/etc/opendkim/TrustedHosts
KeyTable                refile:/etc/opendkim/KeyTable
SigningTable            refile:/etc/opendkim/SigningTable
SignatureAlgorithm      rsa-sha256
Socket                  inet:8891@localhost
PidFile                 /var/run/opendkim/opendkim.pid
UMask                   022
UserID                  opendkim:opendkim
TemporaryDirectory      /var/tmp
```

## configure postfix

```
smtpd_milters           = inet:127.0.0.1:8891
non_smtpd_milters       = $smtpd_milters
milter_default_action   = accept
milter_protocol         = 2
```

## restart services
```
systemctl restart opendkim
systemctl restart postfix
```
*You might want to enable it too*

# Troubleshooting

If you are looking for log files you are looking on the wrong place. The best way is to send out a mail and verify the header from the received file. For the integrated mail app on an apple device you can click view > message > source (dutch: weergave > bericht > bronsversie). You should look for the following:

```
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@detemmerman.xyz header.s=default header.b=noYKOHMB;
       spf=pass (google.com: domain of test@detemmerman.xyz designates 146.185.135.181 as permitted sender) smtp.mailfrom=test@detemmerman.xyz;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=detemmerman.xyz

Received-SPF: pass (google.com: domain of test@detemmerman.xyz designates 146.185.135.181 as permitted sender) client-ip=146.185.135.181;

Authentication-Results: mx.google.com;
       dkim=pass header.i=@detemmerman.xyz header.s=default header.b=noYKOHMB;
       spf=pass (google.com: domain of test@detemmerman.xyz designates 146.185.135.181 as permitted sender) smtp.mailfrom=test@detemmerman.xyz;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=detemmerman.xyz

DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=detemmerman.xyz;
       	s=default; t=1518292954;
       	bh=3wW+LCUBvWUsUcpLwtFpFcWb2rW6Rm2Ds9D25SHNTKM=;
       	h=From:To:Subject:Date;
       	b=noYKOHMBxqYdO6fCgyZxOAwx6PDnhJxwQs0GSg46k8dw1Vm6c...



```

## sources
- https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-dkim-with-postfix-on-debian-wheezy

- https://www.rosehosting.com/blog/how-to-install-and-integrate-opendkim-with-postfix-on-a-centos-6-vps/
