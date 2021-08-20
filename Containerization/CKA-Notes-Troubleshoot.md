# Troubleshoot & manage a cluster

## Cluster management
You can view how the cluster is configured as follows:
- `kubectl get pods -n kube-system` : If the cluster was bootstrapped (deployed using kubeadm)
- `cat /etc/kubernetes/manifests/****.yaml `: : If the cluster was bootstrapped (deployed using kubeadm). However, this is the default location. Annother location of these static pods can be defined. Then you'll have to use px -aux to find them.
- `cat /lib/systemd/system/*****.service` : If the cluster was manually deployed (the hard way)
- `ps -aux | grep kubelet `: or grep kube-controller-manager
