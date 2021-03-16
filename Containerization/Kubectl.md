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
| You Can Also   | Put Pipes In | 
