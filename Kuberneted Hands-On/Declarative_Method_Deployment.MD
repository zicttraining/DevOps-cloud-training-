# To create a deployment in Kubernetes using the declarative method, you need to create a YAML file that describes the desired state of the deployment. Here is an example YAML file:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-container
          image: my-image:latest
          ports:
            - containerPort: 80
```

"""" This YAML file specifies a deployment named my-deployment with three replicas. The deployment selects pods with the label app: my-app and creates pods using a template with the same label. The template specifies a container named my-container with the image my-image:latest and exposes port 80. """"


### To create the deployment using this YAML file, you can use the kubectl apply command:
```
kubectl apply -f deployment.yaml
```

#### This command will create the deployment and its associated pods, replicaset, and other resources in the Kubernetes cluster. If the deployment already exists, kubectl apply will update it to match the desired state specified in the YAML file





















