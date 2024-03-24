# To configure a Kubernetes Service as a NodePort, you need to define a Service in a YAML configuration file with the type field set to NodePort. 

Here's an example YAML configuration file for a NodePort Service:
```
apiVersion: v1
kind: Service
metadata:
  name: my-service
  labels:
    app: my-app
spec:
  type: NodePort
  ports:
  - name: http
    port: 80
    targetPort: 8080
  selector:
    app: my-app
```

#### In this example, a Service named "my-service" is defined with a selector that targets pods labeled with app: my-app. The Service exposes port 80, which is the port used by clients to access the service, and forwards the traffic to the pods' port 8080. The type field is set to NodePort, and the Service will be assigned a port in the range 30000-32767 by the Kubernetes control plane.

#### After creating the Service definition, you can apply it to your Kubernetes cluster using the kubectl apply command. The NodePort Service will be created and configured automatically by Kubernetes, provided your cluster runs in a supported environment and is configured with the correct cloud load balancer provider package.