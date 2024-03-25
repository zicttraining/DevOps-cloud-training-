# Here are some basic kubectl commands for Kubernetes:

1. Create a Namespace:
```
kubectl create namespace <namespace_name>
```

2. Create a Label:

```
kubectl label <resource_type> <resource_name> <label_key>=<label_value>
```

3. Add Annotations:
```
kubectl annotate <resource_type> <resource_name> <annotation_key>=<annotation_value>
```

4. Create a Deployment:
```
kubectl create deployment <deployment_name> --image=<image_name>
```

5. Create a Service:
```
kubectl expose deployment <deployment_name> --port=<port_number>
```

6. Scaling Pod Replicas:
```
kubectl scale deployment <deployment_name> --replicas=<replica_count>
```

7. Exec into a Pod:
```
kubectl exec -it <pod_name> -- /bin/bash
```

8. View Pod Logs:
```
kubectl logs <pod_name>
```

9. Describe a Resource:
```
kubectl describe <resource_type> <resource_name>
```

10. View Cluster Events:
```
kubectl get events
```

#### These commands are used to perform various operations such as creating and managing resources, inspecting cluster state, and interacting with pods and deployments in a Kubernetes cluster