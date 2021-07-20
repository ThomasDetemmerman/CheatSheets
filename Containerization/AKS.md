# Login
```
brew install kubectl # brew upgrade kubectl # installs version 1.19.4
az login
az account set --subscription <subscription>
az aks get-credentials --name <aks name> --resource-group <rg name> --admin
kubectl get nodes
kubectl get pods -n myNamespace

```

# RBAC
```
az role assignment list --assignee <id> --scope /subscriptions/<subid>/resourcegroups/<rg>/providers/Microsoft.ContainerService/managedClusters/<clustername/namespaces/<mynamespace>
```
# Availability Checklist
- A **replica set** with sufficient replicas
- A **horizontal pod autoscaler**, remeber that an HPA can only properly work when you define a resource request limit.
- **Roling update strategy**
  - make sure that only a certain amount of pods are unavailable with **maxUnavailable**
  - **ReadinessProbe**: when performing an update, the old pod will only be deleted once the new pod is ready. If this is not defined, the pod will be discarded as soon as the new pod is created.
- What if a node or zone becomes affected? 
  - AKS cluster can't be deployed cross-region but can span multiple zones. 
  - AKS clusters span 3 different zones. 
  - Ideally, you want your pods to be scheduled across zones and across pods within those zones. This can be achieved using **Pod Topology Spread Constraints**. An example is added below.

```
   apiVersion: apps/v1
   kind: Deployment
   spec:
      strategy:
         rollingUpdate:
            maxSurge: 25%
            maxUnavailable: 25%
         type: RollingUpdate
      template:
         spec:
            topologySpreadConstraints:
            - maxSkew: 1
              topologyKey: topology.kubernetes.io/zone
              whenUnsatisfiable: DoNotSchedule
              labelSelector:
                matchLabels:
                foo: bar
            - maxSkew: 1
              topologyKey: kubernetes.io/hostname
              whenUnsatisfiable: DoNotSchedule
              labelSelector:
                matchLabels:
                foo: bar
```

