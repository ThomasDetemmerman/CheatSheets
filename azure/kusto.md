# Kusto Qeries (log analytics)

## WAF
Difference between "blocked" and "matched": it explains why some rules cannot be found in the portal and hence cannot be disabled. Only rules that have action "matches" can be disabled. A matching rule increases the anomaly score. If a requests matches to much rules, the anomaly score becomes to high. When this happens, it matches the rules that will block the request. So rules that block cannot be disabled because it is core functionality of the app gateway. [source](https://docs.microsoft.com/en-us/azure/web-application-firewall/ag/web-application-firewall-troubleshoot#understanding-waf-logs)
```
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.NETWORK" and Category == "ApplicationGatewayFirewallLog"
| where hostname_s == "host.be"
| where action_s == "Matched"
| distinct  ruleId_s
```

## Logs from containers forwarded with OMS agent
```
ContainerLog
| where LogEntry contains "ERROR"
| project LogEntry
```
