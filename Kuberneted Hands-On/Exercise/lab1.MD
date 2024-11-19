**Objective**

  *Deploy a three-tier application on EKS.

  *Use Deployments to manage the frontend, backend, and database.

  *Test the application by curling the frontend service.

  *Perform a rolling update for the frontend.

**Prerequisites**

  *An EKS cluster is set up and kubectl is configured to access it. 

  *Docker images for the frontend, backend, and database (e.g., a custom app, Python Flask for the backend, and MySQL database).

  *Basic understanding of Kubernetes resources.

   
**Step 1: Define the Application**

The application has three components:

  *Frontend: Serves the user interface.
  
  *Backend: Provides the business logic and interacts with the database.
  
  *Database: Stores data.

**Step 2: Create the Deployment YAML**

Create a file named three-tier-app.yaml with the following content:

``code three-tier-app.yaml  ``

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: frontend
        image: nginx:latest # Using Nginx as a frontend image
        volumeMounts:
        - name: frontend-html
          mountPath: /usr/share/nginx/html
      volumes:
      - name: frontend-html
        configMap:
          name: frontend-html-config
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: frontend-html-config
data:
  index.html: |
    <!DOCTYPE html>
    <html>
    <head>
      <title>Frontend App</title>
    </head>
    <body>
      <h1>Welcome to the Frontend!</h1>
      <p>Content from Backend: <span id="backend-data"></span></p>
      <script>
        fetch('http://backend-service:5000/data')
          .then(response => response.json())
          .then(data => {
            document.getElementById('backend-data').textContent = data.message;
          });
      </script>
    </body>
    </html>
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
      - name: backend
        image: python:3.9-slim
        command: ["python3", "-m", "http.server", "5000"]
        env:
        - name: BACKEND_MESSAGE
          value: "Hello from Backend!"
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: database
spec:
  replicas: 1
  selector:
    matchLabels:
      app: database
  template:
    metadata:
      labels:
        app: database
    spec:
      containers:
      - name: database
        image: mysql:8.0
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: password # Set a secure password
        - name: MYSQL_DATABASE
          value: appdb
        ports:
        - containerPort: 3306
---
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  selector:
    app: frontend
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: LoadBalancer
---
apiVersion: v1
kind: Service
metadata:
  name: backend-service
spec:
  selector:
    app: backend
  ports:
  - protocol: TCP
    port: 5000
    targetPort: 5000
---
apiVersion: v1
kind: Service
metadata:
  name: database-service
spec:
  selector:
    app: database
  ports:
  - protocol: TCP
    port: 3306
    targetPort: 3306



```

**Step 3: Apply the Deployment**

Deploy the application:


``kubectl apply -f three-tier-app.yaml``

Verify the resources:

```
kubectl get deployments
kubectl get services
kubectl get pods

```

**Step 4: Test the Frontend**

Find the external IP of the frontend service:


``kubectl get service frontend-service``

Test the frontend using curl:


``curl http://<frontend-service-external-ip>``

You should see the frontend's response, which may include data fetched from the backend and database.

**Step 5: Perform Rolling Updates**

Update the frontend to a new version (v2) while ensuring zero downtime.

Update the image in the Deployment:

```
kubectl set image deployment/frontend frontend=your-frontend-image:v2

Monitor the rollout:


kubectl rollout status deployment/frontend

Check that the frontend is updated:


kubectl describe deployment frontend | grep Image
```

**Step 6: Clean Up Resources**

To remove all resources:


``kubectl delete -f three-tier-app.yaml``

**Key Features in the Exercise**

Three-Tier Architecture: Separate frontend, backend, and database layers for scalability and modularity.

*Load Balancer: Exposes the frontend service to the internet.

*Rolling Updates: Demonstrates updating the frontend without downtime.

*Verification: Validates the deployment with curl.

This exercise provides a comprehensive guide to deploying and managing a three-tier application on EKS.