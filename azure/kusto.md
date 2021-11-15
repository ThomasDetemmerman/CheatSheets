# Kusto Qeries (log analytics)

## WAF
```
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.NETWORK" and Category == "ApplicationGatewayFirewallLog"
| where hostname_s == "hostname.be"
| distinct  ruleId_s
```

## Logs from containers forwarded with OMS agent
```
ContainerLog
| where LogEntry contains "ERROR"
| project LogEntry
```
