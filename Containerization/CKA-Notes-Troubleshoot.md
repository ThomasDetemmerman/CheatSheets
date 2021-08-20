# Troubleshoot & manage a cluster

## Cluster management
You can view how the cluster is configured as follows:
- `kubectl get pods -n kube-system` : If the cluster was bootstrapped (deployed using kubeadm)
- `cat /lib/systemd/system/*****.service` : If the cluster was manually deployed (the hard way)
- `ps -aux | grep kubelet `
