# To create a Persistent Volume (PV) in Kubernetes, follow these steps:

1. Create a YAML file for the PV. For example, to create a 1GiB PV using the hostPath provisioner, use the following YAML:

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: demo-pv
spec:
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 1Gi
  hostPath:
    path: /tmp/demo-pv
  storageClassName: standard
```


2. Apply the YAML file to create the PV:

```
kubectl apply -f pv.yaml
```

3. Create a Persistent Volume Claim (PVC) to request the storage. For example, to request a 1GiB PV with the ReadWriteOnce access mode, use the following YAML:

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: demo-pvc
spec:
  storageClassName: standard
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

4. Apply the YAML file to create the PVC:
```
kubectl apply -f pvc.yaml
```

5. The PVC will be automatically bound to the PV that matches its requirements. You can verify the binding using:
```
kubectl get pvc demo-pvc
```

6. Create a Pod that uses the PVC for storage. For example, to create a Pod that uses the demo-pvc, use the following YAML:

```
apiVersion: v1
kind: Pod
metadata:
  name: demo-pod
spec:
  containers:
    - name: demo-container
      image: your-image
      volumeMounts:
        - name: demo-volume
          mountPath: /data
  volumes:
    - name: demo-volume
      persistentVolumeClaim:
        claimName: demo-pvc
```

7. Apply the YAML file to create the Pod:
```
kubectl apply -f pod.yaml
```

#### Now the Pod will have access to the persistent storage provided by the PV
