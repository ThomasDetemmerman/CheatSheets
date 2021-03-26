# Kubectl

## Apply all configurations in current dir

kubectl apply -f .

## View internal and external Ip's from services

kubectl get service (-A) (-n mijnNameSpace)
Je kan enkel describe pod doen bij niet default namespace als je '-n' gebruikt
## Info

kubectl describe pod myPod
kubectl describe service myService

## Quiz

| Column 1       | Column 2     | 
| :------------- | :---------- |
|  find a pod when you don't know the namespace | kubectl get pods --all-namespaces   | 
| Create a deployment YAML file but you don't know the structure | kubectl create deployment --image=nginx nginx --dry-run=client -o yaml > nginx-deployment.yaml | 
|  Show all pods with their labels | kubectl get pods --show-labels   | 
|  Show pods with label env=prod and tier=backend| kubectl get pods --selector (-l) env=prod,tier=backend  |
| Taint node Node01 so it only allows production applications. Already running nonprod applications should be evicted | kubectl taint nodes Node01 env=prod:NoExecute |
| What are the three taint effects? | NoExecute, NoSchedule, PreferNoSchedule |
| Where are the manifests stored used to run the pods that control the cluster | /etc/kubernetes/manifests |
| Which nodes/pods consume the most resources | kubectl top nodes/pods |
| Show **live** the logs of the second container (c2) of pod p1 | kubectl logs **-f** p1 c2 |
| Show the logs of all pods in a deployment. These pods have a label called name=app1 | kubectl logs -l (--selector) name=app1 |


