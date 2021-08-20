# Troubleshoot & manage a cluster

## Cluster management

### Upgrade an AKS cluster

** Master node **
1. kubectl drain master
2. kubectl cordon master #this is not needed unless you do have 'user' pods running on master which you shouldn't.
3. apt-get update
4. apt install kubeadm=1.20.0-00 #apt-get install -y --allow-change-held-packages kubeadm=1.20.0-00 #preperations.
5. kubeadm version
6. kubeadm upgrade apply v1.20.0 #upgrade cluster
7. kubectl version --short # server is upgraded
8. apt install kubelet=1.20.0-00 #kubectl get nodes will return the old version. This is because the kubelet is not updated on the master.
9. kubectl uncordon master
10. `kubectl cordon node01 && kubectl drain node01`
** node01 **
11. apt install kubeadm=1.20.0-00
12. kubeadm upgrade node
13. apt install kubelet=1.20.0-00
** Master node **
14. kubectl uncordon node01


[More info](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)

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

### pods: args and commands
![afbeelding](https://user-images.githubusercontent.com/10938144/130236209-e118f3f1-a28c-4e3e-8885-437c040b5af9.png)

