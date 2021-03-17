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
