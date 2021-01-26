# Helm charts

1) voeg repo to
helm repo add
helm update
#beiden moeten toev worden
2) helm search repo <releasename>
3) helm show values <repo>/<chartname> > ./values.yml
4) change values file
5) helm upgrade --install  --values ./values.yml <myname> <repo>/<chartname>
6) kubectl get pods

# optional: portforward your created service
1) kubectl get service
2) kubectl port-forward svc/<myName> <port>:<containerPort>
