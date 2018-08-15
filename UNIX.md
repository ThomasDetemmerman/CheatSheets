## interpreter
```bash
#!/usr/bin/env bash
```

## start | stop | restart 

```bash
/etc/init.d/[service]d
```

## start an service without para
```bash
/usr/sbin/[service]d
```

# Infinite loop
while true; do echo 'sleeping' && sleep 9; done

# Delete everyting besides
```bash
find . ! -name "*.mp3" -delete
```

#Find processes
```
# find running processes
ps -e

#find there location (for instance if the command cron is not found but it is installed)
which [process]
```
