# To expose a React app with an NGINX Ingress Controller in Kubernetes, follow these steps:

1. Create a Dockerfile for your React app.
```
Dockerfile
FROM node:lts-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:latest
COPY --from=build /app/build/ /usr/share/nginx/html
EXPOSE 80
```

2. Build the Docker image and push it to a registry.

```
docker build -t your-registry/your-image:latest .
docker push your-registry/your-image:latest
```

3. Create a deployment file (deployment.yaml).
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: react-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: react-app
  template:
    metadata:
      labels:
        app: react-app
    spec:
      containers:
        - name: react-app
          image: your-registry/your-image:latest
          ports:
            - containerPort: 80
---
kind: Service
apiVersion: v1
metadata:
  name: react-app
spec:
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  selector:
    app: react-app
```

4. Create an Ingress file (ingress.yaml).

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: react-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
      - your-domain.com
    secretName: your-secret
  rules:
  - host: your-domain.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: react-app
            port:
              number: 80
```

5. Install the NGINX Ingress Controller using Helm.

```
helm repo add nginx-stable https://helm.nginx.com/stable
helm install nginx-ingress nginx-stable/nginx-ingress --set rbac.create=true
```

6. Apply the files.
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```

7. Verify the deployment.
```
kubectl get pods -n <namespace>
kubectl get svc -n <namespace>
kubectl get ingress -n <namespace>
```

8. Access the React app using the Ingress URL.

#### For example, if your Ingress URL is your-domain.com, you can access the React app at https://your-domain.com.

