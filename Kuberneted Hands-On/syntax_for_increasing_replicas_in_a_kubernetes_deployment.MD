# To increase the number of replicas in a Kubernetes Deployment, you can use the kubectl scale command. The basic syntax is as follows:

```
kubectl scale deployment <deployment-name> --replicas=<number-of-replicas>
```

## For example, to increase the number of replicas to 3 for a Deployment named "my-deployment," you would run:
```
kubectl scale deployment my-deployment --replicas=3
```

#### This command will adjust the Deployment to have the specified number of replicas, and Kubernetes will handle the creation of new pods or termination of existing pods to match the new replica count