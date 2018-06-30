#  autoreload service on crash
```
vim /etc/systemd/system/[service].service
```

```
[service]
Restart=always
RestartSec=3
```
 restart systemctl (ironically)
 ```
 systemctl daemon-reload
 systemctl restart [service]
 ```
