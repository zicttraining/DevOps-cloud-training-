# To set up the NGINX Ingress Controller in Kubernetes, follow these steps:

1. Install the NGINX Ingress Controller using Helm:

```
bash
helm repo add nginx-stable https://helm.nginx.com/stable
helm install nginx-ingress nginx-stable/nginx-ingress --set rbac.create=true
```

2. Create an Ingress resource to configure the NGINX Ingress Controller:
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
    - my-domain.com
    secretName: my-secret
  rules:
  - host: my-domain.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

3. Replace my-domain.com, my-secret, and my-service with your own values.

4. Apply the Ingress resource:
```
bash
kubectl apply -f ingress.yaml
```
5. Verify that the Ingress resource is correctly configured:

```
bash
kubectl get ingress my-ingress
```


