To deploy a three-tier application on EKS, we’ll set up the following architecture:

Scenario Overview
**Frontend:**

- Uses Nginx to serve an HTML file.
- HTML contains a form that submits data to the backend via a REST API.
- Configured using a ConfigMap.

**Backend:**

- Built using Django, exposing APIs to handle form submissions and connect to the database.
- Configured using a ConfigMap for settings.

**Database:**

- MySQL deployed as a StatefulSet.
- Persistent storage ensures data persistence across pod restarts.

**Key Kubernetes Resources**

- **ConfigMaps:**

  - For frontend HTML and Django backend settings.

**StatefulSet:**

  - For MySQL to manage persistent storage.

**Services:**

  - LoadBalancer for the frontend.
  - ClusterIP for backend and database.

**PersistentVolumes and PersistentVolumeClaims:**

For MySQL data persistence.

**Step-by-Step Guide**

1. **ConfigMap for Frontend HTML**
``code frontend-config.yaml``

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: frontend-html-config
data:
  index.html: |
    <!DOCTYPE html>
    <html>
    <head>
      <title>Three-Tier App</title>
    </head>
    <body>
      <h1>Submit Data to the Backend</h1>
      <form id="dataForm">
        <label for="dataInput">Enter Data:</label>
        <input type="text" id="dataInput" name="data">
        <button type="submit">Submit</button>
      </form>
      <script>
        document.getElementById('dataForm').addEventListener('submit', function(event) {
          event.preventDefault();
          const data = document.getElementById('dataInput').value;
          fetch('http://backend-service:8000/api/data', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ data })
          })
          .then(response => response.json())
          .then(data => alert('Data Submitted: ' + JSON.stringify(data)))
          .catch(error => alert('Error: ' + error));
        });
      </script>
    </body>
    </html>

```

2. **Frontend Deployment**

`` code frontend-deployment.yaml``


``
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
        image: nginx:latest
        volumeMounts:
        - name: frontend-html
          mountPath: /usr/share/nginx/html
      volumes:
      - name: frontend-html
        configMap:
          name: frontend-html-config
---
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  type: LoadBalancer
  selector:
    app: frontend
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
``


3. **ConfigMap for Django Backend**


`` code backend-config.yaml``

``
apiVersion: v1
kind: ConfigMap
metadata:
  name: backend-config
data:
  settings.py: |
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.mysql',
            'NAME': 'appdb',
            'USER': 'root',
            'PASSWORD': 'password',
            'HOST': 'database-service',
            'PORT': '3306',
        }
    }

``

4. **Backend Deployment**


`` code backend.yaml``

```

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
        command: ["sh", "-c", "pip install django mysqlclient && django-admin startproject app && cd app && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
        env:
        - name: DJANGO_SETTINGS_MODULE
          value: app.settings
        volumeMounts:
        - name: backend-config
          mountPath: /app/settings.py
          subPath: settings.py
      volumes:
      - name: backend-config
        configMap:
          name: backend-config
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
    port: 8000
    targetPort: 8000

```

5. **StatefulSet for MySQL**

``code mysql-statefulset.yaml``

```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: database
spec:
  serviceName: database-service-headless
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
      - name: mysql
        image: mysql:8.0
        ports:
        - containerPort: 3306
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: password
        - name: MYSQL_DATABASE
          value: appdb
        volumeMounts:
        - name: mysql-data
          mountPath: /var/lib/mysql
  volumeClaimTemplates:
  - metadata:
      name: mysql-data
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 5Gi
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
---
apiVersion: v1
kind: Service
metadata:
  name: database-service-headless
spec:
  clusterIP: None
  selector:
    app: database
  ports:
  - protocol: TCP
    port: 3306
    targetPort: 3306

```

**Deployment Steps**

 - Apply the YAML files:

```
kubectl apply -f frontend-config.yaml
kubectl apply -f backend-config.yaml
kubectl apply -f frontend-deployment.yaml
kubectl apply -f backend-deployment.yaml
kubectl apply -f mysql-statefulset.yaml

```
**verify the resources:**

Check pods:


``kubectl get pods``

Check services:

``kubectl get services``

Check StatefulSet and PVCs:

``
kubectl get statefulset
kubectl get pvc

``

- Access the frontend application:


  - Get the external IP of the frontend-service:


``kubectl get service frontend-service``

- Open the IP in a browser.
  - Submit data via the form:

   - Enter data in the form and submit.

Verify data insertion into the MySQL database by logging into the MySQL pod.
Validate the architecture:

Confirm data is passed from the frontend to the backend and stored in the MySQL database.