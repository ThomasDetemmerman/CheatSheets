# Troubleshoot & manage a cluster

## Cluster management

### Control plane
You can view how the cluster is configured as follows:
- `kubectl get pods -n kube-system` : If the cluster was bootstrapped (deployed using kubeadm)
- `cat /etc/kubernetes/manifests/****.yaml `: : If the cluster was bootstrapped (deployed using kubeadm). However, this is the default location. Annother location of these static pods can be defined. Then you'll have to use px -aux to find them.
- `cat /lib/systemd/system/*****.service` : If the cluster was manually deployed (the hard way)
- `ps -aux | grep kube-controller-manager `

 ### Kubelets
 This can not be bootstrapped and is always deployed manually. Therefore, it's a **service**. Hence `ps -aux | grep kubelet`
 
 ### Networking
 Kube proxy 
 - kubeadm deploys it as a deamonsets
 - when you download it manually, you will need to install it manually on all nodes.

## Kubernetes objects

### service
- nodeport:
  - A port on the nodes is allocated
  - TargetPort: port of de pods
  - port: port on de service (the port from where the traffic leaves the service to go to the pod)
  - nodeport: the port on the node
- clusterip
 - IP whitin the cluster. Used for only internal traffic. Ex. backend frontend traffic
- loadbalancers
